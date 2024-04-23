pageextension 70315 "TURFG/L Account Card Ext" extends "G/L Account Card"
{
    layout
    {
        addlast(General)
        {
            field("TURFEmployee Groups Filter"; Rec."TURFEmployee Groups Filter")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Employee Groups Filter field.';
            }
            field(TURFDescription; Rec.TURFDescription)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Description field.';
            }
        }
    }
}