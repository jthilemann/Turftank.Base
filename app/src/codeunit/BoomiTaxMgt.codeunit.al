codeunit 70306 "TURFBoomi Tax Mgt"
{
    internal procedure GetTaxFromZuora(SalesHeader: Record "Sales Header");
    var
        TaxAmount: Decimal;
    begin
        //GetTaxFromZuora(SalesHeader, TaxAmount);
        TaxAmount := 999;

        InsertUpdateTaxLine(SalesHeader, TaxAmount);
    end;

    local procedure InsertUpdateTaxLine(SalesHeader: Record "Sales Header"; TaxAmount: Decimal)
    var
        BoomiSetup: Record "TURFBoomi Setup";
        SalesLine: Record "Sales Line";
        NextLineNo: Integer;
    begin
        BoomiSetup.GetRecordOnce();
        BoomiSetup.TestField("Default Tax Item");

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
}