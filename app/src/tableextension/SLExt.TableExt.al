tableextension 70313 "TURF SL Ext" extends "Sales Line"
{
    fields
    {
        field(70301; "TURFBoomi Order"; Boolean)
        {
            Caption = 'TURFBoomi Order';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."TURFBoomi Order" where("Document Type" = field("Document Type"), "No." = field("Document No.")));
        }
    }
}