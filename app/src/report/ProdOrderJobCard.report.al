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
            column(Status_ProdOrder; Status)
            {
            }
            column(No_ProdOrder; "No.")
            {
            }
            column(ItemOperationLocation; Item."TURFOperation Location") { }
            column(ItemOperationLocationLbl; Item.FieldCaption("TURFOperation Location")) { }
            column(ProdOrderLocation; "Production Order"."Location Code") { }
            column(ProdOrderLocationLbl; "Production Order".FieldCaption("Location Code")) { }
            column(TurfStart; Format("Production Order"."TURF Production Start")) { }
            column(TurfEnd; Format("Production Order"."TURF Production End")) { }
            column(TurfStartLbl; "Production Order".FieldCaption("TURF Production Start")) { }
            column(TurfEndLbl; "Production Order".FieldCaption("TURF Production End")) { }
            column(ItemPicture; ItemTenantMedia.Content) { }
            column(ProdOrderBarcode; ProdOrderBarcode) { }
            column(ItemBarcode; ItemBarcode) { }
            column(Comment; TURFComment) { }
            column(CommentLbl; FieldCaption(TURFComment)) { }


            dataitem("Integer";
            "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(TodayFormatted; Format(Today, 0, 4))
                {
                }
                column(CompanyName; COMPANYPROPERTY.DisplayName())
                {
                }
                column(ProdOrderTableCaptionFilt; "Production Order".TableCaption + ':' + ProdOrderFilter)
                {
                }
                column(ProdOrderFilter; ProdOrderFilter)
                {
                }
                column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
                {
                }
                column(ProdOrderJobCardCaption; ProdOrderJobCardCaptionLbl)
                {
                }
            }
            dataitem("Prod. Order Routing Line"; "Prod. Order Routing Line")
            {
                DataItemLink = Status = field(Status), "Prod. Order No." = field("No.");
                DataItemTableView = sorting(Status, "Prod. Order No.", "Routing Reference No.", "Routing No.", "Operation No.");
                column(RtngNo_ProdOrderRtngLine; "Routing No.")
                {
                    IncludeCaption = true;
                }
                column(OPNo_ProdOrderRtngLine; "Operation No.")
                {
                    IncludeCaption = true;
                }
                column(Type_ProdOrderRtngLine; Type)
                {
                    IncludeCaption = true;
                }
                column(No_ProdOrderRtngLine; "No.")
                {
                    IncludeCaption = true;
                }
                column(StrtTim_ProdOrderRtngLine; "Starting Time")
                {
                    IncludeCaption = true;
                }
                column(StrtDt_ProdOrderRtngLine; Format("Starting Date"))
                {
                }
                column(EndTime_ProdOrderRtngLine; "Ending Time")
                {
                    IncludeCaption = true;
                }
                column(EndDate_ProdOrderRtngLine; Format("Ending Date"))
                {
                }
                column(ExpCapNd_ProdOrderRtngLine; "Expected Capacity Need")
                {
                }
                column(Desc_ProdOrder; "Production Order".Description)
                {
                }
                column(SourceNo_ProdOrder; "Production Order"."Source No.")
                {
                }
                column(ProdOrdrRtngLineRTUOMCode; CapacityUoM)
                {
                }
                column(PrdOrdNo_ProdOrderRtngLine; "Prod. Order No.")
                {
                    IncludeCaption = true;
                }
                column(ProdOrderRtngLnStrtDtCapt; ProdOrderRtngLnStrtDtCaptLbl)
                {
                }
                column(ProdOrdRtngLnEndDatCapt; ProdOrdRtngLnEndDatCaptLbl)
                {
                }
                column(ProdOrdRtngLnExpcCapNdCpt; ProdOrdRtngLnExpcCapNdCptLbl)
                {
                }
                column(PrecalcTimesCaption; PrecalcTimesCaptionLbl)
                {
                }
                column(ProdOrderSourceNoCapt; ProdOrderSourceNoCaptLbl)
                {
                }
                column(OutputCaption; OutputCaptionLbl)
                {
                }
                column(ScrapCaption; ScrapCaptionLbl)
                {
                }
                column(DateCaption; DateCaptionLbl)
                {
                }
                column(ByCaption; ByCaptionLbl)
                {
                }
                column(EmptyStringCaption; EmptyStringCaptionLbl)
                {
                }
                dataitem("Prod. Order Component"; "Prod. Order Component")
                {
                    DataItemLink = Status = field(Status), "Prod. Order No." = field("Prod. Order No."), "Routing Link Code" = field("Routing Link Code");
                    DataItemTableView = sorting(Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.");
                    column(Position_ProdOrderComp; Position)
                    {
                        IncludeCaption = true;
                    }
                    column(Position2_ProdOrderComp; "Position 2")
                    {
                        IncludeCaption = true;
                    }
                    column(LdTimOffset_ProdOrderComp; "Lead-Time Offset")
                    {
                        IncludeCaption = true;
                    }
                    column(ExpectedQty_ProdOrderComp; "Expected Quantity")
                    {
                        IncludeCaption = true;
                    }
                    column(ItemNo_ProdOrderComp; "Item No.")
                    {
                        IncludeCaption = true;
                    }
                    column(OrderNo_ProdOrderComp; "Prod. Order No.")
                    {
                    }
                    column(MaterialRequirementsCapt; MaterialRequirementsCaptLbl)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                var
                    WorkCenter: Record "Work Center";
                    CalendarMgt: Codeunit "Shop Calendar Management";
                begin
                    WorkCenter.Get("Work Center No.");
                    CapacityUoM := WorkCenter."Unit of Measure Code";
                    "Expected Capacity Need" := "Expected Capacity Need" / CalendarMgt.TimeFactor(CapacityUoM);
                end;
            }

            trigger OnAfterGetRecord()
            var
                ProdOrderRoutingLine: Record "Prod. Order Routing Line";
                BarcodeFontProvider: Interface "Barcode Font Provider";
            begin
                ProdOrderRoutingLine.SetRange(Status, Status);
                ProdOrderRoutingLine.SetRange("Prod. Order No.", "No.");
                if not ProdOrderRoutingLine.FindFirst() then
                    CurrReport.Skip();

                if not Item.Get("Source No.") then
                    clear(Item);

                if Item.Picture.Count > 0 then
                    if ItemTenantMedia.get(Item.Picture.Item(1)) then
                        ItemTenantMedia.CalcFields(Content)
                    else
                        Clear(ItemTenantMedia);

                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeSymbology := Enum::"Barcode Symbology"::Code39;

                if Item."No." <> '' then begin
                    BarcodeFontProvider.ValidateInput(Item."No.", BarcodeSymbology);
                    ItemBarcode := BarcodeFontProvider.EncodeFont(Item."No.", BarcodeSymbology);
                end;
                BarcodeFontProvider.ValidateInput("Production Order"."No.", BarcodeSymbology);
                ProdOrderBarcode := BarcodeFontProvider.EncodeFont("Production Order"."No.", BarcodeSymbology);
            end;

            trigger OnPreDataItem()
            begin
                ProdOrderFilter := GetFilters();
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
        ItemBarcode, ProdOrderBarcode, ProdOrderFilter : Text;
        CapacityUoM: Code[10];
        CurrReportPageNoCaptionLbl: Label 'Page';
        ProdOrderJobCardCaptionLbl: Label 'Prod. Order - Job Card';
        ProdOrderRtngLnStrtDtCaptLbl: Label 'Starting Date';
        ProdOrdRtngLnEndDatCaptLbl: Label 'Ending Date';
        ProdOrdRtngLnExpcCapNdCptLbl: Label 'Time Needed';
        PrecalcTimesCaptionLbl: Label 'Precalc. Times';
        ProdOrderSourceNoCaptLbl: Label 'Item No.';
        OutputCaptionLbl: Label 'Output';
        ScrapCaptionLbl: Label 'Scrap';
        DateCaptionLbl: Label 'Date';
        ByCaptionLbl: Label 'By';
        EmptyStringCaptionLbl: Label '___________';
        MaterialRequirementsCaptLbl: Label 'Material Requirements';
}

