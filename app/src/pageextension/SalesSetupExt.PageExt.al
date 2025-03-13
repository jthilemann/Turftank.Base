pageextension 70329 "TURFSales Setup Ext" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Dynamics 365 Sales")
        {
            group("TURFTerms & Conditions")
            {
                Caption = 'Terms & Conditions';
                field(TURFTerms; Tc)
                {
                    ApplicationArea = all;
                    ExtendedDatatype = RichContent;
                    MultiLine = true;
                    Caption = 'Quote Terms & Conditions';
                    ToolTip = 'Terms & Conditions';

                    trigger OnValidate()
                    begin
                        Rec.SetTURFQuoteTermsConditions(TC);
                    end;
                }
            }
        }
    }

    var
        TC: Text;

    trigger OnOpenPage()
    begin
        TC := Rec.GetTURFQuoteTermsConditions();
    end;
}