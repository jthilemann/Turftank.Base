tableextension 70311 "TURF Sales Inv Line Ext" extends "Sales Invoice Line"
{
    fields
    {
        field(70301; "TURFBoomi Order"; Boolean)
        {
            Caption = 'TURFBoomi Order';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."TURFBoomi Order" where("No." = field("Document No.")));
        }
    }
}