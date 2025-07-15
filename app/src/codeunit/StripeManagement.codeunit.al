codeunit 70309 "TURFStripe Management"
{
    Permissions = tabledata "Sales Invoice Header" = M;

    var
        GenJournalLine2: Record "Gen. Journal Line";
        TurfTankStripeSetup: Record "TURFTank Stripe Setup";

    internal procedure ApplyWebshopOrders(JournalTemplateName: Code[10]; JnlBatchName: Code[10]; ReturnOrder: Boolean)
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        BalanceTransaction: Text;
        LastLineNo: Integer;
        JsonObj: JsonObject;
        JTkn: JsonToken;
        ChargePathLbl: Label 'charges?payment_intent=%1', Locked = true;
        BalanceTransactionPathLbl: Label 'balance_transactions/%1', Locked = true;
    begin
        TurfTankStripeSetup.GetRecordOnce();

        LastLineNo := GetLastGenJournalLine(JournalTemplateName, JnlBatchName);

        if ReturnOrder then begin
            SalesCrMemoHeader.SetRange("TURFStripe Reconciled", false);
            SalesCrMemoHeader.SetFilter("TURFPayment Identification", '<>%1', '');
            if SalesCrMemoHeader.FindSet(false) then
                repeat
                    if SendRequest(StrSubstNo(ChargePathLbl, SalesCrMemoHeader."TURFPayment Identification"), JsonObj) then
                        if JsonObj.AsToken().SelectToken('$.data[0].balance_transaction', JTkn) then
                            BalanceTransaction := JTkn.AsValue().AsText();

                    if BalanceTransaction <> '' then
                        if SendRequest(StrSubstNo(BalanceTransactionPathLbl, BalanceTransaction), JsonObj) then begin
                            ReconcileAmount(JournalTemplateName, JnlBatchName, SalesCrMemoHeader."Posting Date", SalesCrMemoHeader."Currency Code", JsonObj, LastLineNo, true);
                            SalesCrMemoHeader."TURFStripe Reconciled" := true;
                            SalesCrMemoHeader.Modify(false);
                        end;

                until SalesCrMemoHeader.Next() = 0;
        end else begin
            SalesInvoiceHeader.SetRange("TURFStripe Reconciled", false);
            SalesInvoiceHeader.SetFilter("TURFPayment Identification", '<>%1', '');
            if SalesInvoiceHeader.FindSet(false) then
                repeat
                    if SendRequest(StrSubstNo(ChargePathLbl, SalesInvoiceHeader."TURFPayment Identification"), JsonObj) then
                        if JsonObj.AsToken().SelectToken('$.data[0].balance_transaction', JTkn) then
                            BalanceTransaction := JTkn.AsValue().AsText();

                    if BalanceTransaction <> '' then
                        if SendRequest(StrSubstNo(BalanceTransactionPathLbl, BalanceTransaction), JsonObj) then begin
                            ReconcileAmount(JournalTemplateName, JnlBatchName, SalesInvoiceHeader."Posting Date", SalesInvoiceHeader."Currency Code", JsonObj, LastLineNo, false);
                            SalesInvoiceHeader."TURFStripe Reconciled" := true;
                            SalesInvoiceHeader.Modify(false);
                        end;
                until SalesInvoiceHeader.Next() = 0;
        end;
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

    local procedure ReconcileAmount(JournalTemplateName: Code[10]; JnlBatchName: Code[10]; PostingDate: Date; CurrencyCode: Code[10]; JsonObj: JsonObject; var NextLineNo: Integer; ReturnOrder: Boolean)
    var
        GenJournalLine: Record "Gen. Journal Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Amount, BankAmount, FeeAmount : Decimal;
        UsePostingDate: Date;
        ExternalDocNo: Code[35];
        BankAccountNo: Code[20];
        BankShopifyPmntLbl: Label 'Bank Stripe Europe payment';
        FeeShopifyLbl: Label 'Fee Stribe Europe';
    begin
        GetValuesFromJson(UsePostingDate, ExternalDocNo, Amount, BankAmount, FeeAmount, JsonObj);

        if UsePostingDate < PostingDate then
            UsePostingDate := PostingDate;

        if ReturnOrder then begin
            InsertCashReceiptLine(JournalTemplateName, JnlBatchName, GenJournalLine, NextLineNo, UsePostingDate, ExternalDocNo, Amount);
            BankAmount := -BankAmount;
            FeeAmount := -FeeAmount;
        end else
            InsertCashReceiptLine(JournalTemplateName, JnlBatchName, GenJournalLine, NextLineNo, UsePostingDate, ExternalDocNo, -Amount);

        if FeeAmount <> 0 then
            InsertSumLine(JournalTemplateName, JnlBatchName, NextLineNo, FeeAmount, FeeShopifyLbl, Enum::"Gen. Journal Account Type"::"G/L Account", TurfTankStripeSetup."Stripe Fee G/L Account No.");

        BankAccountNo := CurrencyCode;
        if BankAccountNo = '' then begin
            GeneralLedgerSetup.GetRecordOnce();
            BankAccountNo := GeneralLedgerSetup."LCY Code";
        end;

        if BankAmount <> 0 then
            InsertSumLine(JournalTemplateName, JnlBatchName, NextLineNo, BankAmount, BankShopifyPmntLbl, Enum::"Gen. Journal Account Type"::"Bank Account", BankAccountNo);
    end;

    local procedure GetLastGenJournalLine(JournalTemplateName: Code[10]; JnlBatchName: Code[10]): Integer
    begin
        GenJournalLine2.SetRange("Journal Template Name", JournalTemplateName);
        GenJournalLine2.SetRange("Journal Batch Name", JnlBatchName);
        if GenJournalLine2.FindLast() then;
    end;

    local procedure InsertCashReceiptLine(JournalTemplateName: Code[20]; JournalBatchName: Code[20]; var GenJournalLine: Record "Gen. Journal Line"; var NextLineNo: Integer; PostingDate: Date; ExternalDocNo: Code[35]; Amount: Decimal)
    var
        StripePaymentLbl: Label 'Stripe Payment';
    begin
        NextLineNo += 10000;

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
        GenJournalLine.validate(Amount, Amount);
        GenJournalLine.validate("Shortcut Dimension 1 Code", TurfTankStripeSetup."TURFWebshop Def. Global Dim. 1");
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
            GenJournalLine.validate("Shortcut Dimension 1 Code", TurfTankStripeSetup."TURFWebshop Def. Global Dim. 1");
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
        JsonTkn: JsonToken;
        TimeStamp: BigInteger;
    begin
        if JsonObj.Get('id', JsonTkn) then begin
            ExternalDocNo := CopyStr(JsonTkn.AsValue().AsText(), 1, MaxStrLen(ExternalDocNo));
            JsonObj.Get('available_on', JsonTkn);
            TimeStamp := JsonTkn.AsValue().AsBigInteger();
            PostingDateTime := TypeHelper.EvaluateUnixTimestamp(TimeStamp);
            PostingDate := DT2Date(PostingDateTime);
            JsonObj.Get('amount', JsonTkn);
            Amount := JsonTkn.AsValue().AsDecimal() / 100;
            JsonObj.Get('fee', JsonTkn);
            FeeAmount := JsonTkn.AsValue().AsDecimal() / 100;
            JsonObj.Get('net', JsonTkn);
            BankAmount := JsonTkn.AsValue().AsDecimal() / 100;
        end;
    end;

    internal procedure ResetReconciledSalesInvoice(var SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        SalesInvoiceHeader."TURFStripe Reconciled" := false;
        SalesInvoiceHeader.Modify(false);
    end;
}