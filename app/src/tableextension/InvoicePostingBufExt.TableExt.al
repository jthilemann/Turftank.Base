tableextension 70318 "TURFInvoice Posting Buf Ext" extends "Invoice Posting Buffer"
{
    fields
    {
        field(70301; "TURFDescription 2"; Text[50])
        {
            Caption = 'Description 2';
            DataClassification = ToBeClassified;
        }
    }
}