pageextension 70339 "TURFPlanning Worksheet Ext." extends "Planning Worksheet"
{
    layout
    {
        addafter(Description)
        {
            field("TURFQty. in Rel. Prod. Ord."; Rec."TURFQty. in Rel. Prod. Ord.")
            {
                ApplicationArea = Manufacturing;
                ToolTip = 'Specifies the quantity of this item currently in Released Production Orders.';
            }
            field("TURFQty. in Firm. Plan. Prod Ord."; Rec."TURFQty. in Plan. Prod Ord.")
            {
                ApplicationArea = Manufacturing;
                ToolTip = 'Specifies the quantity of this item currently in Firm Planned Production Orders.';
            }
        }
    }
}
