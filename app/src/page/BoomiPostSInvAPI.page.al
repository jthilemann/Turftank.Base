page 70316 "TURFBoomi Post.S.Inv API"
{
    APIPublisher = 'turfTank';
    APIGroup = 'boomi';
    APIVersion = 'v1.0';
    Caption = 'Boomi Posted Invoice API';
    DelayedInsert = true;
    EntityName = 'postedSalesInvoice';
    EntitySetName = 'postedSalesInvoices';
    PageType = API;
    SourceTable = "Sales Invoice Header";
    InsertAllowed = true;
    ModifyAllowed = true;
    ODataKeyFields = SystemId;
    Permissions = tabledata "Sales Invoice Header" = M;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                    Editable = false;
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                    Editable = false;
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field(zuoraInvoiceNo; Rec."TURFZuora Invoice No.")
                {
                    Caption = 'Zuora Invoice No.';
                }
                field(sentToBoomi; Rec."TURFSent to Boomi")
                {
                    Caption = 'Created In Boomi';
                    Editable = false;
                }
                field(zuoraOrderNo; Rec."TURFZuora Order No.")
                {
                    Caption = 'Zuora Order No.';
                    Editable = false;
                }
                field(zuoraAccountNumber; Rec."TURFZuora Account Number")
                {
                    Caption = 'Zuora Account Number';
                    Editable = false;
                }
                field(zuoraSubscriptionNo; Rec."TURFZuora Subscription No.")
                {
                    Caption = 'Zuora Subscription No.';
                }
                field(boomiOrder; Rec."TURFBoomi Order")
                {
                    Caption = 'Boomi Order';
                    Editable = false;
                }
            }
        }
    }
}