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
    }
}