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