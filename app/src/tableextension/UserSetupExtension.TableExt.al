tableextension 70307 "TURFUser Setup Extension" extends "User Setup"
{
    fields
    {
        field(70301; "TURFEmployee Group"; Code[20])
        {
            Caption = 'Employee Group';
            DataClassification = ToBeClassified;
            TableRelation = "TURFEmployee Group".Code;
        }
    }
}