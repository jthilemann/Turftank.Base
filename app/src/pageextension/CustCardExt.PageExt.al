pageextension 70319 "TURFCust Card Ext" extends "Customer Card"
{
    layout
    {
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