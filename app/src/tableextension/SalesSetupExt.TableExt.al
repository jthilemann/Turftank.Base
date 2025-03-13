tableextension 70321 "TURFSales Setup Ext" extends "Sales & Receivables Setup"
{
    fields
    {
        field(70301; "TURFQuote Terms & Conditions"; Blob)
        {
            Caption = 'Quote Terms & Conditions';
            DataClassification = ToBeClassified;
        }
    }

    procedure SetTURFQuoteTermsConditions(NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear("TURFQuote Terms & Conditions");
        "TURFQuote Terms & Conditions".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Modify();
    end;

    procedure GetTURFQuoteTermsConditions() WorkDescription: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("TURFQuote Terms & Conditions");
        "TURFQuote Terms & Conditions".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("TURFQuote Terms & Conditions")));
    end;
}