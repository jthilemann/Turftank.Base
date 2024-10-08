codeunit 70302 "TURFSales Management"
{
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeSetDefaultSalesperson', '', false, false)]
    local procedure CustomerOnBeforeSetDefaultSalesperson(var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Header", 'OnAfterValidateEvent', 'Ship-to Code', false, false)]
    local procedure SalesHeaderOnAfterValidateEventShiptoCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var
        ShiptoAddress: Record "Ship-to Address";
    begin
        if (Rec."Ship-to Code" <> xRec."Ship-to Code") and (Rec."Ship-to Code" <> '') then
            if ShiptoAddress.Get(Rec."Sell-to Customer No.", Rec."Ship-to Code") then begin
                Rec."TURF Ship-To E-Mail" := ShiptoAddress."E-Mail";
                Rec."TURF Ship-to Phone No." := ShiptoAddress."Phone No.";
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', false, false)]
    local procedure ReleaseSalesDocumentOnBeforeReleaseSalesDoc(PreviewMode: Boolean; var SalesHeader: Record "Sales Header")
    var
        ShiptoAddress: Record "Ship-to Address";
    begin
        if PreviewMode then
            exit;

        if SalesHeader."Ship-to Code" = '' then
            exit;

        if ShiptoAddress.Get(SalesHeader."Sell-to Customer No.", SalesHeader."Ship-to Code") then begin
            SalesHeader."Ship-to Code" := '';
            SalesHeader."Ship-to Name" := ShiptoAddress.Name;
            SalesHeader."Ship-to Name 2" := ShiptoAddress."Name 2";
            SalesHeader."Ship-to Address" := ShiptoAddress.Address;
            SalesHeader."Ship-to Address 2" := ShiptoAddress."Address 2";
            SalesHeader."Ship-to Country/Region Code" := ShiptoAddress."Country/Region Code";
            SalesHeader."Ship-to Post Code" := ShiptoAddress."Post Code";
            SalesHeader."Ship-to City" := ShiptoAddress.City;
            SalesHeader."Ship-to Contact" := ShiptoAddress.Contact;
            SalesHeader."TURF Ship-To E-Mail" := ShiptoAddress."E-Mail";
            SalesHeader."TURF Ship-to Phone No." := ShiptoAddress."Phone No.";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"IC Outbox Export", 'OnBeforeSendToExternalPartner', '', false, false)]
    local procedure OnRunOutboxTransactionsOnBeforeSend(var ICOutboxTransaction: Record "IC Outbox Transaction")
    begin

    end;
}