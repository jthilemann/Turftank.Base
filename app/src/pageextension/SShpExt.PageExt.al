pageextension 70303 "TURFS. Shp. Ext" extends "Posted Sales Shipment"
{
    layout
    {
        addlast(General)
        {
            field("TURFOrder Type"; Rec."TURFOrder Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Type field.';
            }
        }

        addafter("External Document No.")
        {

            field("TURFSales Return Order No."; Rec."TURFSales Return Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Return Order No. field.', Comment = '%';
            }
        }

        addafter(General)
        {
            group(TURFZuora)
            {
                Caption = 'Zuora';
                field("TURFZuora Account Number"; Rec."TURFZuora Account Number")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Zuora Account Number field.', Comment = '%';
                }
                field("TURFZuora Subscription No."; Rec."TURFZuora Subscription No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Zuora Subscription No. field.', Comment = '%';
                }
                field("TURFZuora Invoice No."; Rec."TURFZuora Invoice No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Zuora Ext. Doc. No. field.', Comment = '%';
                }
                field("TURFZuora Order No."; Rec."TURFZuora Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the TURFZuora Order No. field.', Comment = '%';
                }
                field("TURFBoomi Order"; Rec."TURFBoomi Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TURFBoomi Order field.', Comment = '%';
                }
            }
        }
        addafter("Ship-to Contact")
        {
            field("TURF Ship-To E-Mail"; Rec."TURF Ship-To E-Mail")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Ship-to Email field.', Comment = '%';
            }
            field("TURF Phone No."; Rec."TURF Ship-to Phone No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Ship-To Phone No. field.', Comment = '%';
            }
        }
    }
}