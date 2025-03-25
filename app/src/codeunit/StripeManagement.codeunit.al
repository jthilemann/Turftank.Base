codeunit 70309 "TURFStripe Management"
{
    Permissions = tabledata "Sales Invoice Header" = M;

    var
        GenJournalLine2: Record "Gen. Journal Line";
        TurfTankStripeSetup: Record "TURFTank Stripe Setup";

    internal procedure ApplyWebshopOrders(JournalTemplateName: Code[10]; JnlBatchName: Code[10])
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        ChargeId: Text;
        LastLineNo: Integer;
        JsonObj: JsonObject;
        JTkn: JsonToken;
        ChargePathLbl: Label 'charges?payment_intent=%1', Locked = true;
        BalanceTransactionPathLbl: Label 'balance_transactions?type=charge&source=%1', Locked = true;
    begin
        TurfTankStripeSetup.GetRecordOnce();

        LastLineNo := GetLastGenJournalLine(JournalTemplateName, JnlBatchName);
        SalesInvoiceHeader.SetRange("TURFStripe Reconciled", false);
        SalesInvoiceHeader.SetFilter("TURFPayment Identification", '<>%1', '');
        if SalesInvoiceHeader.FindSet(false) then
            repeat
                if SendRequest(StrSubstNo(ChargePathLbl, SalesInvoiceHeader."TURFPayment Identification"), JsonObj) then
                    if JsonObj.AsToken().SelectToken('$.data[0].id', JTkn) then
                        ChargeId := JTkn.AsValue().AsText();

                if ChargeId <> '' then
                    if SendRequest(StrSubstNo(BalanceTransactionPathLbl, ChargeId), JsonObj) then
                        ReconcileAmount(JournalTemplateName, JnlBatchName, SalesInvoiceHeader, JsonObj, LastLineNo);

            until SalesInvoiceHeader.Next() = 0;
    end;

    local procedure SendRequest(Path: Text; var JsonObj: JsonObject): Boolean
    var
        Client: HttpClient;
        ResponseMsg: HttpResponseMessage;
        ClientHeaders: HttpHeaders;
        Result: Text;
        URL: Text;
        Success: Boolean;
        BearerLbl: Label 'Bearer %1', Locked = true;
    begin
        Clear(JsonObj);
        url := TurfTankStripeSetup."Stripe Base URL" + Path;
        ClientHeaders := Client.DefaultRequestHeaders();
        ClientHeaders.Add('accept', 'application/json');
        ClientHeaders.Add('Authorization', StrSubstNo(BearerLbl, TurfTankStripeSetup."Stripe Bearer Token"));
        Success := Client.Get(URL, ResponseMsg);
        if Success then begin
            Success := ResponseMsg.IsSuccessStatusCode;
            ResponseMsg.Content().ReadAs(Result);
            JsonObj.ReadFrom(Result);
        end;
        exit(Success);
    end;

    local procedure ReconcileAmount(JournalTemplateName: Code[10]; JnlBatchName: Code[10]; SalesInvoiceHeader: Record "Sales Invoice Header"; JsonObj: JsonObject; var NextLineNo: Integer)
    var
        GenJournalLine: Record "Gen. Journal Line";
        Amount, BankAmount, FeeAmount : Decimal;
        PostingDate: Date;
        ExternalDocNo: Code[35];
        BankShopifyPmntLbl: Label 'Bank Stripe Europe payment';
        FeeShopifyLbl: Label 'Fee Stribe Europe';
    begin
        GetValuesFromJson(PostingDate, ExternalDocNo, Amount, BankAmount, FeeAmount, JsonObj);

        if PostingDate < SalesInvoiceHeader."Posting Date" then
            PostingDate := SalesInvoiceHeader."Posting Date";

        InsertCashReceiptLine(JournalTemplateName, JnlBatchName, GenJournalLine, NextLineNo, PostingDate, ExternalDocNo, Amount);

        if FeeAmount <> 0 then
            InsertSumLine(JournalTemplateName, JnlBatchName, NextLineNo, FeeAmount, FeeShopifyLbl, Enum::"Gen. Journal Account Type"::"G/L Account", TurfTankStripeSetup."Stripe Fee G/L Account No.");

        if BankAmount <> 0 then
            InsertSumLine(JournalTemplateName, JnlBatchName, NextLineNo, BankAmount, BankShopifyPmntLbl, Enum::"Gen. Journal Account Type"::"Bank Account", TurfTankStripeSetup."Stripe Payments Bank No.");

        SalesInvoiceHeader."TURFStripe Reconciled" := true;
        SalesInvoiceHeader.Modify(false);
    end;

    local procedure GetLastGenJournalLine(JournalTemplateName: Code[10]; JnlBatchName: Code[10]): Integer
    begin
        GenJournalLine2.SetRange("Journal Template Name", JournalTemplateName);
        GenJournalLine2.SetRange("Journal Batch Name", JnlBatchName);
        if GenJournalLine2.FindLast() then;
    end;

    local procedure InsertCashReceiptLine(JournalTemplateName: Code[20]; JournalBatchName: Code[20]; var GenJournalLine: Record "Gen. Journal Line"; NextLineNo: Integer; PostingDate: Date; ExternalDocNo: Code[35]; Amount: Decimal)
    var
        StripePaymentLbl: Label 'Stripe Payment';
    begin
        GenJournalLine.INIT();
        GenJournalLine.validate("Journal Template Name", JournalTemplateName);
        GenJournalLine.validate("Journal Batch Name", JournalBatchName);
        GenJournalLine.SetUpNewLine(GenJournalLine2, 0, false);
        GenJournalLine.validate("Document Type", GenJournalLine."Document Type"::" ");
        GenJournalLine.validate("Line No.", NextLineNo);
        GenJournalLine.validate("Account Type", GenJournalLine."Account Type"::"G/L Account");
        GenJournalLine.validate("Account No.", TurfTankStripeSetup."Stripe Interim Account");
        GenJournalLine.validate("Posting Date", PostingDate);
        GenJournalLine.validate("External Document No.", ExternalDocNo);
        GenJournalLine.validate(Description, StripePaymentLbl);
        GenJournalLine.validate(Amount, -Amount);
        GenJournalLine.Insert(true);

        GenJournalLine2 := GenJournalLine;
    end;

    local procedure InsertSumLine(JournalTemplateName: Code[10]; JnlBatchName: Code[10]; var NextLineNo: Integer; NewAmount: Decimal; Description: Text[50]; GenJournalAccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[20])
    var

        GenJournalLine: Record "Gen. Journal Line";
    begin
        NextLineNo += 10000;
        GenJournalLine.SetRange("Journal Template Name", JournalTemplateName);
        GenJournalLine.SetRange("Journal Batch Name", JnlBatchName);
        GenJournalLine.SetRange("Account Type", GenJournalAccountType);
        GenJournalLine.SetRange("Account No.", AccountNo);
        if not GenJournalLine.FindFirst() then begin
            GenJournalLine.Init();
            GenJournalLine.validate("Journal Template Name", JournalTemplateName);
            GenJournalLine.validate("Journal Batch Name", JnlBatchName);
            GenJournalLine.SetUpNewLine(GenJournalLine2, 0, false);
            GenJournalLine.validate("Document Type", GenJournalLine."Document Type"::" ");
            GenJournalLine.validate("Account Type", GenJournalAccountType);
            GenJournalLine.Validate("Account No.", AccountNo);
            GenJournalLine.validate("Line No.", NextLineNo);

            GenJournalLine.validate("Posting Date", GenJournalLine2."Posting Date");
            GenJournalLine.validate(Description, Description);
            GenJournalLine.Insert(true);

            GenJournalLine2 := GenJournalLine;
        end;

        GenJournalLine.validate(Amount, GenJournalLine.Amount + NewAmount);
        GenJournalLine.Modify(false);
    end;

    local procedure GetValuesFromJson(var PostingDate: Date; var ExternalDocNo: Code[35]; var Amount: Decimal; var BankAmount: Decimal; var FeeAmount: Decimal; JsonObj: JsonObject)
    var
        TypeHelper: Codeunit "Type Helper";
        PostingDateTime: Datetime;
        JsonData: JsonObject;
        JsonTkn: JsonToken;
        JArray: JsonArray;
        TimeStamp: BigInteger;
    begin
        if JsonObj.Get('data', JsonTkn) then begin
            JArray := JsonTkn.AsArray();
            if JArray.Get(0, JsonTkn) then begin
                JsonData := JsonTkn.AsObject();
                JsonData.Get('id', JsonTkn);
                ExternalDocNo := CopyStr(JsonTkn.AsValue().AsText(), 1, MaxStrLen(ExternalDocNo));
                JsonData.Get('available_on', JsonTkn);
                TimeStamp := JsonTkn.AsValue().AsBigInteger();
                PostingDateTime := TypeHelper.EvaluateUnixTimestamp(TimeStamp);
                PostingDate := DT2Date(PostingDateTime);
                JsonData.Get('amount', JsonTkn);
                Amount := JsonTkn.AsValue().AsDecimal() / 100;
                JsonData.Get('fee', JsonTkn);
                FeeAmount := JsonTkn.AsValue().AsDecimal() / 100;
                JsonData.Get('net', JsonTkn);
                BankAmount := JsonTkn.AsValue().AsDecimal() / 100;
            end;
        end;
    end;
}