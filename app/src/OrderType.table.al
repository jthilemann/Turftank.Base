table 70301 "TURFOrder Type"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Order Type';
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