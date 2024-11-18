codeunit 70304 "TURFFormat Report"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesHeaderShipTo', '', false, false)]
    local procedure FormatAddressOnBeforeSalesHeaderShipTo(var SalesHeader: Record "Sales Header"; var AddrArray: array[8] of Text[100]; var CustAddr: array[8] of Text[100]; var Handled: Boolean; var Result: Boolean)
    begin
        FormatShipTo(SalesHeader, AddrArray, CustAddr, Handled, Result);
        if AddrArray[8] = '' then begin
            AddrArray[8] := SalesHeader."TURF Ship-To E-Mail";
            CompressArray(AddrArray);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Document", 'OnAfterSetTotalLabels', '', false, false)]
    local procedure FormatDocumentOnAfterSetTotalLabels(CurrencyCode: Code[10]; var TotalExclVATText: Text[50]; var TotalInclVATText: Text[50]; var TotalText: Text[50])
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        CurrencySymbol: Code[10];
        TotalTxt: Label 'Total %1', Comment = '%1 = Currency Code';
        TotalInclVATTxt: Label 'Total %1 Incl. VAT', Comment = '%1 = Currency Code';
        TotalExclVATTxt: Label 'Total %1 Excl. VAT', Comment = '%1 = Currency Code';
    begin
        GeneralLedgerSetup.Get();
        if CurrencyCode <> '' then
            exit;

        if GeneralLedgerSetup."Local Currency Symbol" <> '' then
            if GeneralLedgerSetup."LCY Code" <> GeneralLedgerSetup."Local Currency Symbol" then begin
                CurrencySymbol := GeneralLedgerSetup.GetCurrencySymbol();
                TotalText := StrSubstNo(TotalTxt, CurrencySymbol);
                TotalInclVATText := StrSubstNo(TotalInclVATTxt, CurrencySymbol);
                TotalExclVATText := StrSubstNo(TotalExclVATTxt, CurrencySymbol);
            end;
    end;

    internal procedure GetCurrencySymbol(CurrencyCode: Code[10]): Code[10]
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        SalesInvoiceHeader."Currency Code" := CurrencyCode;
        Exit(SalesInvoiceHeader.GetCurrencySymbol());
    end;

    local procedure FormatShipTo(var SalesHeader: Record "Sales Header"; var AddrArray: array[8] of Text[100]; var CustAddr: array[8] of Text[100]; var Handled: Boolean; var Result: Boolean)
    var
        CountryRegion: Record "Country/Region";
        FormatAddress: Codeunit "Format Address";
        SellToCountry: Text;
        I: Integer;
    begin
        Handled := true;

        SalesHeader."Ship-to Contact" := FormatShipToContact(SalesHeader."Ship-to Contact", SalesHeader."TURF Ship-to Phone No.");

        FormatAddress.FormatAddr(
            AddrArray, SalesHeader."Ship-to Name", SalesHeader."Ship-to Name 2", SalesHeader."Ship-to Contact", SalesHeader."Ship-to Address", SalesHeader."Ship-to Address 2",
            SalesHeader."Ship-to City", SalesHeader."Ship-to Post Code", SalesHeader."Ship-to County", SalesHeader."Ship-to Country/Region Code");
        if CountryRegion.Get(SalesHeader."Sell-to Country/Region Code") then
            SellToCountry := CountryRegion.GetTranslatedName(SalesHeader."Language Code");
        if SalesHeader."Sell-to Customer No." <> SalesHeader."Bill-to Customer No." then begin
            Result := true;
            Exit;
        end;

        for i := 1 to ArrayLen(AddrArray) do
            if (AddrArray[i] <> CustAddr[i]) and (AddrArray[i] <> '') and (AddrArray[i] <> SellToCountry) then begin
                Result := true;
                exit;
            end;

        Result := false;
        exit;
    end;

    procedure FormatShipToContact(Contact: Text; PhoneNo: Text): Text[100]
    var
        ShipToContactLbl: Label '%1 - %2', Locked = true;
    begin
        if PhoneNo = '' then
            exit(Copystr(Contact, 1, 100));

        exit(Copystr(StrSubstNo(ShipToContactLbl, Contact, PhoneNo), 1, 100));
    end;
}