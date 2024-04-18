tableextension 70306 "TURFG/L Account Ext" extends "G/L Account"
{
    fields
    {
        field(70301; "TURFEmployee Group Code"; Code[20])
        {
            Caption = 'Employee Group Code';
            DataClassification = ToBeClassified;
            TableRelation = "TURFEmployee Group".Code;
        }
        field(70302; TURFDescription; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
}