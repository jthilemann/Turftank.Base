pageextension 70315 "TURFG/L Account Card Ext" extends "G/L Account Card"
{
    layout
    {
        addlast(General)
        {

            field("TURFEmployee Group Code"; Rec."TURFEmployee Group Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Employee Group Code field.';
            }
            field(TURFDescription; Rec.TURFDescription)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Description field.';
            }
        }
    }
}