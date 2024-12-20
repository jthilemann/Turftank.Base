tableextension 70315 "TURFTUFCompany Information" extends "Company Information"
{
    fields
    {
        field(70301; "TURFE-Mail (Purchase)"; text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'E-Mail (Purchase)';
        }
        field(70302; "TURFSort Code"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sort Code';
        }
    }
}
