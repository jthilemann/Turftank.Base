pageextension 70313 "TURFBase Item Card Ext" extends "Item Card"
{
    layout
    {
        addlast(Replenishment_Production)
        {
            field("TURFOperation Location"; Rec."TURFOperation Location")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Production Location field.';
                TableRelation = "TURFOperation Location".Code;
            }
        }
    }
}