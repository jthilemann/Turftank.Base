tableextension 70312 "TURF Sales Shp Line Ext" extends "Sales Shipment Line"
{
    fields
    {
        field(85000; "TURFBoomi Order"; Boolean)
        {
            Caption = 'Boomi Order';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Shipment Header"."TURFBoomi Order" where("No." = field("Document No.")));
        }
    }
}