pageextension 70304 "TURFPosted Sales Inv. Ext" extends "Posted Sales Invoice"
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
            field("TURFSent to Boomi"; Rec."TURFSent to Boomi")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sent to Boomi field.', Comment = '%';
            }
            field("TURFBoomi Order"; Rec."TURFBoomi Order")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TURFBoomi Order field.', Comment = '%';
            }
            field("TURFZuora Order No."; Rec."TURFZuora Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TURFZuora Order No. field.', Comment = '%';
            }
            field("TURFZuora Account Number"; Rec."TURFZuora Account Number")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zuora Account Number field.', Comment = '%';
            }
            field("TURFZuora Subscription No."; Rec."TURFZuora Subscription No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zuora Subscription No. field.', Comment = '%';
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

    actions
    {
        addlast(processing)
        {
            action(TURFGetTax)
            {
                ApplicationArea = All;
                Caption = 'Send to Zuora';
                Image = Download;
                Promoted = false;
                ToolTip = 'Get Tax from Zuora, and create a line with the tax amount.';
                trigger OnAction()
                var
                    TURFBoomiTaxMgt: Codeunit "TURFBoomi Mgt";
                begin
                    TURFBoomiTaxMgt.SendInvoiceToBoomi(Rec);
                end;
            }
        }
    }
}