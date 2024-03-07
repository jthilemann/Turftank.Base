tableextension 70302 "TURFSales Inv. Hdr Ext" extends "Sales Invoice Header"
{
    fields
    {
        field(70301; "TURFOrder Type"; Text[20])
        {
            Caption = 'Order Type';
            DataClassification = ToBeClassified;
        }
    }
}