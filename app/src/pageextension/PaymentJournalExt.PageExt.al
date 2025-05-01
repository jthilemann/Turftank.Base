pageextension 70333 TURFPaymentJournalExt extends "Payment Journal"
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
                Caption = 'Apply Webshop Return Orders';
                ApplicationArea = all;
                ToolTip = 'Download transactions and apply webshop return orders';
                Image = ApplyEntries;
                trigger OnAction()
                var
                    StripeManagement: Codeunit "TURFStripe Management";
                begin
                    StripeManagement.ApplyWebshopOrders(Rec."Journal Template Name", CurrentJnlBatchName, true);
                end;
            }
        }
    }
}