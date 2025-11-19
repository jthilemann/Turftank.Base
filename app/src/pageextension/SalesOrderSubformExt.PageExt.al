pageextension 70336 TURFSalesOrderSubformExt extends "Sales Order Subform"
{
    layout
    {
        addafter("Location Code")
        {
            field(TURFAvailableQuantity; TURFAvailableQuantity)
            {
                Caption = 'Available Quantity';
                ToolTip = 'Specifies the value of the Available Quantity field.';
                Editable = false;
                ApplicationArea = All;
            }
        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            begin
                CalculateTURFAvailableQuantity();
            end;
        }


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
        TURFAvailableQuantity: Decimal;
        EnableMarkupAction: Boolean;

    trigger OnAfterGetRecord()
    begin
        EnableMarkupAction := (Rec.Type = Rec.Type::Item) and (Rec."No." in ['600100', '600107', '600101']) and
        (Rec."Sell-to Customer No." = '002180') and (CompanyName = 'Turf Tank ApS');

        CalculateTURFAvailableQuantity();
    end;

    local procedure CalculateTURFAvailableQuantity()
    var
        Item: Record Item;
    begin
        Clear(TURFAvailableQuantity);
        if Rec.type = Rec.type::Item then begin
            item.setrange("Location Filter", Rec."Location Code");
            Item.setautocalcfields(Inventory, "Qty. on Sales Order");
            Item.Get(Rec."No.");
            if Item.IsInventoriableType() then
                TURFAvailableQuantity := Item.Inventory - Item."Qty. on Sales Order";
        end;
    end;
}