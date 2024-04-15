Report 70301 "TURFItem Label"
{
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Item';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/TURFItem Label.rdlc';


    dataset
    {
        dataitem("Sales Shipment Line"; "Sales Shipment Line")
        {
            DataItemTableView = where(Type = const(Item));
            column(ItemCpt; 'SKU') { }
            column(ItemNo; Item."No.") { }
            column(Description; Description) { }

        }

    }

    requestpage
    {

        layout
        {
        }
    }

    labels
    {
    }

    var
        Item: Record Item;
}

