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
        if SalesHeader.FindFirst() then begin
            Rec."Zuora Reference No." := SalesHeader."TURFZuora Subscription No.";
            Rec."BC Document No." := SalesHeader."No.";
            Rec."Customer No." := SalesHeader."Sell-to Customer No.";
            Rec."Created Date" := SalesHeader.SystemCreatedAt;
        end else
            clear(Rec);
    end;

    local procedure GetReferenceDataForInvoice()
    var
        SalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        SalesInvoiceHeader.SetRange("TURFZuora Invoice No.", Rec."Reference Number");
        SalesInvoiceHeader.SetFilter("Pre-Assigned No.", '<>%1', '');
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.SetRange("TURFZuora Invoice No.", Rec."Reference Number");
        if SalesHeader.FindFirst() then begin
            Rec."Zuora Reference No." := SalesHeader."TURFZuora Invoice No.";
            Rec."BC Document No." := SalesHeader."No.";
            Rec."Customer No." := SalesHeader."Sell-to Customer No.";
            Rec."Created Date" := SalesHeader.SystemCreatedAt;
        end else
            if SalesInvoiceHeader.FindFirst() then begin
                Rec."Zuora Reference No." := SalesInvoiceHeader."TURFZuora Invoice No.";
                Rec."BC Document No." := SalesInvoiceHeader."Pre-Assigned No.";
                Rec."Customer No." := SalesInvoiceHeader."Sell-to Customer No.";
                Rec."Created Date" := SalesInvoiceHeader.SystemCreatedAt;
            end else
                clear(Rec);
    end;

    local procedure GetReferenceDataForPayment()
    var
        GenJournalLine: Record "Gen. Journal Line";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        BCDocNoLbl: Label 'BC_%1', Locked = true;
    begin
        CustLedgerEntry.SetCurrentKey("Document No.");
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Payment);
        CustLedgerEntry.SetRange("Document No.", StrSubstNo(BCDocNoLbl, Rec."Reference Number"));
        CustLedgerEntry.SetRange("Customer No.", Rec."Customer No.");
        GenJournalLine.SetRange("Document No.", StrSubstNo(BCDocNoLbl, Rec."Reference Number"));
        GenJournalLine.SetRange("Account Type", GenJournalLine."Account Type"::Customer);
        GenJournalLine.SetRange("Account No.", Rec."Customer No.");
#pragma warning disable AA0175
        if GenJournalLine.FindFirst() then begin
            Rec."Zuora Reference No." := GenJournalLine."External Document No.";
            Rec."BC Document No." := GenJournalLine."Document No.";
            Rec."Customer No." := GenJournalLine."Account No.";
            Rec."Created Date" := GenJournalLine.SystemCreatedAt;
        end else
            if CustLedgerEntry.FindFirst() then begin
                Rec."Zuora Reference No." := Rec."Reference Number";
                Rec."BC Document No." := CustLedgerEntry."Document No.";
                Rec."Customer No." := CustLedgerEntry."Customer No.";
                Rec."Created Date" := CustLedgerEntry.SystemCreatedAt;
            end else
                clear(Rec);

#pragma warning restore AA0175
    end;

    local procedure GetReferenceDataForCreditMemo()
    var
        SalesHeader: Record "Sales Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        SalesCrMemoHeader.SetRange("External Document No.", Rec."Reference Number");
        SalesCrMemoHeader.SetFilter("Pre-Assigned No.", '<>%1', '');
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::"Credit Memo");
        SalesHeader.SetRange("External Document No.", Rec."Reference Number");
        if SalesHeader.FindFirst() then begin
            Rec."Zuora Reference No." := SalesHeader."TURFZuora Invoice No.";
            Rec."BC Document No." := SalesHeader."No.";
            Rec."Customer No." := SalesHeader."Sell-to Customer No.";
            Rec."Created Date" := SalesHeader.SystemCreatedAt;
        end else
            if SalesCrMemoHeader.FindFirst() then begin
                Rec."Zuora Reference No." := SalesCrMemoHeader."TURFZuora Invoice No.";
                Rec."BC Document No." := SalesCrMemoHeader."Pre-Assigned No.";
                Rec."Customer No." := SalesCrMemoHeader."Sell-to Customer No.";
                Rec."Created Date" := SalesCrMemoHeader.SystemCreatedAt;
            end else
                clear(Rec);
    end;
}