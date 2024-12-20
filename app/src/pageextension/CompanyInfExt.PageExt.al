pageextension 70320 "TURFCompany Inf. Ext" extends "Company Information"
{
    layout
    {
        addafter("E-Mail")
        {
            field("TURFE-Mail (Purchase)"; Rec."TURFE-Mail (Purchase)")
            {
                ApplicationArea = all;
                ToolTip = 'E-Mail (Purchase)';
                Caption = 'E-Mail (Purchase)';
            }
        }
        addlast(General)
        {
            field("TURFSort Code"; Rec."TURFSort Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sort Code field.';
            }
        }
    }
}
