tableextension 70306 "TURFG/L Account Ext" extends "G/L Account"
{
    fields
    {
        field(70302; TURFDescription; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
}