pageextension 70311 "TURF R. Prod. Ord. Card Ext" extends "Released Production Order"
{
    layout
    {
        addlast(General)
        {
            field("TURF Production Start"; Rec."TURF Production Start")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TURF Production Start field.';
            }
            field("TURF Production End"; Rec."TURF Production End")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TURF Production End field.';
            }
            field(TURFComment; Rec.TURFComment)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Comment field.';
                MultiLine = true;
            }
        }
    }
}