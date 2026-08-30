# Report Substitution & Subscription Line Combining Logic

## 1. Report Substitution — [`TURFReport Substitution`](../src/codeunit/ReportSubstitution.codeunit.al)

### Purpose
Codeunit 70313 subscribes to the `OnAfterSubstituteReport` event from `ReportManagement` and replaces standard BC reports with Turf Tank-specific reports, **but only** for documents linked to a subscription (`TURFSubscription No.`).

### Rules

#### Sales Invoice (`S.Invoice`)
| Condition | Result |
|---|---|
| `RecordRef` is **not** `Sales Invoice Header` | No substitution |
| The report being printed is **not** configured in Report Selections for `S.Invoice` | No substitution |
| `SalesInvHeader."TURFSubscription No."` is **empty** | No substitution |
| The invoice **exists** in `TURFSubscr Settlement Document` (settlement document) | No substitution — use original report |
| Invoice has `TURFSubscription No.` and is **not** a settlement document | Substitute with **Report 70312** `TURFTank Contract S. Invoice` |

#### Sales Credit Memo (`S.Cr.Memo`)
| Condition | Result |
|---|---|
| `RecordRef` is **not** `Sales Cr.Memo Header` | No substitution |
| The report being printed is **not** configured in Report Selections for `S.Cr.Memo` | No substitution |
| `SalesCrMemoHeader."TURFSubscription No."` is **empty** | No substitution |
| The credit memo **exists** in `TURFSubscr Settlement Document` (settlement document) | No substitution — use standard report |
| Credit memo has `TURFSubscription No.` and is **not** a settlement document | Substitute with **Report 70314** `TURFTank Contract S. Cr. Memo` |

> **Key principle:** Settlement documents are always printed with the standard BC report — never with the Turf Tank subscription report.

---

## 2. Subscription Line Combining Logic

Applies to both reports:
- [`TURFTank Contract S. Invoice`](../src/report/TankContractSInvoice.report.al) (Report 70312)
- [`TURFTank Contract S. Cr. Memo`](../src/report/TankContractSCrMemo.report.al) (Report 70314)

The logic is identical in both reports — only table names differ (`Sales Invoice Line` vs. `Sales Cr.Memo Line`).

### Prerequisite
The combining logic is only activated if the header has a `TURFSubscription No.` (`Header.TestField("TURFSubscription No.")` is called for each line).

### Step 1 — Pre-calculation (`OnPreDataItem` on `Line`)

Before lines are rendered, all lines with `TURFCombine Line = true` are iterated and the following are accumulated per **Tax Key**:

| Dictionary | Contents |
|---|---|
| `SubscrTaxGroupLineAmounts` | Sum of `Line Amount` |
| `SubscrTaxGroupAmountsExclVAT` | Sum of `Amount` (excl. VAT) |
| `SubscrTaxGroupAmountsInclVAT` | Sum of `Amount Including VAT` |
| `SubscrTaxGroupRepLineNo` | Line number of the **representative** line |

**Tax Key** is a composite value: `TaxGroupCode + '|' + AvaTaxCode`  
→ Lines with different AvaTax codes are kept separate even if they share the same Tax Group.

**Selecting the representative line:**
1. The first line in the group is set as the initial representative.
2. If a robot item exists (`SubscrRobotItemNo`) and a line matches via `TURFPhantom Sku` (or `No.` if Phantom Sku is blank), **that line takes over** as the representative.

**Robot item lookup** (`GetSubscrRobotItemNo`):  
Finds the item number from `TURFSubscr Line` where:
- `Line Type = Period`
- `Is Paint = false`
- `Is Processing Fee = false`
- `Is Implementation Fee = false`

### Step 2 — Rendering (`OnAfterGetRecord` on `Line`)

For each line with `TURFCombine Line = true`:

1. **Always accumulate** VAT lines and totals (SubTotal, InvDisc, Amount, AmountVAT, AmountInclVAT, PaymentDiscOnVAT).
2. **Is the line the representative** for its Tax Key?
   - **Yes →** `IsCombinedSubscrLine := true`
     - Look up the combined description via `GetSubscrCombinedDescription`
     - Set `No.` to `CombinedSubscrItemNo` (if found)
     - Set `Description` to the combined description (and clear `CombinedSubscrDescription` so RDLC does not render it as a second row)
     - Set `CombinedSubscrLineAmount`, `CombinedSubscrAmount`, `CombinedSubscrAmountInclVAT` from the accumulated dictionaries
     - Calculate `FormattedLineAmount` = accumulated `LineAmount`
     - Calculate `FormattedUnitPrice` = accumulated `LineAmount / Quantity` (or `FormattedLineAmount` if `Quantity = 0`)
     - **Render the line**
   - **No →** `CurrReport.Skip()` — the line is not rendered

Lines **without** `TURFCombine Line` are processed normally (standard BC logic).

### Step 3 — Combined description (`GetSubscrCombinedDescription`)

Searches `TURFSubscr Invoice Desc. Map` to find the best description for the combined line:

**Priority 1 — Two-item match:**
- Find a combine line in the same Tax Key
- Use `TURFPhantom Sku` (or `No.`) as `Item No. 1` in the mapping table
- If the mapping entry has an `Item No. 2`, check whether another combine line in the same Tax Key matches `Item No. 2` via `TURFPhantom Sku` (or `No.`)
- If matched → use the mapping's `Description` and set `CombinedSubscrItemNo := Item No. 1`

**Priority 2 — Fallback (single-item match):**
- If no two-item match is found, use the first mapping entry with a blank `Item No. 2` and a non-empty `Description`

**No match:** Return empty string — the original line description is preserved.

### Columns exposed to RDLC

| Column | Contents |
|---|---|
| `IsCombinedSubscrLine` | `true` if the line is a combined representative line |
| `CombinedSubscrDescription` | Combined description (cleared after use) |
| `CombinedSubscrItemNo` | Item number from the mapping |
| `CombinedSubscrAmount` | Total amount excl. VAT for the Tax Key |
| `CombinedSubscrAmountInclVAT` | Total amount incl. VAT for the Tax Key |
| `CombinedSubscrLineAmount` | Total line amount for the Tax Key |

### Differences between Invoice and Credit Memo

| Aspect | Invoice (70312) | Credit Memo (70314) |
|---|---|---|
| Source table | `Sales Invoice Line` | `Sales Cr.Memo Line` |
| `InsertVATAmountLine` | Has `OnBeforeVATAmountLineInsertLine` event | No event |
| `FormatLineValues` | Calls `FormatDocument.SetSalesInvoiceLine` | Calls `FormatDocument.SetSalesCrMemoLine` |
| Bottom texts (payment info) | Populated with bank details and payment terms | Always empty (`''`) |
| `RemainingAmount` | Calculated and displayed | Always `0` |
| `DisplayAdditionalFeeNote` | Can be enabled via request page | Always `false` |
| Job fields (`JobNo`, `JobTaskNo`) | Populated from the line | Always empty (`''`) |
| `GetSubscrCombinedDescription` | Uses `SalesInvLine` variables | Uses `SalesCrMemoLine` variables |
