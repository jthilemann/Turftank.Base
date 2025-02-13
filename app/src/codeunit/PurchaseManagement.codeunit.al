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

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Purch. Post Invoice Events", 'OnAfterPrepareInvoicePostingBuffer', '', false, false)]
    local procedure InvoicePostingBufferOnAfterPrepareSales(var PurchaseLine: Record "Purchase Line"; var InvoicePostingBuffer: Record "Invoice Posting Buffer" temporary)
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        PurchasesPayablesSetup.GetRecordOnce();
        if PurchasesPayablesSetup."Copy Line Descr. to G/L Entry" then
            InvoicePostingBuffer."TURFDescription 2" := PurchaseLine."Description 2";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Purch. Post Invoice Events", 'OnAfterPrepareGenJnlLine', '', false, false)]
    local procedure InvoicePostingBufferOnAfterCopyToGenJnlLine(InvoicePostingBuffer: Record "Invoice Posting Buffer" temporary; var GenJnlLine: Record "Gen. Journal Line")
    begin
        GenJnlLine."TURFDescription 2" := InvoicePostingBuffer."TURFDescription 2";
    end;

    // [EventSubscriber(ObjectType::Table, database::"Invoice Posting Buffer", 'OnAfterPreparePurchase', '', false, false)]
    // local procedure InvoicePostingBufferOnAfterPrepareSales(var InvoicePostingBuffer: Record "Invoice Posting Buffer" temporary; var PurchaseLine: Record "Purchase Line")
    // var
    //     SalesReceivablesSetup: Record "Sales & Receivables Setup";
    // begin
    //     SalesReceivablesSetup.GetRecordOnce();
    //     if SalesReceivablesSetup."Copy Line Descr. to G/L Entry" then
    //         InvoicePostingBuffer."TURFDescription 2" := PurchaseLine."Description 2";
    // end;
}