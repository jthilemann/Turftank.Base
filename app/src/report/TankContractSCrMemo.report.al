report 70314 "TURFTank Contract S. Cr. Memo"
{
    RDLCLayout = './src/report/layouts/TurfTankSalesCrMemoCont.rdlc';
    Caption = 'Turf Tank Sales Credit Memo';
    DefaultLayout = RDLC;
    EnableHyperlinks = true;
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    PreviewMode = PrintLayout;
    WordMergeDataItem = Header;

    dataset
    {
        dataitem(Header; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Credit Memo';
            column(TURFExtendedAddressInfoLabel; ExtendedAddressInfoLabel) { }
            column(TURFExtendedAddressInfo; SellToCustomer."TURFHubspot Address") { }
            column(CompanyAddress1; CompanyAddr[1]) { }
            column(CompanyAddress2; CompanyAddr[2]) { }
            column(CompanyAddress3; CompanyAddr[3]) { }
            column(CompanyAddress4; CompanyAddr[4]) { }
            column(CompanyAddress5; CompanyAddr[5]) { }
            column(CompanyAddress6; CompanyAddr[6]) { }
            column(CompanyAddress7; CompanyAddr[7]) { }
            column(CompanyAddress8; CompanyAddr[8]) { }
            column(CompanyHomePage; CompanyInfo."Home Page") { }
            column(CompanyEMail; CompanyInfo."E-Mail") { }
            column(CompanyPicture; DummyCompanyInfo.Picture) { }
            column(CompanyPhoneNo; CompanyInfo."Phone No.") { }
            column(CompanyPhoneNo_Lbl; CompanyInfoPhoneNoLbl) { }
            column(CompanyGiroNo; CompanyInfo."Giro No.") { }
            column(CompanyGiroNo_Lbl; CompanyInfoGiroNoLbl) { }
            column(CompanyBankName; CompanyBankAccount.Name) { }
            column(CompanyBankName_Lbl; CompanyInfoBankNameLbl) { }
            column(CompanyBankBranchNo; CompanyBankAccount."Bank Branch No.") { }
            column(CompanyBankBranchNo_Lbl; CompanyBankAccount.FieldCaption("Bank Branch No.")) { }
            column(CompanyBankAccountNo; CompanyBankAccount."Bank Account No.") { }
            column(CompanyBankAccountNo_Lbl; CompanyInfoBankAccNoLbl) { }
            column(CompanyIBAN; CompanyBankAccount.IBAN) { }
            column(CompanyIBAN_Lbl; CompanyBankAccount.FieldCaption(IBAN)) { }
            column(CompanySWIFT; CompanyBankAccount."SWIFT Code") { }
            column(CompanySWIFT_Lbl; CompanyBankAccount.FieldCaption("SWIFT Code")) { }
            column(CompanyLogoPosition; CompanyLogoPosition) { }
            column(CompanyRegistrationNumber; CompanyInfo.GetRegistrationNumber()) { }
            column(CompanyRegistrationNumber_Lbl; CompanyInfo.GetRegistrationNumberLbl()) { }
            column(CompanyVATRegNo; CompanyInfo.GetVATRegistrationNumber()) { }
            column(CompanyVATRegNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl()) { }
            column(CompanyVATRegistrationNo; CompanyInfo.GetVATRegistrationNumber()) { }
            column(CompanyVATRegistrationNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl()) { }
            column(CompanyLegalOffice; '') { }
            column(CompanyLegalOffice_Lbl; '') { }
            column(CompanyCustomGiro; '') { }
            column(CompanyCustomGiro_Lbl; '') { }
            column(CompanyLegalStatement; GetLegalStatement()) { }
            column(DisplayAdditionalFeeNote; false) { }
            column(CustomerAddress1; CustAddr[1]) { }
            column(CustomerAddress2; CustAddr[2]) { }
            column(CustomerAddress3; CustAddr[3]) { }
            column(CustomerAddress4; CustAddr[4]) { }
            column(CustomerAddress5; CustAddr[5]) { }
            column(CustomerAddress6; CustAddr[6]) { }
            column(CustomerAddress7; CustAddr[7]) { }
            column(CustomerAddress8; CustAddr[8]) { }
            column(CustomerPostalBarCode; FormatAddr.PostalBarCode(1)) { }
            column(YourReference; "Your Reference") { }
            column(YourReference_Lbl; FieldCaption("Your Reference")) { }
            column(ShipmentMethodDescription; ShipmentMethod.Description) { }
            column(ShipmentMethodDescription_Lbl; ShptMethodDescLbl) { }
            column(ShipmentDate; Format("Shipment Date", 0, 4)) { }
            column(ShipmentDate_Lbl; ShipmentDateLbl) { }
            column(Shipment_Lbl; ShipmentLbl) { }
            column(ShowShippingAddress; ShowShippingAddr) { }
            column(ShipToAddress_Lbl; ShiptoAddrLbl) { }
            column(ShipToAddress1; ShipToAddr[1]) { }
            column(ShipToAddress2; ShipToAddr[2]) { }
            column(ShipToAddress3; ShipToAddr[3]) { }
            column(ShipToAddress4; ShipToAddr[4]) { }
            column(ShipToAddress5; ShipToAddr[5]) { }
            column(ShipToAddress6; ShipToAddr[6]) { }
            column(ShipToAddress7; ShipToAddr[7]) { }
            column(ShipToAddress8; ShipToAddr[8]) { }
            column(SellToContactPhoneNoLbl; SellToContactPhoneNoLbl) { }
            column(SellToContactMobilePhoneNoLbl; SellToContactMobilePhoneNoLbl) { }
            column(SellToContactEmailLbl; SellToContactEmailLbl) { }
            column(BillToContactPhoneNoLbl; BillToContactPhoneNoLbl) { }
            column(BillToContactMobilePhoneNoLbl; BillToContactMobilePhoneNoLbl) { }
            column(BillToContactEmailLbl; BillToContactEmailLbl) { }
            column(SellToContactPhoneNo; SellToContact."Phone No.") { }
            column(SellToContactMobilePhoneNo; SellToContact."Mobile Phone No.") { }
            column(SellToContactEmail; SellToContact."E-Mail") { }
            column(BillToContactPhoneNo; BillToContact."Phone No.") { }
            column(BillToContactMobilePhoneNo; BillToContact."Mobile Phone No.") { }
            column(BillToContactEmail; BillToContact."E-Mail") { }
            column(PaymentTermsDescription; PaymentTerms.Description) { }
            column(PaymentTermsDescription_Lbl; PaymentTermsDescLbl) { }
            column(PaymentMethodDescription; PaymentMethod.Description) { }
            column(PaymentMethodDescription_Lbl; PaymentMethodDescLbl) { }
            column(BilltoCustumerNo; "Bill-to Customer No.") { }
            column(BilltoCustomerNo_Lbl; FieldCaption("Bill-to Customer No.")) { }
            column(DocumentDate; Format("Document Date", 0, 4)) { }
            column(DocumentDate_Lbl; FieldCaption("Document Date")) { }
            column(DueDate; Format("Due Date", 0, 4)) { }
            column(DueDate_Lbl; FieldCaption("Due Date")) { }
            column(DocumentNo; "No.") { }
            column(DocumentNo_Lbl; CrMemoNoLbl) { }
            column(OrderNo; "Return Order No.") { }
            column(OrderNo_Lbl; FieldCaption("Return Order No.")) { }
            column(PricesIncludingVAT; "Prices Including VAT") { }
            column(PricesIncludingVAT_Lbl; FieldCaption("Prices Including VAT")) { }
            column(PricesIncludingVATYesNo; Format("Prices Including VAT")) { }
            column(SalesPerson_Lbl; SalespersonLbl) { }
            column(SalesPersonBlank_Lbl; SalesPersonText) { }
            column(SalesPersonName; SalespersonPurchaser.Name) { }
            column(SelltoCustomerNo; "Sell-to Customer No.") { }
            column(SelltoCustomerNo_Lbl; FieldCaption("Sell-to Customer No.")) { }
            column(VATRegistrationNo; GetCustomerVATRegistrationNumber()) { }
            column(VATRegistrationNo_Lbl; GetCustomerVATRegistrationNumberLbl()) { }
            column(GlobalLocationNumber; '') { }
            column(GlobalLocationNumber_Lbl; '') { }
            column(SellToFaxNo; '') { }
            column(SellToPhoneNo; "Sell-to Phone No.") { }
            column(PaymentReference; '') { }
            column(From_Lbl; FromLbl) { }
            column(BilledTo_Lbl; BilledToLbl) { }
            column(ChecksPayable_Lbl; ChecksPayableText) { }
            column(PaymentReference_Lbl; '') { }
            column(LegalEntityType; Cust.GetLegalEntityType()) { }
            column(LegalEntityType_Lbl; Cust.GetLegalEntityTypeLbl()) { }
            column(Copy_Lbl; CopyLbl) { }
            column(EMail_Header_Lbl; EMailLbl) { }
            column(HomePage_Header_Lbl; HomePageLbl) { }
            column(InvoiceDiscountBaseAmount_Lbl; InvDiscBaseAmtLbl) { }
            column(InvoiceDiscountAmount_Lbl; InvDiscountAmtLbl) { }
            column(LineAmountAfterInvoiceDiscount_Lbl; LineAmtAfterInvDiscLbl) { }
            column(LocalCurrency_Lbl; LocalCurrencyLbl) { }
            column(ExchangeRateAsText; ExchangeRateText) { }
            column(Page_Lbl; PageLbl) { }
            column(SalesInvoiceLineDiscount_Lbl; SalesInvLineDiscLbl) { }
            column(Questions_Lbl; QuestionsLbl) { }
            column(Contact_Lbl; CompanyInfo.GetContactUsText()) { }
            column(DocumentTitle_Lbl; DocumentCaption()) { }
            column(YourDocumentTitle_Lbl; YourSalesCrMemoLbl) { }
            column(Thanks_Lbl; ThanksLbl) { }
            column(ShowWorkDescription; ShowWorkDescription) { }
            column(RemainingAmount; 0) { }
            column(RemainingAmountText; '') { }
            column(Subtotal_Lbl; SubtotalLbl) { }
            column(Total_Lbl; TotalLbl) { }
            column(VATAmount_Lbl; VATAmtLbl) { }
            column(VATBase_Lbl; VATBaseLbl) { }
            column(VATAmountSpecification_Lbl; VATAmtSpecificationLbl) { }
            column(VATClauses_Lbl; VATClausesLbl) { }
            column(VATIdentifier_Lbl; VATIdentifierLbl) { }
            column(VATPercentage_Lbl; VATPercentageLbl) { }
            column(VATClause_Lbl; VATClause.TableCaption()) { }
            column(PackageTrackingNo; '') { }
            column(PackageTrackingNo_Lbl; '') { }
            column(ShippingAgentCode; "Shipping Agent Code") { }
            column(ShippingAgentCode_Lbl; FieldCaption("Shipping Agent Code")) { }
            column(PaymentInstructions_Txt; '') { }
            column(ExternalDocumentNo; "External Document No.") { }
            column(ExternalDocumentNo_Lbl; FieldCaption("External Document No.")) { }
            column(RespCenterCorpRegNo; RespCenterCorpRegNo) { }
            column(RespCenterTTVatNo; RespCenterTTVatNo) { }
            column(BottomText1; '') { }
            column(BottomText2; '') { }
            column(BottomText3; '') { }
            column(BottomText4; '') { }
            column(BottomText5; '') { }

            dataitem(Line; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = Header;
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(HideSubtotal; 1) { }
                column(SubTotalLineAmount; '') { }
                column(SubTotalUnitPrice; '') { }
                column(LineNo_Line; "Line No.") { }
                column(AmountExcludingVAT_Line; Amount)
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(AmountExcludingVAT_Line_Lbl; FieldCaption(Amount)) { }
                column(AmountIncludingVAT_Line; "Amount Including VAT")
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(AmountIncludingVAT_Line_Lbl; FieldCaption("Amount Including VAT"))
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(Description_Line; Description) { }
                column(Description_2; "Description 2") { }
                column(Description_Line_Lbl; FieldCaption(Description)) { }
                column(LineDiscountPercent_Line; "Line Discount %") { }
                column(LineDiscountPercentText_Line; LineDiscountPctText) { }
                column(LineAmount_Line; FormattedLineAmount)
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(LineAmount_Line_Lbl; FieldCaption("Line Amount")) { }
                column(ItemNo_Line; "No.") { }
                column(ItemNo_Line_Lbl; FieldCaption("No.")) { }
                column(ItemReferenceNo_Line; "Item Reference No.") { }
                column(ItemReferenceNo_Line_Lbl; FieldCaption("Item Reference No.")) { }
                column(ShipmentDate_Line; Format("Shipment Date")) { }
                column(ShipmentDate_Line_Lbl; PostedShipmentDateLbl) { }
                column(Quantity_Line; FormattedQuantity) { }
                column(Quantity_Line_Lbl; FieldCaption(Quantity)) { }
                column(Type_Line; Format(Type)) { }
                column(UnitPrice; FormattedUnitPrice)
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 2;
                }
                column(UnitPrice_Lbl; FieldCaption("Unit Price")) { }
                column(UnitOfMeasure; "Unit of Measure") { }
                column(UnitOfMeasure_Lbl; FieldCaption("Unit of Measure")) { }
                column(VATIdentifier_Line; "VAT Identifier") { }
                column(VATIdentifier_Line_Lbl; FieldCaption("VAT Identifier")) { }
                column(VATPct_Line; FormattedVATPct) { }
                column(VATPct_Line_Lbl; FieldCaption("VAT %")) { }
                column(TransHeaderAmount; TransHeaderAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(JobTaskNo_Lbl; '') { }
                column(JobTaskNo; '') { }
                column(JobTaskDescription; '') { }
                column(JobTaskDesc_Lbl; '') { }
                column(JobNo_Lbl; '') { }
                column(JobNo; '') { }
                column(Unit_Lbl; UnitLbl) { }
                column(Qty_Lbl; QtyLbl) { }
                column(Price_Lbl; PriceLbl) { }
                column(PricePer_Lbl; PricePerLbl) { }
                column(IsCombinedSubscrLine; IsCombinedSubscrLine) { }
                column(CombinedSubscrDescription; CombinedSubscrDescription) { }
                column(CombinedSubscrItemNo; CombinedSubscrItemNo) { }
                column(CombinedSubscrAmount; CombinedSubscrAmount)
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(CombinedSubscrAmountInclVAT; CombinedSubscrAmountInclVAT)
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(CombinedSubscrLineAmount; CombinedSubscrLineAmount)
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                dataitem(ShipmentLine; "Sales Shipment Buffer")
                {
                    DataItemTableView = SORTING("Document No.", "Line No.", "Entry No.");
                    UseTemporary = true;
                    column(DocumentNo_ShipmentLine; "Document No.") { }
                    column(PostingDate_ShipmentLine; "Posting Date") { }
                    column(PostingDate_ShipmentLine_Lbl; FieldCaption("Posting Date")) { }
                    column(Quantity_ShipmentLine; Quantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(Quantity_ShipmentLine_Lbl; FieldCaption(Quantity)) { }

                    trigger OnPreDataItem()
                    begin
                        SetRange("Line No.", Line."Line No.");
                    end;
                }
                dataitem(AssemblyLine; "Posted Assembly Line")
                {
                    DataItemTableView = SORTING("Document No.", "Line No.");
                    UseTemporary = true;
                    column(LineNo_AssemblyLine; "No.") { }
                    column(Description_AssemblyLine; Description) { }
                    column(Quantity_AssemblyLine; Quantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(UnitOfMeasure_AssemblyLine; GetUOMText("Unit of Measure Code")) { }
                    column(VariantCode_AssemblyLine; "Variant Code") { }

                    trigger OnPreDataItem()
                    var
                        ValueEntry: Record "Value Entry";
                    begin
                        Clear(AssemblyLine);
                        if not DisplayAssemblyInformation then
                            CurrReport.Break();
                        GetAssemblyLinesForDocument(
                          AssemblyLine, ValueEntry."Document Type"::"Sales Credit Memo", Line."Document No.", Line."Line No.");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    // Subscription line combining logic - split by tax group + Ava Tax Code
                    IsCombinedSubscrLine := false;
                    Header.testfield("TURFSubscription No.");
                    if Line."TURFCombine Line" then begin
                        // Always accumulate VAT/totals for every combine line
                        InsertVATAmountLine(VATAmountLine, Line);
                        TransHeaderAmount += PrevLineAmount;
                        PrevLineAmount := "Line Amount";
                        TotalSubTotal += "Line Amount";
                        TotalInvDiscAmount -= "Inv. Discount Amount";
                        TotalAmount += Amount;
                        TotalAmountVAT += "Amount Including VAT" - Amount;
                        TotalAmountInclVAT += "Amount Including VAT";
                        TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");

                        // Only render the representative line for this tax group + Ava Tax Code combination
                        if SubscrTaxGroupRepLineNo.ContainsKey(GetSubscrTaxKey("Tax Group Code", "Ava Tax Code")) and
                           (SubscrTaxGroupRepLineNo.Get(GetSubscrTaxKey("Tax Group Code", "Ava Tax Code")) = "Line No.")
                        then begin
                            IsCombinedSubscrLine := true;
                            // Look up combined description scoped to the same tax group + Ava Tax Code
                            CombinedSubscrDescription := GetSubscrCombinedDescription(Header."No.", GetSubscrTaxKey("Tax Group Code", "Ava Tax Code"));
                            if CombinedSubscrItemNo <> '' then
                                "No." := CombinedSubscrItemNo;
                            if CombinedSubscrDescription <> '' then begin
                                Description := CopyStr(CombinedSubscrDescription, 1, MaxStrLen(Description));
                                CombinedSubscrDescription := '';
                            end;
                            if SubscrTaxGroupLineAmounts.ContainsKey(GetSubscrTaxKey("Tax Group Code", "Ava Tax Code")) then begin
                                CombinedSubscrLineAmount := SubscrTaxGroupLineAmounts.Get(GetSubscrTaxKey("Tax Group Code", "Ava Tax Code"));
                                CombinedSubscrAmount := SubscrTaxGroupAmountsExclVAT.Get(GetSubscrTaxKey("Tax Group Code", "Ava Tax Code"));
                                CombinedSubscrAmountInclVAT := SubscrTaxGroupAmountsInclVAT.Get(GetSubscrTaxKey("Tax Group Code", "Ava Tax Code"));
                            end;
                        end else begin
                            // Not the representative line for this tax group + Ava Tax Code – skip rendering
                            if FirstLineHasBeenOutput then
                                Clear(DummyCompanyInfo.Picture);
                            FirstLineHasBeenOutput := true;
                            CurrReport.Skip();
                        end;

                        // Combined lines are fully handled above
                        if FirstLineHasBeenOutput then
                            Clear(DummyCompanyInfo.Picture);
                        FirstLineHasBeenOutput := true;
                        FormatLineValues(Line);
                        if IsCombinedSubscrLine then begin
                            FormattedLineAmount := Format(CombinedSubscrLineAmount, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"));
                            // Unit price = total combined line amount / quantity
                            if Quantity <> 0 then
                                FormattedUnitPrice := Format(CombinedSubscrLineAmount / Quantity, 0, AutoFormat.ResolveAutoFormat("Auto Format"::UnitAmountFormat, Header."Currency Code"))
                            else
                                FormattedUnitPrice := FormattedLineAmount;
                        end;
                        exit;
                    end;

                    if Type = Type::"G/L Account" then
                        "No." := '';

                    if "Line Discount %" = 0 then
                        LineDiscountPctText := ''
                    else
                        LineDiscountPctText := StrSubstNo('%1%', -Round("Line Discount %", 0.1));

                    InsertVATAmountLine(VATAmountLine, Line);

                    TransHeaderAmount += PrevLineAmount;
                    PrevLineAmount := "Line Amount";
                    TotalSubTotal += "Line Amount";
                    TotalInvDiscAmount -= "Inv. Discount Amount";
                    TotalAmount += Amount;
                    TotalAmountVAT += "Amount Including VAT" - Amount;
                    TotalAmountInclVAT += "Amount Including VAT";
                    TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");

                    if FirstLineHasBeenOutput then
                        Clear(DummyCompanyInfo.Picture);
                    FirstLineHasBeenOutput := true;

                    FormatLineValues(Line);
                end;

                trigger OnPreDataItem()
                var
                    SalesCrMemoLine2: Record "Sales Cr.Memo Line";
                begin
                    VATAmountLine.DeleteAll();
                    VATClauseLine.DeleteAll();
                    ShipmentLine.Reset();
                    ShipmentLine.DeleteAll();
                    MoreLines := Find('+');
                    while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                        MoreLines := Next(-1) <> 0;
                    if not MoreLines then
                        CurrReport.Break();
                    SetRange("Line No.", 0, "Line No.");
                    TransHeaderAmount := 0;
                    PrevLineAmount := 0;
                    FirstLineHasBeenOutput := false;
                    DummyCompanyInfo.Picture := CompanyInfo.Picture;

                    // Pre-calculate combined subscription totals per tax group code
                    IsCombinedSubscrLine := false;
                    Clear(CombinedSubscrDescription);
                    Clear(CombinedSubscrItemNo);
                    Clear(CombinedSubscrAmount);
                    Clear(CombinedSubscrAmountInclVAT);
                    Clear(CombinedSubscrLineAmount);
                    Clear(SubscrTaxGroupLineAmounts);
                    Clear(SubscrTaxGroupAmountsExclVAT);
                    Clear(SubscrTaxGroupAmountsInclVAT);
                    Clear(SubscrTaxGroupRepLineNo);

                    // Find the robot item no. from the subscription lines
                    SubscrRobotItemNo := GetSubscrRobotItemNo(Header."TURFSubscription No.");

                    SalesCrMemoLine2.SetRange("Document No.", Header."No.");
                    SalesCrMemoLine2.SetRange("TURFCombine Line", true);
                    if SalesCrMemoLine2.FindSet() then
                        repeat
                            // Accumulate per tax group + Ava Tax Code to keep lines with different AvaTax codes separate
                            if SubscrTaxGroupLineAmounts.ContainsKey(GetSubscrTaxKey(SalesCrMemoLine2."Tax Group Code", SalesCrMemoLine2."Ava Tax Code")) then begin
                                SubscrTaxGroupLineAmounts.Set(GetSubscrTaxKey(SalesCrMemoLine2."Tax Group Code", SalesCrMemoLine2."Ava Tax Code"),
                                    SubscrTaxGroupLineAmounts.Get(GetSubscrTaxKey(SalesCrMemoLine2."Tax Group Code", SalesCrMemoLine2."Ava Tax Code")) + SalesCrMemoLine2."Line Amount");
                                SubscrTaxGroupAmountsExclVAT.Set(GetSubscrTaxKey(SalesCrMemoLine2."Tax Group Code", SalesCrMemoLine2."Ava Tax Code"),
                                    SubscrTaxGroupAmountsExclVAT.Get(GetSubscrTaxKey(SalesCrMemoLine2."Tax Group Code", SalesCrMemoLine2."Ava Tax Code")) + SalesCrMemoLine2.Amount);
                                SubscrTaxGroupAmountsInclVAT.Set(GetSubscrTaxKey(SalesCrMemoLine2."Tax Group Code", SalesCrMemoLine2."Ava Tax Code"),
                                    SubscrTaxGroupAmountsInclVAT.Get(GetSubscrTaxKey(SalesCrMemoLine2."Tax Group Code", SalesCrMemoLine2."Ava Tax Code")) + SalesCrMemoLine2."Amount Including VAT");
                            end else begin
                                SubscrTaxGroupLineAmounts.Add(GetSubscrTaxKey(SalesCrMemoLine2."Tax Group Code", SalesCrMemoLine2."Ava Tax Code"), SalesCrMemoLine2."Line Amount");
                                SubscrTaxGroupAmountsExclVAT.Add(GetSubscrTaxKey(SalesCrMemoLine2."Tax Group Code", SalesCrMemoLine2."Ava Tax Code"), SalesCrMemoLine2.Amount);
                                SubscrTaxGroupAmountsInclVAT.Add(GetSubscrTaxKey(SalesCrMemoLine2."Tax Group Code", SalesCrMemoLine2."Ava Tax Code"), SalesCrMemoLine2."Amount Including VAT");
                            end;
                            // Track the representative line: prefer the robot item line; fall back to first line seen
                            // Match on Phantom Sku (original item no.) if available, otherwise fall back to No.
                            if not SubscrTaxGroupRepLineNo.ContainsKey(GetSubscrTaxKey(SalesCrMemoLine2."Tax Group Code", SalesCrMemoLine2."Ava Tax Code")) then
                                SubscrTaxGroupRepLineNo.Add(GetSubscrTaxKey(SalesCrMemoLine2."Tax Group Code", SalesCrMemoLine2."Ava Tax Code"), SalesCrMemoLine2."Line No.")
                            else
                                if (SubscrRobotItemNo <> '') and
                                   ((SalesCrMemoLine2."TURFPhantom Sku" = SubscrRobotItemNo) or
                                    ((SalesCrMemoLine2."TURFPhantom Sku" = '') and (SalesCrMemoLine2."No." = SubscrRobotItemNo)))
                                then
                                    SubscrTaxGroupRepLineNo.Set(GetSubscrTaxKey(SalesCrMemoLine2."Tax Group Code", SalesCrMemoLine2."Ava Tax Code"), SalesCrMemoLine2."Line No.");
                        until SalesCrMemoLine2.Next() = 0;
                end;
            }
            dataitem(WorkDescriptionLines; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 .. 99999));
                column(WorkDescriptionLineNumber; Number) { }
                column(WorkDescriptionLine; WorkDescriptionLine) { }

                trigger OnAfterGetRecord()
                var
                    TypeHelper: Codeunit "Type Helper";
                begin
                    if WorkDescriptionInstream.EOS then
                        CurrReport.Break();
                    WorkDescriptionLine := TypeHelper.ReadAsTextWithSeparator(WorkDescriptionInstream, TypeHelper.LFSeparator());
                end;

                trigger OnPostDataItem()
                begin
                    Clear(WorkDescriptionInstream)
                end;

                trigger OnPreDataItem()
                begin
                    if not ShowWorkDescription then
                        CurrReport.Break();
                    Header."Work Description".CreateInStream(WorkDescriptionInstream, TEXTENCODING::UTF8);
                end;
            }
            dataitem(VATAmountLine; "VAT Amount Line")
            {
                DataItemTableView = SORTING("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
                UseTemporary = true;
                column(InvoiceDiscountAmount_VATAmountLine; "Invoice Discount Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(InvoiceDiscountAmount_VATAmountLine_Lbl; FieldCaption("Invoice Discount Amount")) { }
                column(InvoiceDiscountBaseAmount_VATAmountLine; "Inv. Disc. Base Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(InvoiceDiscountBaseAmount_VATAmountLine_Lbl; FieldCaption("Inv. Disc. Base Amount")) { }
                column(LineAmount_VatAmountLine; "Line Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(LineAmount_VatAmountLine_Lbl; FieldCaption("Line Amount")) { }

                column(VATAmount_VatAmountLine; "VAT Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmount_VatAmountLine_Lbl; FieldCaption("VAT Amount")) { }
                column(VATAmountLCY_VATAmountLine; VATAmountLCY) { }
                column(VATAmountLCY_VATAmountLine_Lbl; VATAmountLCYLbl) { }
                column(VATBase_VatAmountLine; "VAT Base")
                {
                    AutoFormatExpression = Line.GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(VATBase_VatAmountLine_Lbl; FieldCaption("VAT Base")) { }
                column(VATBaseLCY_VATAmountLine; VATBaseLCY) { }
                column(VATBaseLCY_VATAmountLine_Lbl; VATBaseLCYLbl) { }
                column(VATIdentifier_VatAmountLine; "VAT Identifier") { }
                column(VATIdentifier_VatAmountLine_Lbl; FieldCaption("VAT Identifier")) { }
                column(VATPct_VatAmountLine; "VAT %") { DecimalPlaces = 0 : 5; }
                column(VATPct_VatAmountLine_Lbl; FieldCaption("VAT %")) { }
                column(NoOfVATIdentifiers; Count) { }

                trigger OnAfterGetRecord()
                begin
                    VATBaseLCY := GetBaseLCY(Header."Posting Date", Header."Currency Code", Header."Currency Factor");
                    VATAmountLCY := GetAmountLCY(Header."Posting Date", Header."Currency Code", Header."Currency Factor");
                    TotalVATBaseLCY += VATBaseLCY;
                    TotalVATAmountLCY += VATAmountLCY;
                    TotalVATBaseOnVATAmtLine += "VAT Base";
                    TotalVATAmountOnVATAmtLine += "VAT Amount";
                    if ShowVATClause("VAT Clause Code") then begin
                        VATClauseLine := VATAmountLine;
                        if VATClauseLine.Insert() then;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    Clear(VATBaseLCY);
                    Clear(VATAmountLCY);
                    TotalVATBaseLCY := 0;
                    TotalVATAmountLCY := 0;
                    TotalVATBaseOnVATAmtLine := 0;
                    TotalVATAmountOnVATAmtLine := 0;
                end;
            }
            dataitem(VATClauseLine; "VAT Amount Line")
            {
                DataItemTableView = SORTING("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
                UseTemporary = true;
                column(VATClausesHeader; VATClausesText) { }
                column(VATIdentifier_VATClauseLine; "VAT Identifier") { }
                column(Code_VATClauseLine; VATClause.Code) { }
                column(Code_VATClauseLine_Lbl; VATClause.FieldCaption(Code)) { }
                column(Description_VATClauseLine; VATClauseText) { }
                column(Description2_VATClauseLine; VATClause."Description 2") { }
                column(VATAmount_VATClauseLine; "VAT Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(NoOfVATClauses; Count) { }

                trigger OnAfterGetRecord()
                begin
                    if "VAT Clause Code" = '' then CurrReport.Skip();
                    if not VATClause.Get("VAT Clause Code") then CurrReport.Skip();
                    VATClauseText := VATClause.GetDescriptionText(Header);
                end;

                trigger OnPreDataItem()
                begin
                    if Count = 0 then VATClausesText := '' else VATClausesText := VATClausesLbl;
                end;
            }
            dataitem(ReportTotalsLine; "Report Totals Buffer")
            {
                DataItemTableView = SORTING("Line No.");
                UseTemporary = true;
                column(Description_ReportTotalsLine; Description) { }
                column(Amount_ReportTotalsLine; Amount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(AmountFormatted_ReportTotalsLine; "Amount Formatted")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(FontBold_ReportTotalsLine; "Font Bold") { }
                column(FontUnderline_ReportTotalsLine; "Font Underline") { }

                trigger OnPreDataItem()
                begin
                    CreateReportTotalLines();
                end;
            }
            dataitem(LineFee; "Integer")
            {
                DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = FILTER(1 ..));
                column(LineFeeCaptionText; '') { }
                trigger OnAfterGetRecord()
                begin
                    CurrReport.Break();
                end;
            }
            dataitem(PaymentReportingArgument; "Payment Reporting Argument")
            {
                DataItemTableView = SORTING(Key);
                UseTemporary = true;
                column(PaymentServiceLogo; Logo) { }
                column(PaymentServiceLogo_UrlText; "URL Caption") { }
                column(PaymentServiceLogo_Url; GetTargetURL()) { }
                column(PaymentServiceText_UrlText; "URL Caption") { }
                column(PaymentServiceText_Url; GetTargetURL()) { }
            }
            dataitem(LeftHeader; "Name/Value Buffer")
            {
                DataItemTableView = SORTING(ID);
                UseTemporary = true;
                column(LeftHeaderName; Name) { }
                column(LeftHeaderValue; Value) { }
            }
            dataitem(RightHeader; "Name/Value Buffer")
            {
                DataItemTableView = SORTING(ID);
                UseTemporary = true;
                column(RightHeaderName; Name) { }
                column(RightHeaderValue; Value) { }
            }
            dataitem(LetterText; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(GreetingText; GreetingLbl) { }
                column(BodyText; BodyLbl) { }
                column(ClosingText; ClosingLbl) { }
                column(PmtDiscText; '') { }
            }
            dataitem(Totals; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(TotalNetAmount; Format(TotalAmount, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"))) { }
                column(TotalVATBaseLCY; TotalVATBaseLCY) { }
                column(TotalAmountIncludingVAT; Format(TotalAmountInclVAT, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"))) { }
                column(TotalVATAmount; Format(TotalAmountVAT, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"))) { }
                column(TotalVATAmountLCY; TotalVATAmountLCY) { }
                column(TotalInvoiceDiscountAmount; Format(TotalInvDiscAmount, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"))) { }
                column(TotalPaymentDiscountOnVAT; TotalPaymentDiscOnVAT) { }
                column(TotalVATAmountText; VATAmountLine.VATAmountText()) { }
                column(TotalExcludingVATText; TotalExclVATText) { }
                column(TotalIncludingVATText; TotalInclVATText) { }
                column(TotalSubTotal; Format(TotalSubTotal, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"))) { }
                column(TotalSubTotalMinusInvoiceDiscount; Format(TotalSubTotal + TotalInvDiscAmount, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"))) { }
                column(TotalText; TotalText) { }
                column(TotalAmountExclInclVAT; Format(TotalAmountExclInclVATValue, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"))) { }
                column(TotalAmountExclInclVATText; TotalAmountExclInclVATTextValue) { }
                column(TotalVATBaseOnVATAmtLine; TotalVATBaseOnVATAmtLine) { }
                column(TotalVATAmountOnVATAmtLine; TotalVATAmountOnVATAmtLine) { }
                column(CurrencyCode; CurrCode) { }
                column(CurrencySymbol; CurrSymbol) { }

                trigger OnPreDataItem()
                begin
                    if Header."Prices Including VAT" then begin
                        TotalAmountExclInclVATTextValue := TotalExclVATText;
                        TotalAmountExclInclVATValue := TotalAmount;
                    end else begin
                        TotalAmountExclInclVATTextValue := TotalInclVATText;
                        TotalAmountExclInclVATValue := TotalAmountInclVAT;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            var
                CurrencyExchangeRate: Record "Currency Exchange Rate";
                Currency: Record Currency;
                GeneralLedgerSetup: Record "General Ledger Setup";
            begin
                CurrReport.Language := LanguageRec.GetLanguageIdOrDefault("Language Code");
                if not IsReportInPreviewMode() then
                    CODEUNIT.Run(CODEUNIT::"Sales Cr. Memo-Printed", Header);
                CalcFields("Work Description");
                ShowWorkDescription := "Work Description".HasValue;
                ChecksPayableText := StrSubstNo(ChecksPayableLbl, CompanyInfo.Name);
                FormatAddressFields(Header);
                FormatDocumentFields(Header);
                if SellToContact.Get("Sell-to Contact No.") then;
                if BillToContact.Get("Bill-to Contact No.") then;
                if not CompanyBankAccount.Get(Header."Company Bank Account Code") then
                    CompanyBankAccount.CopyBankFieldsFromCompanyInfo(CompanyInfo);
                FillLeftHeader();
                FillRightHeader();
                if not Cust.Get("Bill-to Customer No.") then Clear(Cust);
                if "Currency Code" <> '' then begin
                    CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
                    CalculatedExchRate := Round(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                    ExchangeRateText := StrSubstNo(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
                    CurrCode := "Currency Code";
                    if Currency.Get("Currency Code") then CurrSymbol := Currency.GetCurrencySymbol();
                end else
                    if GeneralLedgerSetup.Get() then begin
                        CurrCode := GeneralLedgerSetup."LCY Code";
                        CurrSymbol := GeneralLedgerSetup.GetCurrencySymbol();
                    end;
                TotalSubTotal := 0;
                TotalInvDiscAmount := 0;
                TotalAmount := 0;
                TotalAmountVAT := 0;
                TotalAmountInclVAT := 0;
                TotalPaymentDiscOnVAT := 0;
                Clear(ExtendedAddressInfoLabel);
                SellToCustomer.Get(Header."Sell-to Customer No.");
                if SellToCustomer."TURFHubspot Address" <> '' then
                    ExtendedAddressInfoLabel := ExtendedAddressInfoLbl;
            end;

            trigger OnPreDataItem()
            begin
                FirstLineHasBeenOutput := false;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(LogInteraction; LogTheInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies that interactions with the contact are logged.';
                    }
                    field(DisplayAsmInformation; DisplayAssemblyInformation)
                    {
                        ApplicationArea = Assembly;
                        Caption = 'Show Assembly Components';
                        ToolTip = 'Specifies if you want the report to include information about components that were used in linked assembly orders.';
                    }
                    field(DisplayShipmentInformation; DisplayTheShipmentInformation)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Shipments';
                        ToolTip = 'Specifies that shipments are shown on the document.';
                    }
                }
            }
        }
        actions { }
        trigger OnInit()
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage()
        begin
            LogInteractionEnable := LogTheInteraction;
        end;
    }

    labels { }

    trigger OnInitReport()
    begin
        GLSetup.Get();
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.Get();
        SalesSetup.Get();
        CompanyInfo.VerifyAndSetPaymentInfo();
    end;

    trigger OnPostReport()
    begin
        if LogTheInteraction and not IsReportInPreviewMode() then
            if Header.FindSet() then
                repeat
                    if Header."Bill-to Contact No." <> '' then
                        SegManagement.LogDocument(6, Header."No.", 0, 0, DATABASE::Contact, Header."Bill-to Contact No.", Header."Salesperson Code", Header."Campaign No.", Header."Posting Description", '')
                    else
                        SegManagement.LogDocument(6, Header."No.", 0, 0, DATABASE::Customer, Header."Bill-to Customer No.", Header."Salesperson Code", Header."Campaign No.", Header."Posting Description", '');
                until Header.Next() = 0;
    end;

    trigger OnPreReport()
    begin
        if Header.GetFilters = '' then Error(NoFilterSetErr);
        CompanyLogoPosition := SalesSetup."Logo Position on Documents";
    end;

    var
        GLSetup: Record "General Ledger Setup";
        SellToCustomer: Record Customer;
        PaymentMethod: Record "Payment Method";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        CompanyBankAccount: Record "Bank Account";
        CompanyInfo: Record "Company Information";
        DummyCompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        RespCenter: Record "Responsibility Center";
        VATClause: Record "VAT Clause";
        SellToContact: Record Contact;
        BillToContact: Record Contact;
        LanguageRec: Codeunit Language;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        AutoFormat: Codeunit "Auto Format";
        WorkDescriptionInstream: InStream;
        RespCenterTTVatNo, RespCenterCorpRegNo : Text;
        WorkDescriptionLine: Text;
        ExtendedAddressInfoLbl: Label 'Extended address';
        ExtendedAddressInfoLabel: Text;
        ChecksPayableText: Text;
        CompanyAddr: array[8] of Text[100];
        SalesPersonText: Text[50];
        TotalText: Text[50];
        TotalAmountExclInclVATTextValue: Text;
        MoreLines: Boolean;
        ShowWorkDescription: Boolean;
        LogTheInteraction: Boolean;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        TransHeaderAmount: Decimal;
        LogInteractionEnable: Boolean;
        CompanyLogoPosition: Integer;
        CalculatedExchRate: Decimal;
        ExchangeRateText: Text;
        TotalVATBaseLCY: Decimal;
        TotalVATAmountLCY: Decimal;
        TotalVATBaseOnVATAmtLine: Decimal;
        TotalVATAmountOnVATAmtLine: Decimal;
        PrevLineAmount: Decimal;
        TotalAmountExclInclVATValue: Decimal;
        CurrCode: Text[10];
        CurrSymbol: Text[10];
        IsCombinedSubscrLine: Boolean;
        CombinedSubscrDescription: Text;
        CombinedSubscrItemNo: Code[20];
        CombinedSubscrAmount: Decimal;
        CombinedSubscrAmountInclVAT: Decimal;
        CombinedSubscrLineAmount: Decimal;
        SubscrTaxGroupLineAmounts: Dictionary of [Text, Decimal];
        SubscrTaxGroupAmountsExclVAT: Dictionary of [Text, Decimal];
        SubscrTaxGroupAmountsInclVAT: Dictionary of [Text, Decimal];
        SubscrTaxGroupRepLineNo: Dictionary of [Text, Integer];
        SubscrRobotItemNo: Code[20];
        SalespersonLbl: Label 'Salesperson';
        CompanyInfoBankAccNoLbl: Label 'Account No.';
        CompanyInfoBankNameLbl: Label 'Bank';
        CompanyInfoGiroNoLbl: Label 'Giro No.';
        CompanyInfoPhoneNoLbl: Label 'Phone No.';
        CopyLbl: Label 'Copy';
        EMailLbl: Label 'Email';
        HomePageLbl: Label 'Home Page';
        InvDiscBaseAmtLbl: Label 'Invoice Discount Base Amount';
        InvDiscountAmtLbl: Label 'Invoice Discount';
        CrMemoNoLbl: Label 'Credit Memo No.';
        LineAmtAfterInvDiscLbl: Label 'Payment Discount on VAT';
        LocalCurrencyLbl: Label 'Local Currency';
        PageLbl: Label 'Page';
        PaymentMethodDescLbl: Label 'Payment Method';
        PostedShipmentDateLbl: Label 'Shipment Date';
        SalesInvLineDiscLbl: Label 'Discount %';
        SalesCrMemoLbl: Label 'Credit Memo';
        YourSalesCrMemoLbl: Label 'Your Credit Memo';
        ShipmentLbl: Label 'Shipment';
        SubtotalLbl: Label 'Subtotal';
        TotalLbl: Label 'Total';
        VATAmtSpecificationLbl: Label 'VAT Amount Specification';
        VATAmtLbl: Label 'VAT Amount';
        VATAmountLCYLbl: Label 'VAT Amount (LCY)';
        VATBaseLbl: Label 'VAT Base';
        VATBaseLCYLbl: Label 'VAT Base (LCY)';
        VATClausesLbl: Label 'VAT Clause';
        VATIdentifierLbl: Label 'VAT Identifier';
        VATPercentageLbl: Label 'VAT %';
        SellToContactPhoneNoLbl: Label 'Sell-to Contact Phone No.';
        SellToContactMobilePhoneNoLbl: Label 'Sell-to Contact Mobile Phone No.';
        SellToContactEmailLbl: Label 'Sell-to Contact E-Mail';
        BillToContactPhoneNoLbl: Label 'Bill-to Contact Phone No.';
        BillToContactMobilePhoneNoLbl: Label 'Bill-to Contact Mobile Phone No.';
        BillToContactEmailLbl: Label 'Bill-to Contact E-Mail';
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        NoFilterSetErr: Label 'You must specify one or more filters to avoid accidently printing all documents.';
        GreetingLbl: Label 'Hello';
        ClosingLbl: Label 'Sincerely';
        BodyLbl: Label 'Thank you for your business. Your credit memo is attached to this message.';
        FromLbl: Label 'From';
        BilledToLbl: Label 'Billed to';
        ChecksPayableLbl: Label 'Please make checks payable to %1', Comment = '%1 = company name';
        QuestionsLbl: Label 'Questions?';
        ThanksLbl: Label 'Thank You!';
        VATClausesText: Text;
        VATClauseText: Text;
        LCYTxt: Label ' (LCY)';
        UnitLbl: Label 'Unit';
        QtyLbl: Label 'Qty', Comment = 'Short form of Quantity';
        PriceLbl: Label 'Price';
        PricePerLbl: Label 'Price per';
        ShipmentDateLbl: Label 'Shipment Date';
        PaymentTermsDescLbl: Label 'Payment Terms';
        ShptMethodDescLbl: Label 'Shipment Method';
        ShiptoAddrLbl: Label 'Ship-to Address';

    protected var
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        FormattedLineAmount: Text;
        FormattedQuantity: Text;
        FormattedUnitPrice: Text;
        FormattedVATPct: Text;
        LineDiscountPctText: Text;
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalSubTotal: Decimal;
        VATBaseLCY: Decimal;
        VATAmountLCY: Decimal;
        DisplayAssemblyInformation: Boolean;
        DisplayTheShipmentInformation: Boolean;
        FirstLineHasBeenOutput: Boolean;
        ShowShippingAddr: Boolean;

    local procedure FormatAddressFields(var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        RecRef: RecordRef;
    begin
        FormatAddr.GetCompanyAddr(SalesCrMemoHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesCrMemoBillTo(CustAddr, SalesCrMemoHeader);
        ShowShippingAddr := FormatAddr.SalesCrMemoShipTo(ShipToAddr, CustAddr, SalesCrMemoHeader);
        RecRef.GetTable(RespCenter);
        if RecRef.FieldExist(50000) then RespCenterTTVatNo := RecRef.Field(50000).Value;
        if RecRef.FieldExist(50005) then RespCenterCorpRegNo := RecRef.Field(50005).Value;
    end;

    local procedure FormatDocumentFields(SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        FormatDocument.SetTotalLabels(SalesCrMemoHeader."Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetSalesPerson(SalespersonPurchaser, SalesCrMemoHeader."Salesperson Code", SalesPersonText);
        FormatDocument.SetPaymentTerms(PaymentTerms, SalesCrMemoHeader."Payment Terms Code", SalesCrMemoHeader."Language Code");
        FormatDocument.SetPaymentMethod(PaymentMethod, SalesCrMemoHeader."Payment Method Code", SalesCrMemoHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesCrMemoHeader."Shipment Method Code", SalesCrMemoHeader."Language Code");
    end;

    local procedure DocumentCaption(): Text[250]
    begin
        exit(SalesCrMemoLbl);
    end;

    procedure InitializeRequest(NewLogInteraction: Boolean; DisplayAsmInfo: Boolean)
    begin
        LogTheInteraction := NewLogInteraction;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview or MailManagement.IsHandlingGetEmailBody());
    end;

    local procedure GetUOMText(UOMCode: Code[10]): Text[50]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.Get(UOMCode) then exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    local procedure CreateReportTotalLines()
    begin
        ReportTotalsLine.DeleteAll();
        if (TotalInvDiscAmount <> 0) or (TotalAmountVAT <> 0) then
            ReportTotalsLine.Add(SubtotalLbl, TotalSubTotal, true, false, false);
        if TotalInvDiscAmount <> 0 then begin
            ReportTotalsLine.Add(InvDiscountAmtLbl, TotalInvDiscAmount, false, false, false);
            if TotalAmountVAT <> 0 then
                if Header."Prices Including VAT" then
                    ReportTotalsLine.Add(TotalInclVATText, TotalAmountInclVAT, true, false, false)
                else
                    ReportTotalsLine.Add(TotalExclVATText, TotalAmount, true, false, false);
        end;
        if TotalAmountVAT <> 0 then begin
            ReportTotalsLine.Add(VATAmountLine.VATAmountText(), TotalAmountVAT, false, true, false);
            if TotalVATAmountLCY <> TotalAmountVAT then
                ReportTotalsLine.Add(VATAmountLine.VATAmountText() + LCYTxt, TotalVATAmountLCY, false, true, false);
        end;
    end;

    local procedure FillLeftHeader()
    begin
        LeftHeader.DeleteAll();
        FillNameValueTable(LeftHeader, Header.FieldCaption("External Document No."), Header."External Document No.");
        FillNameValueTable(LeftHeader, Header.FieldCaption("Bill-to Customer No."), Header."Bill-to Customer No.");
        FillNameValueTable(LeftHeader, Header.GetCustomerVATRegistrationNumberLbl(), Header.GetCustomerVATRegistrationNumber());
        FillNameValueTable(LeftHeader, CrMemoNoLbl, Header."No.");
        FillNameValueTable(LeftHeader, Header.FieldCaption("Posting Date"), Format(Header."Posting Date", 0, 4));
        FillNameValueTable(LeftHeader, Header.FieldCaption("Return Order No."), Header."Return Order No.");
        FillNameValueTable(LeftHeader, Header.FieldCaption("Document Date"), Format(Header."Document Date", 0, 4));
        FillNameValueTable(LeftHeader, Header.FieldCaption("Due Date"), Format(Header."Due Date", 0, 4));
        FillNameValueTable(LeftHeader, PaymentTermsDescLbl, PaymentTerms.Description);
        FillNameValueTable(LeftHeader, PaymentMethodDescLbl, PaymentMethod.Description);
    end;

    local procedure FillRightHeader()
    begin
        RightHeader.DeleteAll();
        FillNameValueTable(RightHeader, EMailLbl, CompanyInfo."E-Mail");
        FillNameValueTable(RightHeader, HomePageLbl, CompanyInfo."Home Page");
        FillNameValueTable(RightHeader, CompanyInfoPhoneNoLbl, CompanyInfo."Phone No.");
        FillNameValueTable(RightHeader, CompanyInfo.GetRegistrationNumberLbl(), CompanyInfo.GetRegistrationNumber());
        FillNameValueTable(RightHeader, CompanyInfo.GetVATRegistrationNumberLbl(), CompanyInfo.GetVATRegistrationNumber());
    end;

    local procedure FillNameValueTable(var NameValueBuffer: Record "Name/Value Buffer"; Name: Text; Value: Text)
    var
        KeyIndex: Integer;
    begin
        if Value <> '' then begin
            Clear(NameValueBuffer);
            if NameValueBuffer.FindLast() then KeyIndex := NameValueBuffer.ID + 1;
            NameValueBuffer.Init();
            NameValueBuffer.ID := KeyIndex;
            NameValueBuffer.Name := CopyStr(Name, 1, MaxStrLen(NameValueBuffer.Name));
            NameValueBuffer.Value := CopyStr(Value, 1, MaxStrLen(NameValueBuffer.Value));
            NameValueBuffer.Insert();
        end;
    end;

    local procedure InsertVATAmountLine(var VATAmountLine2: Record "VAT Amount Line"; SalesCrMemoLine: Record "Sales Cr.Memo Line")
    begin
        VATAmountLine2.Init();
        VATAmountLine2."VAT Identifier" := SalesCrMemoLine."VAT Identifier";
        VATAmountLine2."VAT Calculation Type" := SalesCrMemoLine."VAT Calculation Type";
        VATAmountLine2."Tax Group Code" := SalesCrMemoLine."Tax Group Code";
        VATAmountLine2."VAT %" := SalesCrMemoLine."VAT %";
        VATAmountLine2."VAT Base" := SalesCrMemoLine.Amount;
        VATAmountLine2."Amount Including VAT" := SalesCrMemoLine."Amount Including VAT";
        VATAmountLine2."Line Amount" := SalesCrMemoLine."Line Amount";
        if SalesCrMemoLine."Allow Invoice Disc." then
            VATAmountLine2."Inv. Disc. Base Amount" := SalesCrMemoLine."Line Amount";
        VATAmountLine2."Invoice Discount Amount" := SalesCrMemoLine."Inv. Discount Amount";
        VATAmountLine2."VAT Clause Code" := SalesCrMemoLine."VAT Clause Code";
        VATAmountLine2.InsertLine();
    end;

    local procedure FormatLineValues(CurrLine: Record "Sales Cr.Memo Line")
    begin
        FormatDocument.SetSalesCrMemoLine(CurrLine, FormattedQuantity, FormattedUnitPrice, FormattedVATPct, FormattedLineAmount);
    end;

    local procedure ShowVATClause(VATClauseCode: Code[20]): Boolean
    begin
        if VATClauseCode = '' then exit(false);
        exit(true);
    end;

    local procedure GetSubscrCombinedDescription(CrMemoNo: Code[20]; TaxKey: Text): Text
    var
        SalesCrMemoLine2: Record "Sales Cr.Memo Line";
        SalesCrMemoLine3: Record "Sales Cr.Memo Line";
        SubscrInvoiceDescMap: Record "TURFSubscr Invoice Desc. Map";
        SecondItemNo: Code[20];
        BestDescription: Text;
        BestItemNo: Code[20];
    begin
        // Find the mapping entry whose Item No. 1 matches the Phantom Sku of a combine line
        // that belongs to the same tax group + Ava Tax Code as the current representative line (TaxKey).
        SalesCrMemoLine2.SetRange("Document No.", CrMemoNo);
        SalesCrMemoLine2.SetRange("TURFCombine Line", true);
        if not SalesCrMemoLine2.FindSet() then
            exit('');

        repeat
            // Only process lines that belong to the same tax group + Ava Tax Code as the representative line
            if GetSubscrTaxKey(SalesCrMemoLine2."Tax Group Code", SalesCrMemoLine2."Ava Tax Code") <> TaxKey then
                Continue;

            // Use Phantom Sku as the primary lookup key; fall back to No. if Phantom Sku is blank
            if SalesCrMemoLine2."TURFPhantom Sku" <> '' then
                SubscrInvoiceDescMap.SetRange("Item No. 1", SalesCrMemoLine2."TURFPhantom Sku")
            else
                SubscrInvoiceDescMap.SetRange("Item No. 1", SalesCrMemoLine2."No.");
            if SubscrInvoiceDescMap.FindSet() then begin
                repeat
                    SecondItemNo := SubscrInvoiceDescMap."Item No. 2";
                    if SecondItemNo <> '' then begin
                        // Check if Item No. 2 matches another combine line's Phantom Sku (or No.)
                        SalesCrMemoLine3.SetRange("Document No.", CrMemoNo);
                        SalesCrMemoLine3.SetRange("TURFCombine Line", true);
                        if SalesCrMemoLine3.FindSet() then
                            repeat
                                if (SalesCrMemoLine3."TURFPhantom Sku" = SecondItemNo) or
                                   ((SalesCrMemoLine3."TURFPhantom Sku" = '') and (SalesCrMemoLine3."No." = SecondItemNo))
                                then begin
                                    if SubscrInvoiceDescMap.Description <> '' then begin
                                        CombinedSubscrItemNo := SubscrInvoiceDescMap."Item No. 1";
                                        exit(SubscrInvoiceDescMap.Description);
                                    end;
                                end;
                            until SalesCrMemoLine3.Next() = 0;
                    end else begin
                        // Item No. 2 is blank – base entry; keep as fallback
                        if (BestDescription = '') and (SubscrInvoiceDescMap.Description <> '') then begin
                            BestDescription := SubscrInvoiceDescMap.Description;
                            BestItemNo := SubscrInvoiceDescMap."Item No. 1";
                        end;
                    end;
                until SubscrInvoiceDescMap.Next() = 0;
            end;
        until SalesCrMemoLine2.Next() = 0;

        // Return the best fallback description found
        if BestDescription <> '' then begin
            CombinedSubscrItemNo := BestItemNo;
            exit(BestDescription);
        end;

        exit('');
    end;

    local procedure GetSubscrTaxKey(TaxGroupCode: Code[20]; AvaTaxCode: Code[20]): Text
    begin
        exit(TaxGroupCode + '|' + AvaTaxCode);
    end;

    local procedure GetSubscrRobotItemNo(SubscriptionNo: Code[20]): Code[20]
    var
        SubscrLine: Record "TURFSubscr Line";
    begin
        if SubscriptionNo = '' then exit('');
        SubscrLine.SetRange("Subscription No.", SubscriptionNo);
        SubscrLine.SetRange("Line Type", "TURFSubscr Line Type"::Period);
        SubscrLine.SetRange("Is Paint", false);
        SubscrLine.SetRange("Is Processing Fee", false);
        SubscrLine.SetRange("Is Implementation Fee", false);
        if SubscrLine.FindFirst() then exit(SubscrLine."Item No.");
        exit('');
    end;
}
