table 70302 "TURFOperation Location"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "TURFOperation Locations";
    LookupPageId = "TURFOperation Locations";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
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
        key(PK; Code)
        {
            Clustered = true;
        }
    }

}