pageextension 70307 "TURFS. Order List Ext" extends "Sales Order List"
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