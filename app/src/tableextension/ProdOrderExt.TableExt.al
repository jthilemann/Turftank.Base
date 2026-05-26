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
        field(70304; "TURFWarehouse/Production"; Enum "TURFWarehouse Production")
        {
            Caption = 'Warehouse/Production';
            DataClassification = ToBeClassified;
        }
        field(70305; TURFShipping; Enum TURFShipping)
        {
            Caption = 'Shipping';
            DataClassification = ToBeClassified;
        }
        field(70306; "TURF Responsible"; Code[20])
        {
            Caption = 'Responsible';
            DataClassification = ToBeClassified;
            TableRelation = "TURFResponsible";
        }
        field(70307; "TURF Printed"; Boolean)
        {
            Caption = 'Printed';
            DataClassification = ToBeClassified;
        }
        field(70308; "TURF Week"; Enum "TURFProd. Week")
        {
            Caption = 'Week';
            DataClassification = ToBeClassified;
        }
        field(70309; "TURF Done"; Boolean)
        {
            Caption = 'Done';
            DataClassification = ToBeClassified;
        }
    }
}