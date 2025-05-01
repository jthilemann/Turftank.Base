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
                field(paymentType; PaymentType)
                {
                    Caption = 'Payment Type';
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
                    Caption = 'Zuora Invoice No.';
                    trigger OnValidate()
                    var
                        SalesInvoiceHeader: Record "Sales Invoice Header";
                    begin
                        GetSetup();
                        //UpdateRecFields();
                        Rec.Validate("Account Type", Rec."Account Type"::Customer);
                        SalesInvoiceHeader.SetRange("TURFBoomi Order", true);
                        SalesInvoiceHeader.SetRange("TURFOrder Type", BoomiSetup."TURFBoomi Default Order Type");
                        SalesInvoiceHeader.SetRange("TURFZuora Invoice No.", zuoraInvoiceNo);
                        SalesInvoiceHeader.FindFirst();
                        Rec.Validate("Account No.", SalesInvoiceHeader."Bill-to Customer No.");
                        Rec.Validate("Applies-to Doc. No.", SalesInvoiceHeader."No.");
                    end;
                }
                field(paymentMethodCode; PaymentMethodCode)
                {
                    Caption = 'Payment Method Code';

                    trigger OnValidate()
                    begin
                        GetSetup();
                        GenJournalBatch.Get(BoomiSetup."Cash Rcpt. Jnl. Template Name", PaymentMethodCode);
                        UpdateRecFields();
                    end;
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
        PaymentType: Option "Payment","Refund";
        BoomiSetup: Record "TURFBoomi Setup";
        GenJournalBatch: Record "Gen. Journal Batch";
        ZuoraSubscriptionNumber: Code[50];
        ZuoraInvoiceNo: Code[35];
        PaymentMethodCode: Code[10];

    local procedure GetSetup()
    begin
        if BoomiSetup."Cash Rcpt. Jnl. Template Name" <> '' then
            exit;
        BoomiSetup.GetRecordOnce();
        if PaymentType = PaymentType::Payment then begin
            BoomiSetup.TestField("Cash Rcpt. Jnl. Template Name");
            // BoomiSetup.TestField("Cash Rcpt. Jnl. Batch Name");
            // GenJournalBatch.Get(BoomiSetup."Cash Rcpt. Jnl. Template Name", BoomiSetup."Cash Rcpt. Jnl. Batch Name");
        end else begin

        end;

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
        GenJournalLine.SetRange("Journal Batch Name", GenJournalBatch.Name);
        if GenJournalLine.FindLast() then;

        Rec.validate("Journal Template Name", BoomiSetup."Cash Rcpt. Jnl. Template Name");
        Rec.Validate("Journal Batch Name", GenJournalBatch.Name);
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

