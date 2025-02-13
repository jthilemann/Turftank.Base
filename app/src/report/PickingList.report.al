report 70309 "TURFPicking List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/PickingList.rdlc';
    Caption = 'Picking List';
    WordMergeDataItem = "Warehouse Activity Header";

    dataset
    {
        dataitem("Warehouse Activity Header"; "Warehouse Activity Header")
        {
            DataItemTableView = sorting(Type, "No.") where(Type = filter(Pick | "Invt. Pick"));
            RequestFilterFields = "No.", "No. Printed";
            column(No_WhseActivHeader; "No.")
            {
            }
            column(ShippingAgent; SalesHeader."Shipping Agent Code")
            {
                IncludeCaption = true;
            }
            column(Shipping_Agent_Service_Code; SalesHeader."Shipping Agent Service Code")
            {
                IncludeCaption = true;
            }
            column(TURFOrderType_SalesHeader; SalesHeader."TURFOrder Type")
            {
                IncludeCaption = true;
            }
            column(GetWorkDescription; SalesHeader.GetWorkDescription())
            {
            }
            column(CommentLbl; fieldcaption("Comment"))
            {
            }
            column(ShipToAddress_Lbl; ShiptoAddrLbl)
            {
            }
            column(ShipToAddress1; ShipToAddr[1])
            {
            }
            column(ShipToAddress2; ShipToAddr[2])
            {
            }
            column(ShipToAddress3; ShipToAddr[3])
            {
            }
            column(ShipToAddress4; ShipToAddr[4])
            {
            }
            column(ShipToAddress5; ShipToAddr[5])
            {
            }
            column(ShipToAddress6; ShipToAddr[6])
            {
            }
            column(ShipToAddress7; ShipToAddr[7])
            {
            }
            column(ShipToAddress8; ShipToAddr[8])
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(CompanyName; COMPANYPROPERTY.DisplayName())
                {
                }
                column(TodayFormatted; Format(Today, 0, 4))
                {
                }
                column("Time"; Time)
                {
                }
                column(PickFilter; PickFilter)
                {
                }
                column(DirectedPutAwayAndPick; Location."Directed Put-away and Pick")
                {
                }
                column(BinMandatory; Location."Bin Mandatory")
                {
                }
                column(InvtPick; InvtPick)
                {
                }
                column(ShowLotSN; ShowLotSN)
                {
                }
                column(SumUpLines; SumUpLines)
                {
                }
                column(No_WhseActivHeaderCaption; "Warehouse Activity Header".FieldCaption("No."))
                {
                }
                column(WhseActivHeaderCaption; "Warehouse Activity Header".TableCaption + ': ' + PickFilter)
                {
                }
                column(LoctnCode_WhseActivHeader; "Warehouse Activity Header"."Location Code")
                {
                }
                column(SortingMtd_WhseActivHeader; "Warehouse Activity Header"."Sorting Method")
                {
                }
                column(AssgUserID_WhseActivHeader; "Warehouse Activity Header"."Assigned User ID")
                {
                }
                column(SourcDocument_WhseActLine; "Warehouse Activity Line"."Source Document")
                {
                }
                column(LoctnCode_WhseActivHeaderCaption; "Warehouse Activity Header".FieldCaption("Location Code"))
                {
                }
                column(SortingMtd_WhseActivHeaderCaption; "Warehouse Activity Header".FieldCaption("Sorting Method"))
                {
                }
                column(AssgUserID_WhseActivHeaderCaption; "Warehouse Activity Header".FieldCaption("Assigned User ID"))
                {
                }
                column(SourcDocument_WhseActLineCaption; "Warehouse Activity Line".FieldCaption("Source Document"))
                {
                }
                column(SourceNo_WhseActLineCaption; WhseActLine.FieldCaption("Source No."))
                {
                }
                column(ShelfNo_WhseActLineCaption; WhseActLine.FieldCaption("Shelf No."))
                {
                }
                column(VariantCode_WhseActLineCaption; WhseActLine.FieldCaption("Variant Code"))
                {
                }
                column(Description_WhseActLineCaption; WhseActLine.FieldCaption(Description))
                {
                }
                column(ItemNo_WhseActLineCaption; WhseActLine.FieldCaption("Item No."))
                {
                }
                column(UOMCode_WhseActLineCaption; WhseActLine.FieldCaption("Unit of Measure Code"))
                {
                }
                column(QtytoHandle_WhseActLineCaption; WhseActLine.FieldCaption("Qty. to Handle"))
                {
                }
                column(QtyBase_WhseActLineCaption; WhseActLine.FieldCaption("Qty. (Base)"))
                {
                }
                column(DestinatnType_WhseActLineCaption; WhseActLine.FieldCaption("Destination Type"))
                {
                }
                column(DestinationNo_WhseActLineCaption; WhseActLine.FieldCaption("Destination No."))
                {
                }
                column(ZoneCode_WhseActLineCaption; WhseActLine.FieldCaption("Zone Code"))
                {
                }
                column(BinCode_WhseActLineCaption; WhseActLine.FieldCaption("Bin Code"))
                {
                }
                column(ActionType_WhseActLineCaption; WhseActLine.FieldCaption("Action Type"))
                {
                }
                column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
                {
                }
                column(PickingListCaption; PickingListCaptionLbl)
                {
                }
                column(WhseActLineDueDateCaption; WhseActLineDueDateCaptionLbl)
                {
                }
                column(QtyHandledCaption; QtyHandledCaptionLbl)
                {
                }
                dataitem("Warehouse Activity Line"; "Warehouse Activity Line")
                {
                    DataItemLink = "Activity Type" = field(Type), "No." = field("No.");
                    DataItemLinkReference = "Warehouse Activity Header";
                    DataItemTableView = sorting("Activity Type", "No.", "Sorting Sequence No.");

                    trigger OnAfterGetRecord()
                    begin
                        if SumUpLines and
                           ("Warehouse Activity Header"."Sorting Method" <>
                            "Warehouse Activity Header"."Sorting Method"::Document)
                        then begin
                            if TempWhseActivLine."No." = '' then begin
                                TempWhseActivLine := "Warehouse Activity Line";
                                TempWhseActivLine.Insert();
                                Mark(true);
                            end else begin
                                TempWhseActivLine.SetSumLinesFilters("Warehouse Activity Line");
                                if "Warehouse Activity Header"."Sorting Method" =
                                   "Warehouse Activity Header"."Sorting Method"::"Ship-To"
                                then begin
                                    TempWhseActivLine.SetRange("Destination Type", "Destination Type");
                                    TempWhseActivLine.SetRange("Destination No.", "Destination No.")
                                end;
                                if TempWhseActivLine.FindFirst() then begin
                                    TempWhseActivLine."Qty. (Base)" := TempWhseActivLine."Qty. (Base)" + "Qty. (Base)";
                                    TempWhseActivLine."Qty. to Handle" := TempWhseActivLine."Qty. to Handle" + "Qty. to Handle";
                                    TempWhseActivLine."Source No." := '';
                                    if "Warehouse Activity Header"."Sorting Method" <>
                                       "Warehouse Activity Header"."Sorting Method"::"Ship-To"
                                    then begin
                                        TempWhseActivLine."Destination Type" := TempWhseActivLine."Destination Type"::" ";
                                        TempWhseActivLine."Destination No." := '';
                                    end;
                                    TempWhseActivLine.Modify();
                                end else begin
                                    TempWhseActivLine := "Warehouse Activity Line";
                                    TempWhseActivLine.Insert();
                                    Mark(true);
                                end;
                            end;
                        end else
                            Mark(true);
                    end;

                    trigger OnPostDataItem()
                    begin
                        MarkedOnly(true);
                    end;

                    trigger OnPreDataItem()
                    begin
                        TempWhseActivLine.SetRange("Activity Type", "Warehouse Activity Header".Type);
                        TempWhseActivLine.SetRange("No.", "Warehouse Activity Header"."No.");
                        TempWhseActivLine.DeleteAll();
                        if BreakbulkFilter then
                            TempWhseActivLine.SetRange("Original Breakbulk", false);
                        Clear(TempWhseActivLine);
                    end;
                }
                dataitem(WhseActLine; "Warehouse Activity Line")
                {
                    DataItemLink = "Activity Type" = field(Type), "No." = field("No.");
                    DataItemLinkReference = "Warehouse Activity Header";
                    DataItemTableView = sorting("Activity Type", "No.", "Sorting Sequence No.");
                    column(SourceNo_WhseActLine; "Source No.")
                    {
                    }
                    column(FormatSourcDocument_WhseActLine; Format("Source Document"))
                    {
                    }
                    column(ShelfNo_WhseActLine; "Shelf No.")
                    {
                    }
                    column(ItemNo_WhseActLine; "Item No.")
                    {
                    }
                    column(Description_WhseActLine; Description)
                    {
                    }
                    column(VariantCode_WhseActLine; "Variant Code")
                    {
                    }
                    column(UOMCode_WhseActLine; "Unit of Measure Code")
                    {
                    }
                    column(DueDate_WhseActLine; Format("Due Date"))
                    {
                    }
                    column(QtytoHandle_WhseActLine; "Qty. to Handle")
                    {
                    }
                    column(QtyBase_WhseActLine; "Qty. (Base)")
                    {
                    }
                    column(DestinatnType_WhseActLine; "Destination Type")
                    {
                    }
                    column(DestinationNo_WhseActLine; "Destination No.")
                    {
                    }
                    column(ZoneCode_WhseActLine; "Zone Code")
                    {
                    }
                    column(BinCode_WhseActLine; "Bin Code")
                    {
                    }
                    column(ActionType_WhseActLine; "Action Type")
                    {
                    }
                    column(LotNo_WhseActLine; "Lot No.")
                    {
                    }
                    column(SerialNo_WhseActLine; "Serial No.")
                    {
                    }
                    column(LotNo_WhseActLineCaption; FieldCaption("Lot No."))
                    {
                    }
                    column(SerialNo_WhseActLineCaption; FieldCaption("Serial No."))
                    {
                    }
                    column(LineNo_WhseActLine; "Line No.")
                    {
                    }
                    column(BinRanking_WhseActLine; "Bin Ranking")
                    {
                    }
                    column(EmptyStringCaption; EmptyStringCaptionLbl)
                    {
                    }
                    column(SerialNo; ReservationEntry."Serial No.")
                    {
                    }
                    column(SerialNoLbl; ReservationEntry.FieldCaption("Serial No."))
                    {

                    }
                    dataitem(WhseActLine2; "Warehouse Activity Line")
                    {
                        DataItemLink = "Activity Type" = field("Activity Type"), "No." = field("No."), "Bin Code" = field("Bin Code"), "Item No." = field("Item No."), "Action Type" = field("Action Type"), "Variant Code" = field("Variant Code"), "Unit of Measure Code" = field("Unit of Measure Code"), "Due Date" = field("Due Date");
                        DataItemLinkReference = WhseActLine;
                        DataItemTableView = sorting("Activity Type", "No.", "Bin Code", "Breakbulk No.", "Action Type");
                        column(LotNo_WhseActLine2; "Lot No.")
                        {
                        }
                        column(SerialNo_WhseActLine2; "Serial No.")
                        {
                        }
                        column(QtyBase_WhseActLine2; "Qty. (Base)")
                        {
                        }
                        column(QtytoHandle_WhseActLine2; "Qty. to Handle")
                        {
                        }
                        column(LineNo_WhseActLine2; "Line No.")
                        {
                        }
                    }

                    trigger OnAfterGetRecord()
                    var
                        SalesLine: Record "Sales Line";
                    begin
                        if SumUpLines then begin
                            TempWhseActivLine.Get("Activity Type", "No.", "Line No.");
                            "Qty. (Base)" := TempWhseActivLine."Qty. (Base)";
                            "Qty. to Handle" := TempWhseActivLine."Qty. to Handle";
                        end;

                        clear(ReservationEntry);
                        if SalesHeader."No." <> '' then
                            if SalesLine.Get(SalesHeader."Document Type", SalesHeader."No.", "Warehouse Activity Line"."Source Line No.") then begin

                                ReservationEntry.SetRange("Item No.", SalesLine."No.");
                                ReservationEntry.SetRange("Source Type", Database::"Sales Line");
                                ReservationEntry.SetRange("Source ID", SalesHeader."No.");
                                ReservationEntry.SetRange("Source Ref. No.", SalesLine."Line No.");
                                ReservationEntry.SetFilter("Serial No.", '<>%1', '');
                                if not ReservationEntry.FindFirst() then;
                            end;
                    end;

                    trigger OnPreDataItem()
                    begin
                        Copy("Warehouse Activity Line");
                        Counter := Count;
                        if Counter = 0 then
                            CurrReport.Break();

                        if BreakbulkFilter then
                            SetRange("Original Breakbulk", false);
                    end;
                }
            }

            trigger OnAfterGetRecord()
            var
                WarehouseActivityLine: Record "Warehouse Activity Line";
                FormatAddress: Codeunit "Format Address";
                DummyArray: array[8] of Text[100];
            begin
                GetLocation("Location Code");
                InvtPick := Type = Type::"Invt. Pick";
                if InvtPick then
                    BreakbulkFilter := false
                else
                    BreakbulkFilter := "Breakbulk Filter";

                if not IsReportInPreviewMode() then
                    CODEUNIT.Run(CODEUNIT::"Whse.-Printed", "Warehouse Activity Header");

                Clear(SalesHeader);

                WarehouseActivityLine.SetRange("Activity Type", "Warehouse Activity Header".Type);
                WarehouseActivityLine.SetRange("No.", "Warehouse Activity Header"."No.");
                if WarehouseActivityLine.FindFirst() then
                    if WarehouseActivityLine."Source Document" = WarehouseActivityLine."Source Document"::"Sales Order" then begin
                        WarehouseActivityLine.setfilter("Source No.", '<>%1', WarehouseActivityLine."Source No.");
                        if WarehouseActivityLine.IsEmpty() then
                            if SalesHeader.Get(SalesHeader."Document Type"::Order, WarehouseActivityLine."Source No.") then
                                FormatAddress.SalesHeaderShipTo(ShipToAddr, DummyArray, SalesHeader);
                    end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        actions
        {
        }

        trigger OnInit()
        begin
            SumUpLinesEditable := true;
            BreakbulkEditable := true;
        end;

        trigger OnOpenPage()
        begin
            if HideOptions then begin
                BreakbulkEditable := false;
                SumUpLinesEditable := false;
            end;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        PickFilter := "Warehouse Activity Header".GetFilters();
    end;

    var
        Location: Record Location;
        ReservationEntry: Record "Reservation Entry";
        SalesHeader: Record "Sales Header";
        TempWhseActivLine: Record "Warehouse Activity Line" temporary;
        PickFilter: Text;
        ShipToAddr: array[8] of Text[100];
        InvtPick: Boolean;
        Counter: Integer;
        CurrReportPageNoCaptionLbl: Label 'Page';
        PickingListCaptionLbl: Label 'Picking List';
        WhseActLineDueDateCaptionLbl: Label 'Due Date';
        QtyHandledCaptionLbl: Label 'Qty. Handled';
        EmptyStringCaptionLbl: Label '____________';
        ShiptoAddrLbl: Label 'Ship-to Address';

    protected var
        BreakbulkFilter: Boolean;
        HideOptions: Boolean;
        ShowLotSN: Boolean;
        SumUpLines: Boolean;
        BreakbulkEditable: Boolean;
        SumUpLinesEditable: Boolean;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        if LocationCode = '' then
            Location.Init()
        else
            if Location.Code <> LocationCode then
                Location.Get(LocationCode);
    end;

    protected procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview() or MailManagement.IsHandlingGetEmailBody());
    end;

    procedure SetBreakbulkFilter(BreakbulkFilter2: Boolean)
    begin
        BreakbulkFilter := BreakbulkFilter2;
    end;

    procedure SetInventory(SetHideOptions: Boolean)
    begin
        HideOptions := SetHideOptions;
    end;
}

