tableextension 70303 "TURFSales Shp. Hdr Ext" extends "Sales Shipment Header"
{
    fields
    {
        field(70301; "TURFOrder Type"; Text[20])
        {
            Caption = 'Order Type';
            DataClassification = ToBeClassified;
            tablerelation = "TURFOrder Type".Code;
        }
        field(70302; "TURF Ship-to Phone No."; Text[30])
        {
            Caption = 'Ship-To Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(70303; "TURF Ship-To E-Mail"; Text[80])
        {
            Caption = 'Ship-to Email';
            ExtendedDatatype = EMail;
        }
        field(70304; "TURFBoomi Order"; Boolean)
        {
            Caption = 'Boomi Order';
            DataClassification = ToBeClassified;
        }
        field(70305; "TURFZuora Account Number"; Code[50])
        {
            Caption = 'Zuora Account Number';
            DataClassification = ToBeClassified;
        }
        field(70306; "TURFZuora Subscription No."; Code[50])
        {
            Caption = 'Zuora Subscription No.';
        }
        field(70307; "TURFZuora Order No."; Code[50])
        {
            Caption = 'Zuora Order No.';
            DataClassification = ToBeClassified;
        }
        field(70309; "TURFZuora Invoice No."; Code[35])
        {
            Caption = 'Zuora Invoice No.';
            DataClassification = ToBeClassified;
        }
        field(70310; "TURFSales Return Order No."; Code[20])
        {
            Caption = 'Sales Return Order No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70317; "TURFWarranty Order"; Boolean)
        {
            Caption = 'Warranty Order';
            DataClassification = ToBeClassified;
        }
    }
}