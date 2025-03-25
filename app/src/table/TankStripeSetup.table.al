table 70308 "TURFTank Stripe Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {

        }

        //You might want to add fields here
        field(2; "Stripe Payments Bank No."; Code[20])
        {
            Caption = 'Stripe Payments Bank';
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
        }
        field(3; "Stripe Fee G/L Account No."; Code[20])
        {
            Caption = 'Stripe Fee G/L Account No.';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(true));
        }
        field(4; "Stripe Base URL"; text[100])
        {
            Caption = 'Stripe Base URL';
            DataClassification = ToBeClassified;
        }
        field(5; "Stripe Bearer Token"; text[150])
        {
            Caption = 'Bearer Token';
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
        }
        field(6; "Stripe Interim Account"; Code[20])
        {
            Caption = 'Stripe Interim Account';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(true));
        }


    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        RecordHasBeenRead: Boolean;

    procedure GetRecordOnce()
    begin
        if RecordHasBeenRead then
            exit;
        Get();
        RecordHasBeenRead := true;
    end;

    procedure InsertIfNotExists()
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert(true);
        end;
    end;


}