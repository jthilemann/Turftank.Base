tableextension 70320 "TURF Tank Setup Ext" extends "TURFTurfTank Setup"
{
    fields
    {
        field(70301; "TURFMain Location"; Code[10])
        {
            Caption = 'Main Location';
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(70302; "TURFWarranty Dimension"; Code[20])
        {
            Caption = 'Warranty Dimension';
            DataClassification = ToBeClassified;
            TableRelation = Dimension.Code;
        }
        field(70303; "TURFWarranty Dimension Value"; Code[20])
        {
            Caption = 'Warranty Dimension Value';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("TURFWarranty Dimension"));
        }
        field(70304; "TURFMarkup Item No."; Code[20])
        {
            Caption = 'Markup Item No.';
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
        }
        field(70305; "TURFMarkup Robot Unit Price"; Decimal)
        {
            Caption = 'Markup Robot Unit Price';
            DataClassification = ToBeClassified;
        }
    }
}