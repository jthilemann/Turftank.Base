pageextension 70309 "TURFBlanket Orders Ext" extends "Blanket Sales Orders"
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