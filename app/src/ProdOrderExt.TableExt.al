tableextension 70305 "TURFProd. Order Ext" extends "Production Order"
{
    fields
    {
        field(70301; "TURF Production Start"; Date)
        {
            Caption = 'Production Start';
            DataClassification = ToBeClassified;
        }
        field(70302; "TURF Production End"; Date)
        {
            Caption = 'Production End';
            DataClassification = ToBeClassified;
        }
        field(70303; TURFComment; Text[50])
        {
            Caption = 'Comment';
            DataClassification = ToBeClassified;
        }

    }
}