pageextension 70308 "TURFS. Invoice List Ext" extends "Sales Invoice List"
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