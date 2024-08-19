reportextension 70301 "TURFStd Sales Prof. Inv Ext" extends "Standard Sales - Pro Forma Inv"
{
    RDLCLayout = 'src\reportextension\TurfTankProforma.rdlc';
    dataset
    {
        modify(Header)
        {
            trigger OnAfterAfterGetRecord()
            var
                TURFFormatReport: Codeunit "TURFFormat Report";
                FormatAddress: Codeunit "Format Address";
                ReportManagement: Codeunit "TURFReport Management Man";
                RecRef: RecordRef;
                CompInfoSortCode: Code[20];
            begin
                CompanyInfo.Get();
                RecRef.GetTable(CompanyInfo);
                if RecRef.FieldExist(50005) then
                    CompInfoSortCode := RecRef.Field(50005).Value;
                FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
                clear(BottomText);
                BottomText[1] := StrSubstNo(TermsOfPaymentLbl, Paymentterms.Description, header."Due Date");
                if CompInfoSortCode <> '' then begin
                    BottomText[2] := BankAccLbl + CompanyInfo.Name + ' - ' + RecRef.Field(50005).Caption + ': ' + CompInfoSortCode + ' - ' + CompanyInfo.FieldCaption("Bank Account No.") + ': ' + CompanyInfo."Bank Account No.";
                    BottomText[3] := StrSubstNo(PleaseTransferLbl, CompInfoSortCode);
                end else begin
                    BottomText[2] := StrSubstNo(PleaseTransferLbl, companyinfo."Bank Name" + ' ' + companyinfo."Bank Branch No." + ' ' + companyinfo."Bank Account No.");
                    BottomText[3] := CompanyInfo.FieldCaption(IBAN) + ': ' + CompanyInfo.IBAN + ' - ' + CompanyInfo.FieldCaption("SWIFT Code") + ': ' + CompanyInfo."SWIFT Code";
                end;
                BottomText[4] := StrSubstNo(WhenPayingLbl, header."No.");
                BottomText[5] := InterestLbl;

                ShowShippingAddr := FormatAddress.SalesHeaderShipTo(ShipToAddr, CustomerAddress, Header);
            end;
        }
        add(Header)
        {
            column(TURFBottomText1; BottomText[1]) { }
            column(TURFBottomText2; BottomText[2]) { }
            column(TURFBottomText3; BottomText[3]) { }
            column(TURFBottomText4; BottomText[4]) { }
            column(TURFBottomText5; BottomText[5]) { }
            column(TURFShowShippingAddress; ShowShippingAddr)
            {
            }
            column(TURFShipToAddress_Lbl; ShiptoAddrLbl)
            {
            }
            column(TURFShipToAddress1; ShipToAddr[1])
            {
            }
            column(TURFShipToAddress2; ShipToAddr[2])
            {
            }
            column(TURFShipToAddress3; ShipToAddr[3])
            {
            }
            column(TURFShipToAddress4; ShipToAddr[4])
            {
            }
            column(TURFShipToAddress5; ShipToAddr[5])
            {
            }
            column(TURFShipToAddress6; ShipToAddr[6])
            {
            }
            column(TURFShipToAddress7; ShipToAddr[7])
            {
            }
            column(TURFShipToAddress8; ShipToAddr[8])
            {
            }
        }
        add(Line)
        {
            column(TURFItemLbl; Item.Fieldcaption("No.")) { }
            column(TURFItem; Item."No.") { }
        }
    }

    var
        CompanyInfo: Record "Company Information";
        PaymentTerms: Record "Payment Terms";
        FormatDocument: Codeunit "Format Document";
        ShowShippingAddr: Boolean;
        ShipToAddr: array[8] of Text[100];
        BottomText: array[5] of Text;
        TermsOfPaymentLbl: label 'Terms of payment: %1 - Final payment date %2', Comment = '%1 = Payment Description; %2 = Due data';
        PleaseTransferLbl: label 'Please transfer amount to our bank: %1', Comment = '%1 = Bank Name';
        WhenPayingLbl: label 'When paying by bank transfer, please state %1', Comment = '%1 = Document No.';
        InterestLbl: label 'Interest will be changed on overdue payment pursuant to applicable law.';
        BankAccLbl: label 'Account Name: ';
        ShiptoAddrLbl: Label 'Ship-to Address';
}