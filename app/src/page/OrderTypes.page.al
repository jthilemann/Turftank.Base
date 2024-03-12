page 70301 "TURFOrder Types"
{
    Caption = 'Order Types';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "TURFOrder Type";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Order Type field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}