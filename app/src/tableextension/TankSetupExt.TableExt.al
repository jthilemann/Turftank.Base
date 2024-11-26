tableextension 70315 "TURFTank Setup Ext" extends "TURFTurfTank Setup"
{
    fields
    {
        field(70301; "TURFBoomi Default Order Type"; Code[20])
        {
            Caption = 'Boomi Default Order Type';
            DataClassification = ToBeClassified;
            TableRelation = "TURFOrder Type";
        }
    }
}