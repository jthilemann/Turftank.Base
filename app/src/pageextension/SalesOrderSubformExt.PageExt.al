pageextension 70336 TURFSalesOrderSubformExt extends "Sales Order Subform"
{
    layout
    {

    }

    actions
    {
        addlast(processing)
        {
            action(TURFInsertMarkup)
            {
                ApplicationArea = All;
                Caption = 'Insert Markup';
                Image = Add;
                Enabled = EnableMarkupAction;

                trigger OnAction()
                begin
                    Rec.InsertMarkup();
                end;
            }
        }
    }
    var
        EnableMarkupAction: Boolean;

    trigger OnAfterGetRecord()
    begin
        EnableMarkupAction := (Rec.Type = Rec.Type::Item) and (Rec."No." in ['600100', '600107', '600101']) and
        (Rec."Sell-to Customer No." = '002180') and (CompanyName = 'Turf Tank ApS');
    end;
}