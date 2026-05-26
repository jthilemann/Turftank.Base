tableextension 70325 "TURFRequisition Line Ext." extends "Requisition Line"
{
    fields
    {
        field(50100; "TURFQty. in Rel. Prod. Ord."; Decimal)
        {
            Caption = 'Qty. in Rel. Prod. Ord.';
            FieldClass = FlowField;
            CalcFormula = Sum("Prod. Order Line".Quantity WHERE(Status = CONST(Released), "Item No." = FIELD("No.")));
            Editable = false;
        }
        field(50101; "TURFQty. in Plan. Prod Ord."; Decimal)
        {
            Caption = 'Qty. in Firm. Plan. Prod Ord.';
            FieldClass = FlowField;
            CalcFormula = Sum("Prod. Order Line".Quantity WHERE(Status = CONST("Firm Planned"), "Item No." = FIELD("No.")));
            Editable = false;
        }
    }
}
