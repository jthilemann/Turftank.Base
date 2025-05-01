codeunit 70308 TURFBC2Boomi
{
    Permissions = tabledata "Sales Invoice Header" = M, tabledata "Sales Cr.Memo Header" = M;


    var
        TURFBoomiSetup: Record "TURFBoomi Setup";

    internal procedure GetTaxEstimate(SalesHeader: Record "Sales Header"; var TaxAmount: Decimal): Boolean
    var
        Customer: Record Customer;
        SalesLine: Record "Sales Line";
        HdrObj: JsonObject;
        LinesArray: JsonArray;
        ResponseTxt: Text;
        BodyContent: Text;
        UseDate: Date;
        JsonObj: JsonObject;
        JsonTkn: JsonToken;
    begin
        TURFBoomiSetup.GetRecordOnce();
        Customer.Get(SalesHeader."Sell-to Customer No.");
        Customer.TestField("TURFZuora Account Number");
        if SalesHeader."Posting Date" <> 0D then
            UseDate := SalesHeader."Posting Date"
        else
            UseDate := SalesHeader."Document Date";

        CreateHeader(HdrObj, Customer."TURFZuora Account Number", UseDate, SalesHeader."No.", '', SalesHeader."External Document No.", 1);

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if SalesLine.FindSet(false) then
            repeat
                AddLineToArray(LinesArray, SalesLine."No.", SalesLine.Quantity, SalesLine."Unit Price", SalesLine."Line Amount");
            until SalesLine.Next() = 0;
        HdrObj.Add('items', LinesArray);

        HdrObj.WriteTo(BodyContent);

        if SendRequest(Enum::"Http Method"::POST, TURFBoomiSetup."Tax Estimate URL", BodyContent, ResponseTxt) then begin
            JsonObj.ReadFrom(ResponseTxt);
            JsonObj.Get('TaxAmount', JsonTkn);
            TaxAmount := JsonTkn.AsValue().AsDecimal();
        end else
            Error(ResponseTxt);
    end;

    internal procedure SendInvoiceToBoomi(SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        Customer: Record Customer;
        SalesInvoiceLine: Record "Sales Invoice Line";
        HdrObj: JsonObject;
        LinesArray: JsonArray;
        ResponseTxt: Text;
        BodyContent: Text;
        JsonObj: JsonObject;
        JsonTkn: JsonToken;
    begin
        TURFBoomiSetup.GetRecordOnce();
        Customer.Get(SalesInvoiceHeader."Sell-to Customer No.");
        Customer.TestField("TURFZuora Account Number");

        CreateHeader(HdrObj, Customer."TURFZuora Account Number", SalesInvoiceHeader."Posting Date", SalesInvoiceHeader."No.", SalesInvoiceHeader."Order No.", SalesInvoiceHeader."External Document No.", 2);
        SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
        SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
        SalesInvoiceLine.SetFilter("No.", '<>%1', TURFBoomiSetup."Default Tax Item");
        if SalesInvoiceLine.FindSet(false) then
            repeat
                AddLineToArray(LinesArray, SalesInvoiceLine."No.", SalesInvoiceLine.Quantity, SalesInvoiceLine."Unit Price", SalesInvoiceLine."Line Amount");
            until SalesInvoiceLine.Next() = 0;
        HdrObj.Add('items', LinesArray);

        HdrObj.WriteTo(BodyContent);

        if SendRequest(Enum::"Http Method"::POST, TURFBoomiSetup."Tax Estimate URL", BodyContent, ResponseTxt) then begin
            JsonObj.ReadFrom(ResponseTxt);
            JsonObj.Get('orderNumber', JsonTkn);
            SalesInvoiceHeader."TURFZuora Order No." := Copystr(JsonTkn.AsValue().AsText(), 1, MaxStrLen(SalesInvoiceHeader."TURFZuora Order No."));
            JsonObj.Get('subscriptionNumber', JsonTkn);
            SalesInvoiceHeader."TURFZuora Subscription No." := Copystr(JsonTkn.AsValue().AsText(), 1, MaxStrLen(SalesInvoiceHeader."TURFZuora Subscription No."));
            JsonObj.Get('invoiceNumber', JsonTkn);
            SalesInvoiceHeader."TURFZuora Invoice No." := Copystr(JsonTkn.AsValue().AsText(), 1, MaxStrLen(SalesInvoiceHeader."TURFZuora Invoice No."));
            SalesInvoiceHeader."TURFSent to Boomi" := CurrentDateTime();
            SalesInvoiceHeader.Modify(false)
        end else
            Error(ResponseTxt);
    end;

    internal procedure SendCreditMemoToBoomi(SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        Customer: Record Customer;
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        HdrObj: JsonObject;
        LinesArray: JsonArray;
        ResponseTxt: Text;
        BodyContent: Text;
        JsonObj: JsonObject;
        JsonTkn: JsonToken;
    begin
        TURFBoomiSetup.GetRecordOnce();
        Customer.Get(SalesCrMemoHeader."Sell-to Customer No.");
        Customer.TestField("TURFZuora Account Number");
        if SalesCrMemoHeader."Applies-to Doc. No." <> '' then
            CreateHeader(HdrObj, Customer."TURFZuora Account Number", SalesCrMemoHeader."Posting Date", SalesCrMemoHeader."No.", SalesCrMemoHeader."Applies-to Doc. No.", SalesCrMemoHeader."External Document No.", 4)
        else
            CreateHeader(HdrObj, Customer."TURFZuora Account Number", SalesCrMemoHeader."Posting Date", SalesCrMemoHeader."No.", '', SalesCrMemoHeader."External Document No.", 3);
        SalesCrMemoLine.SetRange("Document No.", SalesCrMemoHeader."No.");
        SalesCrMemoLine.SetRange(Type, SalesCrMemoLine.Type::Item);
        SalesCrMemoLine.SetFilter("No.", '<>%1', TURFBoomiSetup."Default Tax Item");
        if SalesCrMemoLine.FindSet(false) then
            repeat
                AddLineToArray(LinesArray, SalesCrMemoLine."No.", SalesCrMemoLine.Quantity, SalesCrMemoLine."Unit Price", SalesCrMemoLine."Line Amount");
            until SalesCrMemoLine.Next() = 0;
        HdrObj.Add('items', LinesArray);

        HdrObj.WriteTo(BodyContent);

        if SendRequest(Enum::"Http Method"::POST, TURFBoomiSetup."Tax Estimate URL", BodyContent, ResponseTxt) then begin
            JsonObj.ReadFrom(ResponseTxt);
            JsonObj.Get('creditMemoNumber', JsonTkn);
            SalesCrMemoHeader."TURFZuora Order No." := Copystr(JsonTkn.AsValue().AsText(), 1, MaxStrLen(SalesCrMemoHeader."TURFZuora Order No."));
            SalesCrMemoHeader."TURFSent to Boomi" := CurrentDateTime();
            SalesCrMemoHeader.Modify(false)
        end else
            Error(ResponseTxt);
    end;

    local procedure SendRequest(HttpMethod: Enum "Http Method"; URL: Text; Body: Text; var ResponseText: Text): Boolean
    var
        Client: HttpClient;
        Content: HttpContent;
        ResponseMsg: HttpResponseMessage;
        ClientHeaders: HttpHeaders;
        ContentHeader: HttpHeaders;
        Success: Boolean;
        ErrorMsgFormatLbl: Label 'Reason: %1\Response: %2', Locked = true;
    begin
        ClientHeaders := Client.DefaultRequestHeaders();
        ClientHeaders.Add('accept', 'application/json');
        AddAuthorizationHeader(ClientHeaders);
        case HttpMethod of
            HttpMethod::GET:
                Success := Client.Get(URL, ResponseMsg);
            HttpMethod::POST:
                begin
                    Content.WriteFrom(Body);
                    Content.GetHeaders(ContentHeader);
                    ContentHeader.Remove('Content-Type');
                    ContentHeader.Add('Content-Type', 'application/json');
                    Success := Client.Post(URL, Content, ResponseMsg);
                end;
        end;

        if ResponseMsg.Content().ReadAs(ResponseText) then;

        Success := Success and ResponseMsg.IsSuccessStatusCode;

        if not Success then
            ResponseText := StrSubstNo(ErrorMsgFormatLbl, ResponseMsg.ReasonPhrase, ResponseText);
        exit(Success);
    end;

    local procedure AddAuthorizationHeader(var ClientHeaders: HttpHeaders)
    var
        Base64Convert: Codeunit "Base64 Convert";
        AuthString: Text;
        AuthTemplateLbl: Label '%1:%2', Locked = true;
        BasicAuthTemplateLbl: Label 'Basic %1', Locked = true;
    begin
        AuthString := StrSubstNo(AuthTemplateLbl, TURFBoomiSetup."Boomi Username", TURFBoomiSetup."Boomi Password");
        AuthString := Base64Convert.ToBase64(AuthString);
        AuthString := StrSubstNo(BasicAuthTemplateLbl, AuthString);
        ClientHeaders.Add('Authorization', AuthString);
    end;

    local procedure AddLineToArray(var LinesArray: JsonArray; No: Code[20]; Quantity: Decimal; UnitPrice: Decimal; LineAmount: Decimal)
    var
        LineObj: JsonObject;
    begin
        Clear(LineObj);
        LineObj.Add('subscribeToRatePlans', No);
        LineObj.Add('quantity', Quantity);
        LineObj.Add('unitPrice', UnitPrice);
        LineObj.Add('amount', LineAmount);
        LinesArray.Add(LineObj);
    end;

    local procedure CreateHeader(var HdrObj: JsonObject; ZuoraAccountNumber: Text; orderDate: Date; DocumentNo: Text; ReferenceNo: code[20]; ExtDocNo: code[35]; Type: Integer)
    begin
        HdrObj.Add('type', Format(type));
        HdrObj.Add('zuoraAccountNo', ZuoraAccountNumber);
        HdrObj.Add('orderDate', Format(orderDate, 0, '<year4>-<month,2>-<day,2>'));
        HdrObj.Add('documentNumber', DocumentNo);
        HdrObj.Add('poNumber', ExtDocNo);
        if ReferenceNo <> '' then
            HdrObj.Add('referenceNumber', ReferenceNo);
    end;
}