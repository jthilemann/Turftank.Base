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
    }
}