pageextension 70324 TURFPostedSCrMemoHdrExt extends "Posted Sales Credit Memo"
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
        addafter(General)
        {
            group(TURFZuora)
            {
                Caption = 'Zuora';
                field("TURFZuora Cr. Memo No."; Rec."TURFZuora Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Zuora Cr. Memo No. field.', Comment = '%';
                }
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
                field("TURFZuora Invoice No."; Rec."TURFZuora Invoice No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Zuora Ext. Doc. No. field.', Comment = '%';
                }
                field(TURFUpdateZuoraCreditMemoNo; TURFUpdateZuoraCreditMemoNo)
                {
                    Caption = 'Update Zuora Cr. Invoice No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Update Zuora Cr. Invoice No. field.', Comment = '%';
                    trigger OnValidate()
                    var
                        BC2Boomi: Codeunit "TURFBC2Boomi";
                    begin
                        BC2Boomi.UpdateZuoraCreditMemoNo(Rec, TURFUpdateZuoraCreditMemoNo);
                        Clear(TURFUpdateZuoraCreditMemoNo);
                    end;
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
                ToolTip = 'Send Credit Memo to Zuora, for creation';
                trigger OnAction()
                var
                    TURFBoomiTaxMgt: Codeunit "TURFBoomi Mgt";
                begin
                    TURFBoomiTaxMgt.SendCreditMemoToBoomi(Rec);
                end;
            }
        }
    }

    var
        TURFUpdateZuoraCreditMemoNo: Code[35];
}