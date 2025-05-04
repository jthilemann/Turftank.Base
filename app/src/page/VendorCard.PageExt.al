pageextension 70334 "TURFVendor Card" extends "Vendor Card"
{
    layout
    {
        addlast(Invoicing)
        {
            field("TURFPurchase Receipt Email"; Rec."TURFPurchase Receipt Email")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the email address that will receive purchase receipt notifications.';
            }
        }
    }
}