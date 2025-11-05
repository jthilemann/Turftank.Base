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
        field(70303; "TURFMain Location Inventory"; Decimal)
        {
            Caption = 'Main Location Inventory';
            Editable = false;
            FieldClass = FlowField;
            DecimalPlaces = 0 : 5;
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                  "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                  "Location Code" = field("TURFMain Location Filter"),
                                                                  "Drop Shipment" = field("Drop Shipment Filter"),
                                                                  "Variant Code" = field("Variant Filter"),
                                                                  "Lot No." = field("Lot No. Filter"),
                                                                  "Serial No." = field("Serial No. Filter"),
                                                                  "Unit of Measure Code" = field("Unit of Measure Filter"),
                                                                  "Package No." = field("Package No. Filter")));
        }
        field(70304; "TURFMain Location Filter"; Code[10])
        {
            Caption = 'Main Location Filter';
            FieldClass = FlowFilter;
        }
        field(70305; "TURFAluminium Weight"; Decimal)
        {
            Caption = 'Aluminium Weight';
            DataClassification = ToBeClassified;
        }


    }
}