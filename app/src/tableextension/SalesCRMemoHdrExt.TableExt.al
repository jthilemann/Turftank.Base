tableextension 70316 "TURFSales Cr. Memo Hdr Ext" extends "Sales Cr.Memo Header"
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
            Caption = 'Zuora Cr. Memo No.';
            DataClassification = ToBeClassified;
        }
        field(70308; "TURFSent to Boomi"; DateTime)
        {
            Caption = 'Created In Boomi';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(70309; "TURFZuora Invoice No."; Code[35])
        {
            Caption = 'Zuora Cr. Invoice No.';
            DataClassification = ToBeClassified;
        }
        field(70311; "TURFStripe Reconciled"; Boolean)
        {
            Caption = 'Stripe Reconciled';
            DataClassification = ToBeClassified;
        }
        field(70316; "TURFPayment Identification"; Text[100])
        {
            Caption = 'Payment Identification';
            DataClassification = ToBeClassified;
        }

    }
}