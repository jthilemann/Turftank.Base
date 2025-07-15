pageextension 70304 "TURFPosted Sales Inv. Ext" extends "Posted Sales Invoice"
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
        }

        addafter("External Document No.")
        {

            field("TURFSales Return Order No."; Rec."TURFSales Return Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Return Order No. field.', Comment = '%';
            }
        }

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
                field("TURFBoomi Order"; Rec."TURFBoomi Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TURFBoomi Order field.', Comment = '%';
                }
                field("TURFSent to Boomi"; Rec."TURFSent to Boomi")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sent to Boomi field.', Comment = '%';
                }
                field("TURFZuora Order No."; Rec."TURFZuora Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the TURFZuora Order No. field.', Comment = '%';
                }
                field("TURFZuora Invoice No."; Rec."TURFZuora Invoice No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Zuora Ext. Doc. No. field.', Comment = '%';
                }
                field(TURFUpdateZuoraInvoiceNo; TURFUpdateZuoraInvoiceNo)
                {
                    Caption = 'Update Zuora Invoice No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Update Zuora Invoice No. field.', Comment = '%';
                    trigger OnValidate()
                    var
                        BC2Boomi: Codeunit "TURFBC2Boomi";
                    begin
                        BC2Boomi.UpdateZuoraInvoiceNo(Rec, TURFUpdateZuoraInvoiceNo);
                        Clear(TURFUpdateZuoraInvoiceNo);
                    end;
                }
            }
        }
        addafter("Ship-to Contact")
        {
            field("TURF Ship-To E-Mail"; Rec."TURF Ship-To E-Mail")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Ship-to Email field.', Comment = '%';
            }
            field("TURF Phone No."; Rec."TURF Ship-to Phone No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Ship-To Phone No. field.', Comment = '%';
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
                Caption = 'Send to Zuora';
                Image = Download;
                Promoted = false;
                ToolTip = 'Send invoice to Zuora, for creation';
                trigger OnAction()
                var
                    TURFBoomiTaxMgt: Codeunit "TURFBoomi Mgt";
                begin
                    TURFBoomiTaxMgt.SendInvoiceToBoomi(Rec);
                end;
            }
            action(TURFResetReconciled)
            {
                ApplicationArea = All;
                Caption = 'Reset Reconciled';
                ToolTip = 'Reset the reconciled status of the invoice';
                Image = ResetStatus;
                trigger OnAction()
                var
                    StripeManagement: Codeunit "TURFStripe Management";
                begin
                    StripeManagement.ResetReconciledSalesInvoice(Rec);
                end;
            }
        }
    }
    var
        TURFUpdateZuoraInvoiceNo: Code[35];
}