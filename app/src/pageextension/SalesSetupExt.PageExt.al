pageextension 70329 "TURFSales Setup Ext" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter(General)
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

                field(TURFOrderConfTC; OrderConfTC)
                {
                    ApplicationArea = all;
                    ExtendedDatatype = RichContent;
                    MultiLine = true;
                    Caption = 'Order Confirmation Terms & Conditions';
                    ToolTip = 'Order Confirmation Terms & Conditions';

                    trigger OnValidate()
                    begin
                        Rec.SetTURFOrderConfirmationTermsConditions(OrderConfTC);
                    end;
                }
            }
        }
    }

    var
        QuoteTC, ShipmentTC, OrderConfTC : Text;

    trigger OnOpenPage()
    begin
        QuoteTC := Rec.GetTURFQuoteTermsConditions();
        ShipmentTC := Rec.GetTURFShipmentTermsConditions();
        OrderConfTC := Rec.GetTURFOrderConfirmationTermsConditions();
    end;
}