page 70303 "TURFEmployee Groups"
{
    Caption = 'Employee Groups';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "TURFEmployee Group";

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