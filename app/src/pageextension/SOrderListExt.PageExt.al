pageextension 70307 "TURFS. Order List Ext" extends "Sales Order List"
{
    layout
    {
        addlast(Control1)
        {
            field("TURFOrder Type"; Rec."TURFOrder Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Type field.';
            }
        }
    }
    actions
    {
        addlast("&Print")
        {
            action(TURFCustomsInvoice)
            {
                ApplicationArea = All;
                Caption = 'Print Customs Invoice';
                Image = PrintReport;
                ToolTip = 'Executes the Print Customs Invoice action.';
                trigger OnAction()
                var
                    ReportManagement: Codeunit "TURFReport Management";
                begin
                    ReportManagement.PrintProformaInvoice(Rec);
                end;
            }
        }
    }
}