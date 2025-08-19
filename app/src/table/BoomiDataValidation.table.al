table 70309 "TURFBoomi Data Validation"
{
    DataClassification = ToBeClassified;
    TableType = Temporary;

    fields
    {
        field(1; "Boomi Data Validation"; Enum "TURFBoomiDataValidation")
        {
            Caption = 'Boomi Data Validation';
            DataClassification = ToBeClassified;
        }
        field(2; "Reference Number"; Code[50])
        {
            Caption = 'Reference Number';
            DataClassification = ToBeClassified;
        }
        field(3; "Zuora Reference No."; Code[50])
        {
            Caption = 'Zuora Reference No.';
            DataClassification = ToBeClassified;
        }
        field(4; "BC Document No."; Code[50])
        {
            Caption = 'BC Document No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(6; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Boomi Data Validation")
        {
            Clustered = true;
        }
    }
}