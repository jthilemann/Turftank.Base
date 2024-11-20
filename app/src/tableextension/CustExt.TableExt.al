tableextension 70310 "TURFCust Ext" extends Customer
{
    fields
    {
        field(70301; "TURFZuora ID"; Code[50])
        {
            Caption = 'Zuora ID';
            DataClassification = ToBeClassified;
        }
    }
}