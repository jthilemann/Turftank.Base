page 70318 "TURFBoomi Data Validation API"
{
    APIPublisher = 'turfTank';
    APIGroup = 'boomi';
    APIVersion = 'v1.0';
    Caption = 'Data Validation';
    DelayedInsert = true;
    EntityName = 'dataValidation';
    EntitySetName = 'dataValidations';
    PageType = API;
    SourceTable = "TURFBoomi Data Validation";
    InsertAllowed = true;
    ModifyAllowed = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId) { }
                field(boomiDataValidation; Rec."Boomi Data Validation") { }
                field(referenceNumber; Rec."Reference Number") { }
                field(zuoraReferenceNo; Rec."Zuora Reference No.") { }
                field(bcDocumentNo; Rec."BC Document No.") { }
                field(customerNo; Rec."Customer No.") { }
                field(createdDate; Rec."Created Date") { }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        case Rec."Boomi Data Validation" of
            "TURFBoomiDataValidation"::SalesOrder:
                GetReferenceDataForSalesOrder();
            "TURFBoomiDataValidation"::Invoice:
                GetReferenceDataForInvoice();
            "TURFBoomiDataValidation"::CreditMemo:
                GetReferenceDataForCreditMemo();
            "TURFBoomiDataValidation"::Payment:
                GetReferenceDataForPayment();
        end;
    end;

    local procedure GetReferenceDataForSalesOrder()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::"Blanket Order");
        SalesHeader.SetRange("TURFZuora Subscription No.", Rec."Reference Number");
        SalesHeader.FindFirst();
        Rec."Zuora Reference No." := SalesHeader."TURFZuora Subscription No.";
        Rec."BC Document No." := SalesHeader."No.";
        Rec."Customer No." := SalesHeader."Sell-to Customer No.";
        Rec."Created Date" := SalesHeader.SystemCreatedAt;
    end;

    local procedure GetReferenceDataForInvoice()
    var
        SalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        SalesInvoiceHeader.SetRange("TURFZuora Invoice No.", Rec."Reference Number");
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.SetRange("TURFZuora Invoice No.", Rec."Reference Number");
        if SalesHeader.FindFirst() then begin
            Rec."Zuora Reference No." := SalesHeader."TURFZuora Invoice No.";
            Rec."BC Document No." := SalesHeader."No.";
            Rec."Customer No." := SalesHeader."Sell-to Customer No.";
            Rec."Created Date" := SalesHeader.SystemCreatedAt;
        end else if SalesInvoiceHeader.FindFirst() then begin
            Rec."Zuora Reference No." := SalesInvoiceHeader."TURFZuora Invoice No.";
            Rec."BC Document No." := SalesInvoiceHeader."No.";
            Rec."Customer No." := SalesInvoiceHeader."Sell-to Customer No.";
            Rec."Created Date" := SalesInvoiceHeader.SystemCreatedAt;
        end else
            clear(Rec);
    end;

    local procedure GetReferenceDataForPayment()
    var
        GenJournalLine: Record "Gen. Journal Line";
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        SalesInvoiceHeader.SetRange("TURFZuora Invoice No.", Rec."Reference Number");
        SalesInvoiceHeader.FindFirst();
        GenJournalLine.SetRange("Account Type", GenJournalLine."Account Type"::Customer);
        GenJournalLine.SetRange("Account No.", SalesInvoiceHeader."Bill-to Customer No.");
        GenJournalLine.SetRange("Applies-to Doc. No.", SalesInvoiceHeader."No.");
#pragma warning disable AA0175
        GenJournalLine.FindFirst();
#pragma warning restore AA0175
        Rec."Zuora Reference No." := SalesInvoiceHeader."TURFZuora Invoice No.";
        Rec."BC Document No." := GenJournalLine."Journal Batch Name";
        Rec."Customer No." := SalesInvoiceHeader."Bill-to Customer No.";
        Rec."Created Date" := GenJournalLine.SystemCreatedAt;
    end;

    local procedure GetReferenceDataForCreditMemo()
    var
        SalesHeader: Record "Sales Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        SalesCrMemoHeader.SetRange("TURFZuora Invoice No.", Rec."Reference Number");
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::"Credit Memo");
        SalesHeader.SetRange("TURFZuora Invoice No.", Rec."Reference Number");
        if SalesHeader.FindFirst() then begin
            Rec."Zuora Reference No." := SalesHeader."TURFZuora Invoice No.";
            Rec."BC Document No." := SalesHeader."No.";
            Rec."Customer No." := SalesHeader."Sell-to Customer No.";
            Rec."Created Date" := SalesHeader.SystemCreatedAt;
        end else
            if SalesCrMemoHeader.FindFirst() then begin
                Rec."Zuora Reference No." := SalesCrMemoHeader."TURFZuora Invoice No.";
                Rec."BC Document No." := SalesCrMemoHeader."No.";
                Rec."Customer No." := SalesCrMemoHeader."Sell-to Customer No.";
                Rec."Created Date" := SalesCrMemoHeader.SystemCreatedAt;
            end else
                clear(Rec);
    end;
}