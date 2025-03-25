tableextension 70301 "TURFSales Hdr Ext" extends "Sales Header"
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
        field(70315; "TURFStripe Payment Link"; Text[200])
        {
            Caption = 'Stripe Payment Link';
            DataClassification = ToBeClassified;
        }
        field(70316; "TURFPayment Identification"; Text[100])
        {
            Caption = 'Payment Identification';
            DataClassification = ToBeClassified;
        }
    }
}