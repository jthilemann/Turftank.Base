tableextension 70308 "TURFCurrency Ext" extends Currency
{
    fields
    {
        field(70200; "TURFReport Bank Account"; Code[20])
        {
            Caption = 'Report Bank Information';
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
        }
    }
}