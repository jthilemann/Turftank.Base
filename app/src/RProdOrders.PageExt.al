pageextension 70312 "TURF R. Prod. Orders" extends "Released Production Orders"
{
    layout
    {
        addlast(Control1)
        {
            field("TURF Production Start"; Rec."TURF Production Start")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TURF Production Start field.';
            }
            field("TURF Production End"; Rec."TURF Production End")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TURF Production End field.';
            }
            field(TURFComment; Rec.TURFComment)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Comment field.';
            }
        }
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