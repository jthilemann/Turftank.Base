page 70305 "TURFItem Robots"
{
    Caption = 'Item Robot Parts';
    PageType = List;
    UsageCategory = None;
    ApplicationArea = All;
    SourceTable = "TURFItem Robot";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Robot Model"; Rec."Robot Model")
                {
                    ToolTip = 'Specifies the value of the Robot Model field.', Comment = '%';
                }
            }
        }
        area(Factboxes)
        {

        }
    }
}