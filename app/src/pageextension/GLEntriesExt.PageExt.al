pageextension 70326 "TURFGL Entries Ext" extends "General Ledger Entries"
{
    layout
    {
        addafter(Description)
        {

            field("TURFDescription 2"; Rec."TURFDescription 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Description 2 field.', Comment = '%';
            }
        }
    }
}