pageextension 70301 "TURFS. Inv. Ext" extends "Sales invoice"
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
    }
}