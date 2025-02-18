tableextension 70320 "TURF Tank Setup Ext" extends "TURFTurfTank Setup"
{
    fields
    {
        field(70301; "TURFMain Location"; Code[10])
        {
            Caption = 'Main Location';
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
    }
}