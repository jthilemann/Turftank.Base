pageextension 70312 "TURF R. Prod. Orders" extends "Released Production Orders"
{
    layout
    {
    }
    actions
    {
        addlast(reporting)
        {
            action(TURFPrintJobCard)
            {
                Caption = 'Print Turf Job Card';
                Image = PrintDocument;
                ToolTip = 'Executes the Print Turf Job Card action.';
                ApplicationArea = all;
                trigger OnAction()
                var
                    ProductionOrder: Record "Production Order";
                    ProdOrderJobCard: Report "TURFProd. Order - Job Card";
                begin
                    CurrPage.SetSelectionFilter(ProductionOrder);
                    ProdOrderJobCard.SetTableView(ProductionOrder);
                    ProdOrderJobCard.Run();
                end;
            }
        }
    }
}