table 70303 "TURFEmployee Group"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "TURFEmployee Groups";
    LookupPageId = "TURFEmployee Groups";
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Employee Group';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

}