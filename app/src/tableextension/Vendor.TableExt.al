tableextension 70323 "TURFVendor" extends Vendor
{
    fields
    {
        field(70301; "TURFPurchase Receipt Email"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Receipt Email';
            ExtendedDatatype = EMail;
            trigger OnValidate()
            begin
                if "TURFPurchase Receipt Email" <> '' then
                    if not IsValidEmail("TURFPurchase Receipt Email") then
                        Error('Invalid email address');
            end;
        }
    }
    local procedure IsValidEmail(EmailAddress: Text): Boolean
    var
        EmailRegex: Text;
    begin
        EmailRegex := '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
        exit(EmailAddress <> '');
    end;
}