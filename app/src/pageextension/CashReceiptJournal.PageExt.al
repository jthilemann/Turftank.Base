pageextension 70330 "TURFCash Receipt Journal" extends "Cash Receipt Journal"
{
    layout
    {

    }

    actions
    {
        addlast(processing)
        {
            action(TURFApplyStripe)
            {
                Caption = 'Apply Webshop Orders';
                ApplicationArea = all;
                ToolTip = 'Download transactions and apply webshop orders';
                Image = ApplyEntries;
                trigger OnAction()
                var
                    StripeManagement: Codeunit "TURFStripe Management";
                begin
                    StripeManagement.ApplyWebshopOrders(Rec."Journal Template Name", CurrentJnlBatchName);
                end;
            }
        }
    }
}