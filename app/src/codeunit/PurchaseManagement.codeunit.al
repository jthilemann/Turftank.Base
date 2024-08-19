codeunit 70303 "TURFPurchase Management"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforeReleasePurchaseDoc', '', false, false)]
    local procedure ReleasePurchaseDocumentOnBeforeReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header")
    var
        SalesHeader: Record "Sales Header";
        RecRef: RecordRef;
        SONo: Code[20];
    begin
        RecRef.GetTable(PurchaseHeader);
        if RecRef.FieldExist(6082652) then begin
            SONo := RecRef.Field(6082652).Value;
            if SONo = '' then
                exit;

            if SalesHeader.get(SalesHeader."Document Type"::Order, SONo) then begin
                PurchaseHeader."TURF Ship-To E-Mail" := SalesHeader."TURF Ship-To E-Mail";
                PurchaseHeader."TURF Ship-to Phone No." := SalesHeader."TURF Ship-to Phone No.";
            end;

        end;
    end;

}