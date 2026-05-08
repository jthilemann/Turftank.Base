pageextension 70313 "TURFBase Item Card Ext" extends "Item Card"
{
    layout
    {
        addafter("Gross Weight")
        {
            field("TURFAluminium Weight"; Rec."TURFAluminium Weight")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Aluminium Weight field.', Comment = '%';
            }
        }
        addafter("Qty. on Sales Order")
        {

            field("TURFQty. on Sales Return"; Rec."Qty. on Sales Return")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Qty. on Sales Return field.', Comment = '%';
            }
            field("TURFQty. on TT US Pick"; Rec."TURFQty. on TT US Pick")
            {
                Visible = ShowUSPickInventory;
                Caption = 'Qty. on TT US Pick';
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity on hand at the US Pick location.', Comment = '%';
            }
            field("TURFQty. on TT PACKOUT pick"; Rec."TURFQty. on TT PACKOUT pick")
            {
                Visible = ShowPACKOUTPickInventory;
                Caption = 'Qty. on TT PACKOUT pick';
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity on hand at the PACKOUT Pick location.', Comment = '%';
            }
        }
        addlast(Item)
        {
            field("TURFPart For Robots"; Rec."TURFPart For Robots")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Part for number of Robots field.', Comment = '%';
            }
        }
        addlast(Replenishment_Production)
        {
            field("TURFOperation Location"; Rec."TURFOperation Location")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Production Location field.';
                TableRelation = "TURFOperation Location".Code;
            }
        }
        addlast(InventoryGrp)
        {
            field("TURFMain Location Inventory"; Rec."TURFMain Location Inventory")
            {
                Visible = ShowMainLocationInventory;
                CaptionClass = GetMainLocationInventoryCaption();
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Main Location Inventory field.', Comment = '%';
            }
        }
    }
    var
        TURFTurfTankSetup: Record "TURFTurfTank Setup";
        ShowMainLocationInventory: Boolean;
        ShowUSPickInventory: Boolean;
        ShowPACKOUTPickInventory: Boolean;

    trigger OnOpenPage()
    begin
        TURFTurfTankSetup.GetRecordOnce();
        ShowMainLocationInventory := TURFTurfTankSetup."TURFMain Location" <> '';
        if ShowMainLocationInventory then
            Rec.SetFilter("TURFMain Location Filter", TURFTurfTankSetup."TURFMain Location");
        ShowUSPickInventory := TURFTurfTankSetup."TURFUSPickLocation" <> '';
        if ShowUSPickInventory then
            Rec.SetFilter("TURFUSPickLocationFilter", TURFTurfTankSetup."TURFUSPickLocation");
        ShowPACKOUTPickInventory := TURFTurfTankSetup."TURFPACKOUTPickLocation" <> '';
        if ShowPACKOUTPickInventory then
            Rec.SetFilter("TURFPACKOUTPickLocationFilter", TURFTurfTankSetup."TURFPACKOUTPickLocation");
    end;

    local procedure GetMainLocationInventoryCaption(): Text
    begin
        Exit(TURFTurfTankSetup."TURFMain Location" + ' Inventory');
    end;
}