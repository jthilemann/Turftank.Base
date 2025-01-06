pageextension 70325 "TURFItem List Ext" extends "Item List"
{
    layout
    {

    }

    actions
    {
        addlast(processing)
        {
            action(TURFBinContentsExcel)
            {
                ApplicationArea = All;
                Caption = 'Export Bin Content to Excel';
                Image = ExportToExcel;
                ToolTip = 'Executes the Export Bin Content to Excel action.';

                trigger OnAction()
                var
                    TURFInventorytoExcel: Report "TURFInventory to Excel";
                begin
                    TURFInventorytoExcel.RunModal();
                end;
            }
        }
    }
}