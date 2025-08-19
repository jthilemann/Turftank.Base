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
        // "TURFBoomiDataValidation"::Invoice:
        //     Exit(GetReferenceDataForInvoice(referenceNumber));
        // "TURFBoomiDataValidation"::CreditMemo:
        //     Exit(GetReferenceDataForCreditMemo(referenceNumber));
        // "TURFBoomiDataValidation"::Payment:
        //     Exit(GetReferenceDataForPayment(referenceNumber));
        end;
    end;

    local procedure GetReferenceDataForSalesOrder(): Text
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
}