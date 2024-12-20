codeunit 70306 "TURFBoomi Mgt"
{
    var
        BoomiSetup: Record "TURFBoomi Setup";

    internal procedure GetTaxFromZuora(SalesHeader: Record "Sales Header");
    var
        BC2Boomi: Codeunit TURFBC2Boomi;
        TaxAmount: Decimal;
    begin
        RemoveExistingTaxLine(SalesHeader);
        BC2Boomi.GetTaxEstimate(SalesHeader, TaxAmount);
        InsertUpdateTaxLine(SalesHeader, TaxAmount);
    end;

    internal procedure SendInvoiceToBoomi(SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        BC2Boomi: Codeunit TURFBC2Boomi;
    begin
        SalesInvoiceHeader.TestField("TURFSent to Boomi", 0DT);
        BC2Boomi.SendInvoiceToBoomi(SalesInvoiceHeader);
    end;

    local procedure InsertUpdateTaxLine(SalesHeader: Record "Sales Header"; TaxAmount: Decimal)
    var
        SalesLine: Record "Sales Line";
        NextLineNo: Integer;
    begin
        GetBoomiSetup();

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange("Type", SalesLine.Type::Item);
        SalesLine.SetRange("No.", BoomiSetup."Default Tax Item");
        if SalesLine.FindFirst() then
            SalesLine.Delete(true);

        SalesLine.SetRange("Type");
        SalesLine.SetRange("No.");
        if SalesLine.FindLast() then;

        NextLineNo := SalesLine."Line No." + 10000;

        SalesLine.init();
        SalesLine.Validate("Document Type", SalesHeader."Document Type");
        SalesLine.Validate("Document No.", SalesHeader."No.");
        SalesLine.Validate("Type", SalesLine.Type::Item);
        SalesLine.Validate("No.", BoomiSetup."Default Tax Item");
        SalesLine.Validate("Line No.", NextLineNo);
        SalesLine.Validate("Quantity", 1);
        SalesLine.Validate("Unit Price", TaxAmount);
        SalesLine.Insert(true);
    end;

    local procedure RemoveExistingTaxLine(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        GetBoomiSetup();
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange("Type", SalesLine.Type::Item);
        SalesLine.SetRange("No.", BoomiSetup."Default Tax Item");
        if not SalesLine.IsEmpty() then
            SalesLine.DeleteAll(true);
    end;

    local procedure GetBoomiSetup()
    begin
        BoomiSetup.GetRecordOnce();
        BoomiSetup.TestField("Default Tax Item");
    end;
}