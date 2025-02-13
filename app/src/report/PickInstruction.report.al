report 70308 "TURFPick Instruction"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/PickInstruction.rdlc';
    Caption = 'Pick Instruction';

    dataset
    {
        dataitem(CopyLoop; "Integer")
        {
            DataItemTableView = sorting(Number);
            column(Number; Number)
            {
            }
            column(CompanyNameText; CompNameText)
            {
            }
            column(DateText; DateTxt)
            {
            }
            dataitem("Sales Header"; "Sales Header")
            {
                DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Order));
                RequestFilterFields = "No.";
                column(No_SalesHeader; "No.")
                {
                    IncludeCaption = true;
                }
                column(CustomerNo_SalesHeader; "Sell-to Customer No.")
                {
                    IncludeCaption = true;
                }
                column(CustomerName_SalesHeader; "Sell-to Customer Name")
                {
                    IncludeCaption = true;
                }
                column(ShippingAgent; "Shipping Agent Code")
                {
                    IncludeCaption = true;
                }
                column(Shipping_Agent_Service_Code; "Shipping Agent Service Code")
                {
                    IncludeCaption = true;
                }
                column(TURFOrderType_SalesHeader; "TURFOrder Type")
                {
                    IncludeCaption = true;
                }
                column(GetWorkDescription; GetWorkDescription())
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
                dataitem("Sales Line"; "Sales Line")
                {
                    DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                    DataItemTableView = sorting("Document Type", "Document No.", "Line No.") where(Type = const(Item));
                    column(LineNo_SalesLine; "Line No.")
                    {
                    }
                    column(ItemNo_SalesLine; "No.")
                    {
                        IncludeCaption = true;
                    }
                    column(Description_SalesLine; Description)
                    {
                        IncludeCaption = true;
                    }
                    column(LocationCode_SalesLine; "Location Code")
                    {
                        IncludeCaption = true;
                    }
                    column(BinCode_SalesLine; "Bin Code")
                    {
                        IncludeCaption = true;
                    }
                    column(ShipmentDate_SalesLine; Format("Shipment Date"))
                    {
                    }
                    column(Quantity_SalesLine; Quantity)
                    {
                        IncludeCaption = true;
                    }
                    column(UnitOfMeasure_SalesLine; "Unit of Measure")
                    {
                        IncludeCaption = true;
                    }
                    column(QuantityToShip_SalesLine; "Qty. to Ship")
                    {
                        IncludeCaption = true;
                    }
                    column(QuantityShipped_SalesLine; "Quantity Shipped")
                    {
                        IncludeCaption = true;
                    }
                    column(QtyToAsm; QtyToAsm)
                    {
                    }
                    column(SerialNo; ReservationEntry."Serial No.")
                    {
                    }
                    column(SerialNoLbl; ReservationEntry.FieldCaption("Serial No."))
                    {

                    }
                    dataitem("Assembly Line"; "Assembly Line")
                    {
                        DataItemTableView = sorting("Document Type", "Document No.", "Line No.");
                        column(No_AssemblyLine; "No.")
                        {
                            IncludeCaption = true;
                        }
                        column(Description_AssemblyLine; Description)
                        {
                            IncludeCaption = true;
                        }
                        column(VariantCode_AssemblyLine; "Variant Code")
                        {
                            IncludeCaption = true;
                        }
                        column(Quantity_AssemblyLine; Quantity)
                        {
                            IncludeCaption = true;
                        }
                        column(QuantityPer_AssemblyLine; "Quantity per")
                        {
                            IncludeCaption = true;
                        }
                        column(UnitOfMeasure_AssemblyLine; GetUOM("Unit of Measure Code"))
                        {
                        }
                        column(LocationCode_AssemblyLine; "Location Code")
                        {
                            IncludeCaption = true;
                        }
                        column(BinCode_AssemblyLine; "Bin Code")
                        {
                            IncludeCaption = true;
                        }
                        column(QuantityToConsume_AssemblyLine; "Quantity to Consume")
                        {
                            IncludeCaption = true;
                        }

                        trigger OnPreDataItem()
                        begin
                            if not AsmExists then
                                CurrReport.Break();
                            SetRange("Document Type", AsmHeader."Document Type");
                            SetRange("Document No.", AsmHeader."No.");
                        end;
                    }

                    trigger OnAfterGetRecord()
                    var
                        AssembleToOrderLink: Record "Assemble-to-Order Link";
                    begin
                        AssembleToOrderLink.Reset();
                        AssembleToOrderLink.SetCurrentKey(Type, "Document Type", "Document No.", "Document Line No.");
                        AssembleToOrderLink.SetRange(Type, AssembleToOrderLink.Type::Sale);
                        AssembleToOrderLink.SetRange("Document Type", "Document Type");
                        AssembleToOrderLink.SetRange("Document No.", "Document No.");
                        AssembleToOrderLink.SetRange("Document Line No.", "Line No.");
                        AsmExists := AssembleToOrderLink.FindFirst();
                        QtyToAsm := 0;
                        if AsmExists then
                            if AsmHeader.Get(AssembleToOrderLink."Assembly Document Type", AssembleToOrderLink."Assembly Document No.") then
                                QtyToAsm := AsmHeader."Quantity to Assemble"
                            else
                                AsmExists := false;

                        ReservationEntry.SetRange("Item No.", "Sales Line"."No.");
                        ReservationEntry.SetRange("Source Type", Database::"Sales Line");
                        ReservationEntry.SetRange("Source ID", "Sales Header"."No.");
                        ReservationEntry.SetRange("Source Ref. No.", "Sales Line"."Line No.");
                        ReservationEntry.SetFilter("Serial No.", '<>%1', '');
                        if not ReservationEntry.FindFirst() then
                            clear(ReservationEntry);
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    FormatAddress: Codeunit "Format Address";
                    DummyArray: array[8] of Text[100];
                begin
                    FormatAddress.SalesHeaderShipTo(ShipToAddr, DummyArray, "Sales Header");
                end;
            }

            trigger OnPreDataItem()
            begin
                SetRange(Number, 1, NoOfCopies + 1);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("No of Copies"; NoOfCopies)
                    {
                        ApplicationArea = Planning;
                        Caption = 'No of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        OrderPickingListCaption = 'Pick Instruction';
        PageCaption = 'Page';
        ItemNoCaption = 'Item  No.';
        OrderNoCaption = 'Order No.';
        CustomerNoCaption = 'Customer No.';
        CustomerNameCaption = 'Customer Name';
        QtyToAssembleCaption = 'Quantity to Assemble';
        QtyAssembledCaption = 'Quantity Assembled';
        ShipmentDateCaption = 'Shipment Date';
        QtyPickedCaption = 'Quantity Picked';
        UOMCaption = 'Unit of Measure';
        QtyConsumedCaption = 'Quantity Consumed';
        CopyCaption = 'Copy';
    }

    trigger OnPreReport()
    begin
        DateTxt := Format(Today);
        CompNameText := CompanyName;
    end;

    var
        ReservationEntry: Record "Reservation Entry";
        AsmHeader: Record "Assembly Header";
        NoOfCopies: Integer;
        DateTxt: Text;
        CompNameText: Text;
        QtyToAsm: Decimal;
        AsmExists: Boolean;
        ShipToAddr: array[8] of Text[100];
        ShiptoAddrLbl: Label 'Ship-to Address';

    local procedure GetUOM(UOMCode: Code[10]): Text
    var
        UnitOfMeasure: Record "Unit of Measure";
        IsHandled: Boolean;
        Result: Text;
    begin
        IsHandled := false;
        OnBeforeGetUOM(UOMCode, Result, IsHandled);
        if IsHandled then
            exit(Result);

        if UnitOfMeasure.Get(UOMCode) then
            exit(UnitOfMeasure.Description);
        exit(UOMCode);
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer)
    begin
        NoOfCopies := NewNoOfCopies;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetUOM(UOMCode: Code[10]; var Result: Text; var IsHandled: Boolean)
    begin
    end;
}

