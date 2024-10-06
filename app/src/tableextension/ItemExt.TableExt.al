tableextension 70304 "TURFItem Ext" extends Item
{
    fields
    {
        field(70301; "TURFOperation Location"; Code[10])
        {
            Caption = 'Production Location';
            DataClassification = ToBeClassified;
        }
        field(70302; "TURFPart For Robots"; Integer)
        {
            Caption = 'Part for number of Robots';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Count("TURFItem Robot" where("Item No." = field("No.")));
        }
    }
}