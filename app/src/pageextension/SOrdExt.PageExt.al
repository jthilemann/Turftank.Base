pageextension 70302 "TURFS. Ord. Ext" extends "Sales Order"
{
    layout
    {
        addlast(General)
        {
            field("TURFOrder Type"; Rec."TURFOrder Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Type field.';
            }
            field("TURFZuora Account Number"; Rec."TURFZuora Account Number")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zuora Account Number field.', Comment = '%';
            }
            field("TURFZuora Subscription No."; Rec."TURFZuora Subscription No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zuora Subscription No. field.', Comment = '%';
            }
        }

        addafter("Ship-to Contact")
        {
            field("TURF Ship-To E-Mail"; Rec."TURF Ship-To E-Mail")
            {
                ApplicationArea = All;
                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                ToolTip = 'Specifies the value of the Ship-to Email field.', Comment = '%';
            }
            field("TURF Phone No."; Rec."TURF Ship-to Phone No.")
            {
                ApplicationArea = All;
                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                ToolTip = 'Specifies the value of the Ship-To Phone No. field.', Comment = '%';
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
                    ReportManagement: Codeunit "TURFReport Management Man";
                begin
                    ReportManagement.PrintProformaInvoice(Rec);
                end;
            }
        }
    }
}