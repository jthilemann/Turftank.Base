table 70304 "TURFRobot Model"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "TURFRobot Models";
    LookupPageId = "TURFRobot Models";
    fields
    {
        field(1; Model; Code[100])
        {
            Caption = 'Model';
            DataClassification = ToBeClassified;
        }
        field(2; "Model Name"; Text[100])
        {
            Caption = 'Model Name';
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; Model)
        {
            Clustered = true;
        }
    }
    procedure UpdateRobotModels()
    var
        TURFRobot: Record TURFRobot;
        TURFRobotModel: Record "TURFRobot Model";
    begin
        if TURFRobot.FindSet(false) then
            repeat
                TURFRobotModel.Model := TURFRobot.Model;
                TURFRobotModel."Model Name" := TURFRobot.Model;
                //TODO fix this ugly piece of code when time is
                if not TURFRobotModel.Insert(false) then
                    TURFRobotModel.Modify(false);
            until TURFRobot.Next() = 0;
    end;
}