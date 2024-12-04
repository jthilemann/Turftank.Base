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
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    //var
    //TempGenJournalLine: Record "Gen. Journal Line" temporary;
    begin
        // TempGenJournalLine.Reset();
        // TempGenJournalLine.Copy(Rec);

        // LibraryAPIGeneralJournal.InitializeLine(
        //   Rec, TempGenJournalLine."Line No.", TempGenJournalLine."Document No.", TempGenJournalLine."External Document No.");

        // GraphMgtCustomerPayments.SetCustomerPaymentsValues(Rec, TempGenJournalLine);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Error('Not allowed');
    end;

    trigger OnOpenPage()
    begin
        SetJournalFilters();
    end;

    var
        BoomiSetup: Record "TURFBoomi Setup";
        GenJournalBatch: Record "Gen. Journal Batch";
        GraphMgtCustomerPayments: Codeunit "Graph Mgt - Customer Payments";
        LibraryAPIGeneralJournal: Codeunit "Library API - General Journal";
        ZuoraSubscriptionNumber: Code[50];
        ZuoraInvoiceNo: Code[35];

    local procedure GetSetup()
    begin
        if BoomiSetup."Payment Journal Template Name" <> '' then
            exit;
        BoomiSetup.GetRecordOnce();
        BoomiSetup.TestField("Payment Journal Template Name");
        BoomiSetup.TestField("Payment Journal Batch Name");
        GenJournalBatch.Get(BoomiSetup."Payment Journal Template Name", BoomiSetup."Payment Journal Batch Name");
    end;

    local procedure SetJournalFilters()
    begin
        Rec.SetRange("Journal Template Name", BoomiSetup."Payment Journal Template Name");
        Rec.SetRange("Journal Batch Name", BoomiSetup."Payment Journal Batch Name");
        Rec.SetRange("Document Type", Rec."Document Type"::Payment);
        Rec.SetRange("Account Type", Rec."Account Type"::Customer);
        Rec.SetRange("Applies-to Doc. Type", Rec."Applies-to Doc. Type"::Invoice);
    end;

    local procedure UpdateRecFields()
    var
        GenJournalLine: Record "Gen. Journal Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        GenJournalLine.SetRange("Journal Template Name", BoomiSetup."Payment Journal Template Name");
        GenJournalLine.SetRange("Journal Batch Name", BoomiSetup."Payment Journal Batch Name");
        if GenJournalLine.FindLast() then;

        Rec.validate("Journal Template Name", BoomiSetup."Payment Journal Template Name");
        Rec.Validate("Journal Batch Name", BoomiSetup."Payment Journal Batch Name");
        Rec.Validate("Line No.", GenJournalLine."Line No." + 10000);
        Rec."Journal Batch Id" := GenJournalBatch.SystemId;
        Rec."Document Type" := Rec."Document Type"::Payment;
        Rec."Account Type" := Rec."Account Type"::Customer;
        Rec."Document Date" := Today();
        Rec."VAT Reporting Date" := GeneralLedgerSetup.GetVATDate(Rec."Posting Date", Rec."Document Date");
        Rec."Applies-to Doc. Type" := Rec."Applies-to Doc. Type"::Invoice;
    end;
}

