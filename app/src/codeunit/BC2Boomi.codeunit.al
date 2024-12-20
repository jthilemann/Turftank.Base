codeunit 70308 TURFBC2Boomi
{
    Permissions = tabledata "Sales Invoice Header" = M;

    var
        TURFBoomiSetup: Record "TURFBoomi Setup";

    internal procedure GetTaxEstimate(SalesHeader: Record "Sales Header"; var TaxAmount: Decimal): Boolean
    var
        Customer: Record Customer;
        SalesLine: Record "Sales Line";
        HdrObj: JsonObject;
        LineObj: JsonObject;
        LinesArray: JsonArray;
        ResponseTxt: Text;
        BodyContent: Text;
        JsonObj: JsonObject;
        JsonTkn: JsonToken;
    begin
        TURFBoomiSetup.GetRecordOnce();
        Customer.Get(SalesHeader."Sell-to Customer No.");
        Customer.TestField("TURFZuora Account Number");
        HdrObj.Add('type', '1');
        HdrObj.Add('zuoraAccountNo', Customer."TURFZuora Account Number");
        if SalesHeader."Posting Date" <> 0D then
            HdrObj.Add('orderDate', Format(SalesHeader."Posting Date", 0, '<year4>-<month,2>-<day,2>'))
        else
            HdrObj.Add('orderDate', Format(SalesHeader."Document Date", 0, '<year4>-<month,2>-<day,2>'));

        HdrObj.Add('documentNumber', SalesHeader."No.");
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if SalesLine.FindSet(false) then
            repeat
                Clear(LineObj);
                LineObj.Add('subscribeToRatePlans', SalesLine."No.");
                LineObj.Add('quantity', SalesLine.Quantity);
                LinesArray.Add(LineObj);
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
        LineObj: JsonObject;
        LinesArray: JsonArray;
        ResponseTxt: Text;
        BodyContent: Text;
        JsonObj: JsonObject;
        JsonTkn: JsonToken;
    begin
        TURFBoomiSetup.GetRecordOnce();
        Customer.Get(SalesInvoiceHeader."Sell-to Customer No.");
        Customer.TestField("TURFZuora Account Number");
        HdrObj.Add('type', '2');
        HdrObj.Add('zuoraAccountNo', Customer."TURFZuora Account Number");
        HdrObj.Add('orderDate', Format(SalesInvoiceHeader."Posting Date", 0, '<year4>-<month,2>-<day,2>'));
        HdrObj.Add('documentNumber', SalesInvoiceHeader."No.");
        SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
        SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
        if SalesInvoiceLine.FindSet(false) then
            repeat
                Clear(LineObj);
                LineObj.Add('subscribeToRatePlans', SalesInvoiceLine."No.");
                LineObj.Add('quantity', SalesInvoiceLine.Quantity);
                LinesArray.Add(LineObj);
            until SalesInvoiceLine.Next() = 0;
        HdrObj.Add('items', LinesArray);

        HdrObj.WriteTo(BodyContent);

        if SendRequest(Enum::"Http Method"::POST, TURFBoomiSetup."Tax Estimate URL", BodyContent, ResponseTxt) then begin
            JsonObj.ReadFrom(ResponseTxt);
            JsonObj.Get('orderNumber', JsonTkn);
            SalesInvoiceHeader."TURFZuora Order No." := Copystr(JsonTkn.AsValue().AsText(), 1, MaxStrLen(SalesInvoiceHeader."TURFZuora Order No."));
            JsonObj.Get('subscriptionNumber', JsonTkn);
            SalesInvoiceHeader."TURFZuora Subscription No." := Copystr(JsonTkn.AsValue().AsText(), 1, MaxStrLen(SalesInvoiceHeader."TURFZuora Subscription No."));
            SalesInvoiceHeader."TURFSent to Boomi" := CurrentDateTime();
            SalesInvoiceHeader.Modify(false)
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
}