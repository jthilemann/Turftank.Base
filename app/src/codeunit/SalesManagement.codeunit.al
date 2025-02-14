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

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales Post Invoice Events", 'OnAfterPrepareInvoicePostingBuffer', '', false, false)]
    local procedure InvoicePostingBufferOnAfterPrepareSales(var InvoicePostingBuffer: Record "Invoice Posting Buffer" temporary; var SalesLine: Record "Sales Line")
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        SalesReceivablesSetup.GetRecordOnce();
        if SalesReceivablesSetup."Copy Line Descr. to G/L Entry" then
            InvoicePostingBuffer."TURFDescription 2" := SalesLine."Description 2";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales Post Invoice Events", 'OnAfterPrepareGenJnlLine', '', false, false)]
    local procedure InvoicePostingBufferOnAfterCopyToGenJnlLine(InvoicePostingBuffer: Record "Invoice Posting Buffer" temporary; var GenJnlLine: Record "Gen. Journal Line")
    begin
        GenJnlLine."TURFDescription 2" := InvoicePostingBuffer."TURFDescription 2";
    end;

    // [EventSubscriber(ObjectType::Table, database::"Invoice Posting Buffer", 'OnAfterPrepareSales', '', false, false)]
    // local procedure InvoicePostingBufferOnAfterPrepareSales(var InvoicePostingBuffer: Record "Invoice Posting Buffer" temporary; var SalesLine: Record "Sales Line")
    // var
    //     SalesReceivablesSetup: Record "Sales & Receivables Setup";
    // begin
    //     SalesReceivablesSetup.GetRecordOnce();
    //     if SalesReceivablesSetup."Copy Line Descr. to G/L Entry" then
    //         InvoicePostingBuffer."TURFDescription 2" := SalesLine."Description 2";
    // end;

    // [EventSubscriber(ObjectType::Table, database::"Invoice Posting Buffer", 'OnAfterCopyToGenJnlLine', '', false, false)]
    // local procedure InvoicePostingBufferOnAfterCopyToGenJnlLine(InvoicePostingBuffer: Record "Invoice Posting Buffer" temporary; var GenJnlLine: Record "Gen. Journal Line")
    // begin
    //     GenJnlLine."TURFDescription 2" := InvoicePostingBuffer."TURFDescription 2";
    // end;

    [EventSubscriber(ObjectType::Report, Report::"Create Ret.-Related Documents", 'OnPreReportOnAfterCopySalesDoc', '', false, false)]
    local procedure CreateRetRelatedDocumentsOnPreReportOnAfterCopySalesDoc(var SOSalesHeader: Record "Sales Header"; var SROSalesHeader: Record "Sales Header")
    begin
        SOSalesHeader."TURFSales Return Order No." := SROSalesHeader."No.";
        SOSalesHeader.Modify(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', false, false)]
    local procedure GenJnlPostLineOnAfterInitGLEntry(GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    begin
        GLEntry."TURFDescription 2" := GenJournalLine."TURFDescription 2";
    end;
}