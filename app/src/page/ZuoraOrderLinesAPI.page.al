page 70319 "TURFZuora Order Lines API"
{
    PageType = API;
    APIGroup = 'zuora';
    APIPublisher = 'turfTank';
    APIVersion = 'v1.0';
    Caption = 'TurfOrderLines';
    EntityName = 'orderline';
    EntitySetName = 'orderlines';
    SourceTable = "Sales Line";
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }

                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(type; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(unitPrice; Rec."Unit Price")
                {
                    Caption = 'Unit Price';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(lineDiscount; Rec."Line Discount %")
                {
                    Caption = 'Line Discount %';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }

                field(shipmentDate; Rec."Shipment Date")
                {
                    Caption = 'Shipment Date';
                }
                field(returnReasonCode; Rec."Return Reason Code")
                {
                    Caption = 'Return Reason Code';
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        BoomiSetup: Record "TURFBoomi Setup";
    begin
        if Rec."Line No." = 0 then
            Rec."Line No." := GetNextLineNo();

        if BoomiSetup.Get() then
            if BoomiSetup."TURFDef. Boomi Order Location" <> '' then
                Rec.validate("Location Code", BoomiSetup."TURFDef. Boomi Order Location");
    end;

    local procedure GetNextLineNo(): Integer;
    var
        SalesLine: Record "Sales Line";
        ModResult: Integer;
    begin
        SalesLine.SetRange("Document No.", Rec."Document No.");
        SalesLine.SetRange("Document Type", Rec."Document Type");
        if SalesLine.FindLast() then begin
            ModResult := SalesLine."Line No." mod 10000;
            Exit(SalesLine."Line No." + 10000 - ModResult);
        end else
            Exit(10000);
    end;

}