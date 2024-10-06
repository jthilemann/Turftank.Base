page 70304 "TURFRobot Models"
{
    Caption = 'Robot Models';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "TURFRobot Model";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Model; Rec.Model)
                {
                    ToolTip = 'Specifies the value of the Model field.', Comment = '%';
                }
                field("Model Name"; Rec."Model Name")
                {
                    ToolTip = 'Specifies the value of the Model Name field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(UpdateModels)
            {
                ApplicationArea = All;
                Caption = 'Update Models';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Executes the Update Models action.';
                trigger OnAction();
                begin
                    Rec.UpdateRobotModels();
                end;
            }
        }
    }

}