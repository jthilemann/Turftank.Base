page 70337 "TURFResponsibles"
{
    Caption = 'Responsibles';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "TURFResponsible";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the code of the responsible person or group.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description of the responsible person or group.';
                }
            }
        }
    }
}
