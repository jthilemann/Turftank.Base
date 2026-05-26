pageextension 70311 "TURF R. Prod. Ord. Card Ext" extends "Released Production Order"
{
    layout
    {
        addlast(General)
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
            field("TURF Done"; Rec."TURF Done")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether this production order is done.';
            }
            field(TURFComment; Rec.TURFComment)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Comment field.';
                MultiLine = true;
            }
            field("TURF Printed"; Rec."TURF Printed")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether this production order has been printed.';
            }
            field("TURFWarehouse/Production"; Rec."TURFWarehouse/Production")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the TURFWarehouse/Production field.';
            }
            field(TURFShipping; Rec.TURFShipping)
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the TURFShipping field.';
            }
            field("TURF Responsible"; Rec."TURF Responsible")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the person or group responsible for this production order.';
            }
            field("TURF Week"; Rec."TURF Week")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the production week for this production order.';
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