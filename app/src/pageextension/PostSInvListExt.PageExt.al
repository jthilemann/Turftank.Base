pageextension 70306 "TURFPost. S. Inv. List Ext" extends "Posted Sales Invoices"
{
    layout
    {
        addlast(Control1)
        {
            field("TURFOrder Type"; Rec."TURFOrder Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Type field.';
            }
        }
    }
}