pageextension 70328 "TURF tank Setup Extension" extends "TURFTurfTank Setup"
{
    layout
    {
        addlast(General)
        {
            field("TURFMain Location"; Rec."TURFMain Location")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Main Location field.', Comment = '%';
            }
            field("TURFWarranty Dimension"; Rec."TURFWarranty Dimension")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Warranty Dimension field.', Comment = '%';
            }
            field("TURFWarranty Dimension Value"; Rec."TURFWarranty Dimension Value")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Warranty Dimension Value field.', Comment = '%';
            }
            group(TURFMarkup)
            {
                Caption = 'US Markup';
                field("TURFMarkup Item No."; Rec."TURFMarkup Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Markup Item No. field.', Comment = '%';
                }
                field("TURFMarkup Robot Unit Price"; Rec."TURFMarkup Robot Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Markup Robot Unit Price field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(TURFUpdate)
            {
                ApplicationArea = All;
                Visible = ShowUpdateAction;
                ToolTip = 'Executes the TURFUpdate action.';
                trigger OnAction()
                var
                    TURFUpgrade: Codeunit TURFUpgrade;
                begin
                    TURFUpgrade.UpdateExistingCustLedgEntriesWithZuoraInvoiceNo();
                end;
            }
        }
    }

    var
        ShowUpdateAction: Boolean;

    trigger OnOpenPage()
    begin
        ShowUpdateAction := UserId = 'KRIS_ADMIN';
    end;

}