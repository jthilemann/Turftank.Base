pageextension 70319 "TURFCust Card Ext" extends "Customer Card"
{
    layout
    {
        addlast(TURFHubspot)
        {
            field("TURFZuora ID"; Rec."TURFZuora ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zuora ID field.', Comment = '%';
            }
        }
    }
}