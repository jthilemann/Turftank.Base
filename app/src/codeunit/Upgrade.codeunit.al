codeunit 70310 TURFUpgrade
{
    internal procedure UpdateExistingCustLedgEntriesWithZuoraInvoiceNo()
    var
        Company: Record Company;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        InvoiceNo: Code[35];
    begin
        if Company.findset(false) then
            repeat
                CustLedgerEntry.ChangeCompany(Company.Name);
                if CustLedgerEntry.FindSet(false) then
                    repeat
                        InvoiceNo := '';
                        case CustLedgerEntry."Document Type" of
                            CustLedgerEntry."Document Type"::Invoice:
                                if SalesInvoiceHeader.get(CustLedgerEntry."Document No.") then
                                    InvoiceNo := SalesInvoiceHeader."TURFZuora Invoice No.";
                            CustLedgerEntry."Document Type"::"Credit Memo":
                                if SalesCrMemoHeader.get(CustLedgerEntry."Document No.") then
                                    InvoiceNo := SalesCrMemoHeader."TURFZuora Invoice No.";
                            CustLedgerEntry."Document Type"::Payment:
                                begin
                                    if CustLedgerEntry."Applies-to Doc. Type" = CustLedgerEntry."Applies-to Doc. Type"::Invoice then
                                        if SalesInvoiceHeader.get(CustLedgerEntry."Applies-to Doc. No.") then
                                            InvoiceNo := SalesInvoiceHeader."TURFZuora Invoice No.";
                                    if CustLedgerEntry."Applies-to Doc. Type" = CustLedgerEntry."Applies-to Doc. Type"::"Credit Memo" then
                                        if SalesCrMemoHeader.get(CustLedgerEntry."Applies-to Doc. No.") then
                                            InvoiceNo := SalesCrMemoHeader."TURFZuora Invoice No.";
                                end;
                        end;
                        if InvoiceNo <> '' then begin
                            CustLedgerEntry."TURFZuora Invoice No." := InvoiceNo;
                            CustLedgerEntry.Modify(false);
                        end;
                    until CustLedgerEntry.Next() = 0;
            until Company.next() = 0;
    end;
}
