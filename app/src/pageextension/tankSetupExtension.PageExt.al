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