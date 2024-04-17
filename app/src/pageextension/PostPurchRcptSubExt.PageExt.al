pageextension 70311 "TURFPost.Purch. Rcpt Sub Ext" extends "Posted Purchase Rcpt. Subform"
{
    layout
    {

    }
    actions
    {
        addlast("&Line")
        {
            action(TURFPrintLabel)
            {
                ApplicationArea = All;
                Caption = 'Print Label';
                Image = Print;
                ToolTip = 'Executes the Print Label action.';
                trigger OnAction()
                var
                    PurchRcptLine: Record "Purch. Rcpt. Line";
                    TURFItemRcptLabel: Report "TURFItem Receipt Label";
                begin
                    PurchRcptLine := Rec;
                    PurchRcptLine.SetRecFilter();
                    TURFItemRcptLabel.SetTableView(PurchRcptLine);
                    TURFItemRcptLabel.Run();
                end;
            }
        }
    }
}