pageextension 70327 "TURFGL Entries Prev. Ext" extends "G/L Entries Preview"
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