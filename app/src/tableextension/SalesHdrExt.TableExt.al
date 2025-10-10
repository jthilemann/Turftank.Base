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
        field(70317; "TURFWarranty Order"; Boolean)
        {
            Caption = 'Warranty Order';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                TurfTankSetup: Record "TURFTurfTank Setup";
                DimensionManagement: Codeunit DimensionManagement;
                GLSetupShortcutDimCode: array[8] of Code[20];
                DimensionNo: Integer;
                WarrantyDimensionValue: Code[20];
            begin
                TurfTankSetup.GetRecordOnce();
                if '' in [TurfTankSetup."TURFWarranty Dimension", TurfTankSetup."TURFWarranty Dimension Value"] then
                    exit;

                DimensionManagement.GetGLSetup(GLSetupShortcutDimCode);

                case TurfTankSetup."TURFWarranty Dimension" of
                    GLSetupShortcutDimCode[1]:
                        DimensionNo := 1;
                    GLSetupShortcutDimCode[2]:
                        DimensionNo := 2;
                    GLSetupShortcutDimCode[3]:
                        DimensionNo := 3;
                    GLSetupShortcutDimCode[4]:
                        DimensionNo := 4;
                    GLSetupShortcutDimCode[5]:
                        DimensionNo := 5;
                    GLSetupShortcutDimCode[6]:
                        DimensionNo := 6;
                    GLSetupShortcutDimCode[7]:
                        DimensionNo := 7;
                    GLSetupShortcutDimCode[8]:
                        DimensionNo := 8;
                end;

                if DimensionNo > 0 then
                    if "TURFWarranty Order" then
                        Rec.ValidateShortcutDimCode(DimensionNo, TurfTankSetup."TURFWarranty Dimension Value")
                    else
                        Rec.ValidateShortcutDimCode(DimensionNo, WarrantyDimensionValue);
            end;
        }

        field(70330; "TURFZuora Order"; Boolean)
        {
            Caption = 'Zuora Order';
            DataClassification = ToBeClassified;
        }
    }
}