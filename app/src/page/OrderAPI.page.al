page 70306 "TURFOrder API"
{
    PageType = API;
    Caption = 'TurfOrder API';
    APIPublisher = 'turfTank';
    APIGroup = 'boomi';
    APIVersion = 'v1.0';
    EntityName = 'order';
    EntitySetName = 'orders';
    SourceTable = "Sales Header";
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    SourceTableView = where("TURFBoomi Order" = const(true));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(billToContactNo; Rec."Bill-to Contact No.")
                {
                    Caption = 'Bill-to Contact No.';
                }

                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(orderDate; Rec."Order Date")
                {
                    Caption = 'Order Date';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(postingDescription; Rec."Posting Description")
                {
                    Caption = 'Posting Description';
                }
                field(salespersonCode; Rec."Salesperson Code")
                {
                    Caption = 'Salesperson Code';
                }
                field(sellToContactNo; Rec."Sell-to Contact No.")
                {
                    Caption = 'Sell-to Contact No.';
                }
                field(sellToCustomerNo; CustomerNo)
                {
                    Caption = 'Sell-to Customer No.';
                    trigger OnValidate()
                    var
                        HubspotSetup: Record "TURFHubspot Setup";
                    begin
                        HubspotSetup.GetRecordOnce();
                        CustomerNo := Copystr(format(CustomerNo).PadLeft(HubspotSetup."Customer No. Length", '0'), 1, 20);
                        Rec.Validate("Sell-to Customer No.", CustomerNo);
                    end;
                }
                field(shipToCode; Rec."Ship-to Code")
                {
                    Caption = 'Ship-to Code';
                }
                field(shipToContact; Rec."Ship-to Contact")
                {
                    Caption = 'Ship-to Contact';
                }
                field(shipmentDate; Rec."Shipment Date")
                {
                    Caption = 'Shipment Date';
                }
                field(yourReference; Rec."Your Reference")
                {
                    Caption = 'Your Reference';
                }
                field(department; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field(zuoraAccountNumber; Rec."TURFZuora Account Number")
                {
                    Caption = 'Zuora Account Number';
                }
                field(zuoraSubscriptionNo; Rec."TURFZuora Subscription No.")
                {
                    Caption = 'Zuora Subscription No.';
                }
                field(orderType; Rec."TURFOrder Type")
                {
                    Caption = 'Order Type';
                }
                field(paymentIdentification; Rec."TURFPayment Identification")
                {
                    Caption = 'Payment Identification';
                }
                field(zuoraOrderNo; Rec."TURFZuora Order No.")
                {
                    Caption = 'Zuora Order No.';
                }
                field(zuoraInvoiceNo; Rec."TURFZuora Invoice No.")
                {
                    Caption = 'Zuora Invoice No.';
                }
                part(orderLines; "TURFOrder Lines API")
                {
                    Caption = 'Lines';
                    EntityName = 'orderline';
                    EntitySetName = 'orderlines';
                    SubPageLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                }
            }
        }
    }

    var
        CustomerNo: Code[20];

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        BoomiSetup: Record "TURFBoomi Setup";
    begin
        Rec."TURFBoomi Order" := true;
        if BoomiSetup.Get() then begin
            Rec."TURFOrder Type" := BoomiSetup."TURFBoomi Default Order Type";
            if BoomiSetup."TURFDef. Boomi Order Location" <> '' then
                Rec.validate("Location Code", BoomiSetup."TURFDef. Boomi Order Location");
        end;
    end;
}