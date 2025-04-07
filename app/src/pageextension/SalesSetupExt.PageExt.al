pageextension 70329 "TURFSales Setup Ext" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Dynamics 365 Sales")
        {
            group("TURFTerms & Conditions")
            {
                Caption = 'Terms & Conditions';
                field(TURFTerms; QuoteTC)
                {
                    ApplicationArea = all;
                    ExtendedDatatype = RichContent;
                    MultiLine = true;
                    Caption = 'Quote Terms & Conditions';
                    ToolTip = 'Quote Terms & Conditions';

                    trigger OnValidate()
                    begin
                        Rec.SetTURFQuoteTermsConditions(QuoteTC);
                    end;
                }
                field(TURFShipmentTC; ShipmentTC)
                {
                    ApplicationArea = all;
                    ExtendedDatatype = RichContent;
                    MultiLine = true;
                    Caption = 'Shipment Terms & Conditions';
                    ToolTip = 'Shipment Terms & Conditions';

                    trigger OnValidate()
                    begin
                        Rec.SetTURFShipmentTermsConditions(ShipmentTC);
                    end;
                }
            }
        }
    }

    var
        QuoteTC, ShipmentTC : Text;

    trigger OnOpenPage()
    begin
        QuoteTC := Rec.GetTURFQuoteTermsConditions();
        ShipmentTC := Rec.GetTURFShipmentTermsConditions();
    end;
}