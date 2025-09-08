pageextension 70319 "TURFCust Card Ext" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("TURFRequire Ext. Doc. No."; Rec."TURFRequire Ext. Doc. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Require Ext. Doc. No. field.', Comment = '%';
            }
        }
        addafter(TURFHubspot)
        {
            group(TURFZuora)
            {
                Caption = 'Zuora';

                field("TURFZuora Account Number"; Rec."TURFZuora Account Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Zuora ID field.', Comment = '%';
                }
            }
            part("TURFBoomi Sucr. List Part"; "TURFBoomi Sucr. List Part")
            {
                ApplicationArea = all;
                SubPageLink = "Customer No." = field("No.");
            }
        }
    }
}