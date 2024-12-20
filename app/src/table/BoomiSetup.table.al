table 70307 "TURFBoomi Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {

        }

        field(2; "TURFBoomi Default Order Type"; Code[20])
        {
            Caption = 'Boomi Default Order Type';
            DataClassification = ToBeClassified;
            TableRelation = "TURFOrder Type";
        }
        field(3; "TURFDef. Boomi Order Location"; Code[10])
        {
            Caption = 'Default Boomi Order Location Code';
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(4; "Cash Rcpt. Jnl. Template Name"; Code[10])
        {
            Caption = 'Cash Receipt Journal Template Name';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name where(Type = const("Gen. Journal Template Type"::"Cash Receipts"));
        }
        field(5; "Cash Rcpt. Jnl. Batch Name"; Code[10])
        {
            Caption = 'Cash Receipt Journal Batch Name';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Cash Rcpt. Jnl. Template Name"));
        }
        field(6; "Default Tax Item"; Code[20])
        {
            Caption = 'Default Tax Item';
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
        }
        field(7; "Tax Estimate URL"; Text[250])
        {
            Caption = 'Tax Estimate URL';
            DataClassification = ToBeClassified;
        }
        field(8; "Boomi Username"; text[50])
        {
            Caption = 'Boomi Username';
            DataClassification = ToBeClassified;
        }
        field(9; "Boomi Password"; Text[50])
        {
            Caption = 'Boomi Password';
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
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