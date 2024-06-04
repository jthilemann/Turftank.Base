report 70301 "TURFProd. Order - Job Card"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/TURFProd Order Job Card.rdlc';
    AdditionalSearchTerms = 'TURF production order - job card,work order job card';
    ApplicationArea = Manufacturing;
    Caption = 'TURF Prod. Order - Job Card';
    UsageCategory = ReportsAndAnalysis;
    WordMergeDataItem = "Production Order";

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = sorting(Status, "No.");
            RequestFilterFields = Status, "No.", "Source Type", "Source No.";
            column(Status_ProdOrder; Status) { }
            column(No_ProdOrder; "No.") { }
            column(No_ProdOrderLbl; ProdOrderNoLbl) { }
            column(ItemOperationLocation; Item."TURFOperation Location") { }
            column(ItemOperationLocationLbl; Item.FieldCaption("TURFOperation Location")) { }
            column(ProdOrderLocation; "Production Order"."Location Code") { }
            column(ProdOrderLocationLbl; "Production Order".FieldCaption("Location Code")) { }
            column(TurfStart; Format("Production Order"."TURF Production Start")) { }
            column(TurfEnd; Format("Production Order"."TURF Production End")) { }
            column(TurfStartLbl; "Production Order".FieldCaption("TURF Production Start")) { }
            column(TurfEndLbl; "Production Order".FieldCaption("TURF Production End")) { }
            column(Comment; TURFComment) { }
            column(CommentLbl; FieldCaption(TURFComment)) { }
            column(TURFShipping; TURFShipping) { }
            column(TURFWarehouse_Production; "TURFWarehouse/Production") { }
            column(TURFShippingLbl; FieldCaption(TURFShipping)) { }
            column(TURFWarehouse_ProductionLbl; FieldCaption("TURFWarehouse/Production")) { }
            column(TodayFormatted; Format(Today, 0, 4)) { }
            column(CompanyName; COMPANYPROPERTY.DisplayName()) { }
            column(ProdOrderTableCaptionFilt; FiltersLbl + "Production Order".TableCaption + ':' + ProdOrderFilter) { }
            column(ProdOrderFilter; ProdOrderFilter) { }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl) { }
            column(ProdOrderJobCardCaption; ProdOrderJobCardCaptionLbl) { }
            Column(ProdOrdRtngLnExpcCapNdCptLbl; ProdOrdRtngLnExpcCapNdCptLbl) { }
            column(PrecalcTimesCaption; PrecalcTimesCaptionLbl) { }
            column(ProdOrdRtngLnExpcCapNdCpt; ProdOrdRtngLnExpcCapNdCptLbl) { }
            column(PrdOrdNo_ProdOrderRtngLineCaption; "Prod. Order Line".FieldCaption("Routing No.")) { }
            column(ProdOrderSourceNoCapt; ProdOrderSourceNoCaptLbl) { }
            column(ExpPerItemLbl; ExpPerItemLbl) { }
            dataitem("Prod. Order Line"; "Prod. Order Line")
            {
                DataItemLink = "Prod. Order No." = field("No."), Status = field(status);
                DataItemTableView = where(Quantity = filter(<> 0));
                column(RoutingNo; "Routing No.") { }
                column(LineNo; "Line No.") { }
                column(ItemPicture; ItemTenantMedia.Content) { }
                column(ProdOrderBarcode; ProdOrderBarcode) { }
                column(ItemBarcode; ItemBarcode) { }
                column(CapacityUoM; CapacityUoM) { }
                column(ExpCapNeed; ExpCapNeed) { }
                column(ExpCapNeededPerItem; ExpCapNeededPerItem) { }
                column(ItemNo; Item."No.") { }
                column(DescriptionLbl; Item.FieldCaption(Description)) { }
                column(Description; Item.Description) { }
                column(QuantityLbl; FieldCaption(Quantity)) { }
                column(Quantity; Quantity) { }
                trigger OnAfterGetRecord()
                var
                    WorkCenter: Record "Work Center";
                    ProdOrderRoutingLine: Record "Prod. Order Routing Line";
                    CalendarMgt: Codeunit "Shop Calendar Management";
                begin
                    Clear(ExpCapNeed);
                    if not Item.Get("Prod. Order Line"."Item No.") then
                        clear(Item);

                    if Item.Picture.Count > 0 then
                        if ItemTenantMedia.get(Item.Picture.Item(1)) then
                            ItemTenantMedia.CalcFields(Content)
                        else
                            Clear(ItemTenantMedia);

                    if Item."No." <> '' then begin
                        BarcodeFontProvider.ValidateInput(Item."No.", BarcodeSymbology);
                        ItemBarcode := BarcodeFontProvider.EncodeFont(Item."No.", BarcodeSymbology);
                    end;

                    ProdOrderRoutingLine.SetRange("Prod. Order No.", "Production Order"."No.");
                    ProdOrderRoutingLine.SetRange("Routing Reference No.", "Prod. Order Line"."Line No.");
                    ProdOrderRoutingLine.SetRange("Routing No.", "Prod. Order Line"."Routing No.");
                    ProdOrderRoutingLine.SetRange(Status, "Production Order".Status);
                    ProdOrderRoutingLine.SetLoadFields("Work Center No.", "Expected Capacity Need");
                    if ProdOrderRoutingLine.FindSet(false) then
                        repeat
                            WorkCenter.Get(ProdOrderRoutingLine."Work Center No.");
                            CapacityUoM := WorkCenter."Unit of Measure Code";
                            ExpCapNeed += ProdOrderRoutingLine."Expected Capacity Need" / CalendarMgt.TimeFactor(CapacityUoM);
                        until ProdOrderRoutingLine.Next() = 0;

                    ExpCapNeededPerItem := ExpCapNeed / "Prod. Order Line".Quantity;
                end;
            }

            trigger OnPreDataItem()
            begin
                ProdOrderFilter := GetFilters();
            end;

            trigger OnAfterGetRecord()
            begin
                BarcodeFontProvider.ValidateInput("Production Order"."No.", BarcodeSymbology);
                ProdOrderBarcode := BarcodeFontProvider.EncodeFont("Production Order"."No.", BarcodeSymbology);
            end;
        }

    }
    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Item: Record Item;
        ItemTenantMedia: Record "Tenant Media";
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeFontProvider: Interface "Barcode Font Provider";
        ItemBarcode, ProdOrderBarcode, ProdOrderFilter : Text;
        CapacityUoM: Code[10];
        ExpCapNeed, ExpCapNeededPerItem : Decimal;
        CurrReportPageNoCaptionLbl: Label 'Page';
        ProdOrderJobCardCaptionLbl: Label 'Prod. Order - Job Card';
        ProdOrdRtngLnExpcCapNdCptLbl: Label 'Time Needed';
        PrecalcTimesCaptionLbl: Label 'Precalc. Times';
        ProdOrderSourceNoCaptLbl: Label 'Item No.';
        ExpPerItemLbl: Label 'Time Needed Per Item';
        ProdOrderNoLbl: Label 'Production Order No.';
        FiltersLbl: Label 'Filters: ';

    trigger OnInitReport()
    begin
        BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
        BarcodeSymbology := Enum::"Barcode Symbology"::Code39;
    end;
}

