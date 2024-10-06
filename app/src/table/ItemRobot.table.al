table 70305 "TURFItem Robot"
{
    DataClassification = ToBeClassified;
    LookupPageId = "TURFItem Robots";
    DrillDownPageId = "TURFItem Robots";

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
        }
        field(2; "Robot Model"; Code[100])
        {
            Caption = 'Robot Model';
            DataClassification = ToBeClassified;
            TableRelation = "TURFRobot Model";
        }
    }

    keys
    {
        key(PK; "Item No.", "Robot Model")
        {
            Clustered = true;
        }
    }

}