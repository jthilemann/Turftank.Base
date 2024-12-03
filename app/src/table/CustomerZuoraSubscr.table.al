table 70306 "TURFCustomer Zuora Subscr"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(2; "Subscription Number"; Code[50])
        {
            Caption = 'Subscription Number';
            DataClassification = ToBeClassified;
        }
        field(3; CMRR; Decimal)
        {
            Caption = 'CMRR';
        }
        field(4; "List of Products"; text[2048])
        {
            Caption = 'List of Products';
            DataClassification = ToBeClassified;
        }
        field(5; "Contract Effective Date"; Date)
        {
            Caption = 'Contract Effective Date';
            DataClassification = ToBeClassified;
        }
        field(6; "New Renewal Date"; Date)
        {
            Caption = 'New Renewal Date';
            DataClassification = ToBeClassified;
        }
        field(7; Status; Text[30])
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Customer No.", "Subscription Number")
        {
            Clustered = true;
        }
    }

}