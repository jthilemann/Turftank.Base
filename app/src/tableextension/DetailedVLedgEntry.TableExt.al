tableextension 70324 "TURFDetailed V. Ledg. Entry" extends "Detailed Vendor Ledg. Entry"
{
    fields
    {
        field(70301; "TURFExternal Document No."; code[35])
        {
            Caption = 'External Document No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Vendor Ledger Entry"."External Document No." where("Entry No." = field("Vendor Ledger Entry No.")));
        }

    }

}