page 70314 "TURFBoomi - Customer Payments"
{
    EntityCaption = 'Customer Payment';
    EntitySetCaption = 'Customer Payments';
    DelayedInsert = true;
    APIPublisher = 'turfTank';
    APIGroup = 'boomi';
    APIVersion = 'v1.0';
    ODataKeyFields = SystemId;
    PageType = API;
    EntityName = 'customerPayment';
    EntitySetName = 'customerPayments';
    SourceTable = "Gen. Journal Line";
    Extensible = false;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(zuoraSubscriptionNumber; ZuoraSubscriptionNumber)
                {
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(documentNumber; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(externalDocumentNumber; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field(zuoraInvoiceNo; zuoraInvoiceNo)
                {
                    Caption = 'External Document No.';
                    trigger OnValidate()
                    var
                        SalesInvoiceHeader: Record "Sales Invoice Header";
                    begin
                        GetSetup();
                        UpdateRecFields();
                        Rec.Validate("Account Type", Rec."Account Type"::Customer);
                        SalesInvoiceHeader.SetRange("TURFBoomi Order", true);
                        SalesInvoiceHeader.SetRange("TURFOrder Type", BoomiSetup."TURFBoomi Default Order Type");
                        SalesInvoiceHeader.SetRange("TURFZuora Subscription No.", ZuoraSubscriptionNumber);
                        SalesInvoiceHeader.SetRange("External Document No.", zuoraInvoiceNo);
                        SalesInvoiceHeader.FindFirst();
                        Rec.Validate("Account No.", SalesInvoiceHeader."Bill-to Customer No.");
                        Rec.Validate("Applies-to Doc. No.", SalesInvoiceHeader."No.");
                    end;
                }
                field(paymentMethodCode; Rec."Payment Method Code")
                {
                    Caption = 'Payment Method Code';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(comment; Rec.Comment)
                {
                    Caption = 'Comment';
                }
                field(appliesToDocType; Rec."Applies-to Doc. Type")
                {
                    Caption = 'Applies-to Doc. Type';
                    Editable = false;
                }
                field(appliesToDocNo; Rec."Applies-to Doc. No.")
                {
                    Caption = 'Applies-to Doc. No.';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnModifyRecord(): Boolean
    begin
        Error('Not allowed');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        BCDocNoLbl: Label 'BC_%1', Locked = true;
    begin
        Rec.TestField("Document No.");
        Rec."Document No." := StrSubstNo(BCDocNoLbl, Rec."Document No.");
    end;

    trigger OnOpenPage()
    begin
        SetJournalFilters();
    end;

    var
        BoomiSetup: Record "TURFBoomi Setup";
        GenJournalBatch: Record "Gen. Journal Batch";
        ZuoraSubscriptionNumber: Code[50];
        ZuoraInvoiceNo: Code[35];

    local procedure GetSetup()
    begin
        if BoomiSetup."Cash Rcpt. Jnl. Template Name" <> '' then
            exit;
        BoomiSetup.GetRecordOnce();
        BoomiSetup.TestField("Cash Rcpt. Jnl. Template Name");
        BoomiSetup.TestField("Cash Rcpt. Jnl. Batch Name");
        GenJournalBatch.Get(BoomiSetup."Cash Rcpt. Jnl. Template Name", BoomiSetup."Cash Rcpt. Jnl. Batch Name");
    end;

    local procedure SetJournalFilters()
    begin
        Rec.SetRange("Journal Template Name", BoomiSetup."Cash Rcpt. Jnl. Template Name");
        Rec.SetRange("Journal Batch Name", BoomiSetup."Cash Rcpt. Jnl. Batch Name");
        Rec.SetRange("Document Type", Rec."Document Type"::Payment);
        Rec.SetRange("Account Type", Rec."Account Type"::Customer);
        Rec.SetRange("Applies-to Doc. Type", Rec."Applies-to Doc. Type"::Invoice);
    end;

    local procedure UpdateRecFields()
    var
        GenJournalLine: Record "Gen. Journal Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        GenJournalLine.SetRange("Journal Template Name", BoomiSetup."Cash Rcpt. Jnl. Template Name");
        GenJournalLine.SetRange("Journal Batch Name", BoomiSetup."Cash Rcpt. Jnl. Batch Name");
        if GenJournalLine.FindLast() then;

        Rec.validate("Journal Template Name", BoomiSetup."Cash Rcpt. Jnl. Template Name");
        Rec.Validate("Journal Batch Name", BoomiSetup."Cash Rcpt. Jnl. Batch Name");
        Rec.Validate("Line No.", GenJournalLine."Line No." + 10000);
        Rec."Journal Batch Id" := GenJournalBatch.SystemId;
        Rec."Document Type" := Rec."Document Type"::Payment;
        Rec."Account Type" := Rec."Account Type"::Customer;
        Rec."Bal. Account Type" := GenJournalBatch."Bal. Account Type";
        Rec."Bal. Account No." := GenJournalBatch."Bal. Account No.";
        Rec."Document Date" := Today();
        Rec."VAT Reporting Date" := GeneralLedgerSetup.GetVATDate(Rec."Posting Date", Rec."Document Date");
        Rec."Applies-to Doc. Type" := Rec."Applies-to Doc. Type"::Invoice;
    end;
}

