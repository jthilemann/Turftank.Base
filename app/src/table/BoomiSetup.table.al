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
        field(4; "Payment Journal Template Name"; Code[10])
        {
            Caption = 'Payment Journal Template Name';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name where(Type = const("Gen. Journal Template Type"::"Cash Receipts"));
        }
        field(5; "Payment Journal Batch Name"; Code[10])
        {
            Caption = 'Payment Journal Batch Name';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Payment Journal Template Name"));
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