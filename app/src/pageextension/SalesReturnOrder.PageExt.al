pageextension 70323 "TURFSales Return Order" extends "Sales Return Order"
{
    layout
    {
        addafter(General)
        {
            group(TURFZuora)
            {
                Caption = 'Zuora';
                field("TURFZuora Account Number"; Rec."TURFZuora Account Number")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Zuora Account Number field.', Comment = '%';
                }
                field("TURFZuora Subscription No."; Rec."TURFZuora Subscription No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Zuora Subscription No. field.', Comment = '%';
                }
                field("TURFZuora Order No."; Rec."TURFZuora Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the TURFZuora Order No. field.', Comment = '%';
                }
                field("TURFBoomi Order"; Rec."TURFBoomi Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TURFBoomi Order field.', Comment = '%';
                }
                field("TURFZuora Invoice No."; Rec."TURFZuora Invoice No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Zuora Ext. Doc. No. field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action(TURFGetTax)
            {
                ApplicationArea = All;
                Caption = 'Get Tax from Zuora';
                Image = Download;
                Promoted = false;
                ToolTip = 'Get Tax from Zuora, and create a line with the tax amount.';
                trigger OnAction()
                var
                    TURFBoomiTaxMgt: Codeunit "TURFBoomi Mgt";
                begin
                    TURFBoomiTaxMgt.GetTaxFromZuora(Rec);
                    CurrPage.SalesLines.Page.ForceTotalsCalculation()
                end;
            }
        }
    }
}