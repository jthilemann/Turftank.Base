tableextension 70310 "TURFCust Ext" extends Customer
{
    fields
    {
        field(70301; "TURFZuora Account Number"; Code[50])
        {
            Caption = 'Zuora Account Number';
            DataClassification = ToBeClassified;
        }
    }
}