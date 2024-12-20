pageextension 70322 TURFSalesCrMemoExt extends "Sales Credit Memo"
{
    layout
    {

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
                end;
            }
        }
    }
}