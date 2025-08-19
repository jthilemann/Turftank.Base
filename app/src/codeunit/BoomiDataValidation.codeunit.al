// codeunit 70311 "TURFBoomiDataValidation"
// {
//     procedure ValidateData(boomiDataValidation: Enum "TURFBoomiDataValidation"; referenceNumber: Code[50]): Text
//     begin
//         case boomiDataValidation of
//             "TURFBoomiDataValidation"::SalesOrder:
//                 Exit(GetReferenceDataForSalesOrder(referenceNumber));
//             "TURFBoomiDataValidation"::Invoice:
//                 Exit(GetReferenceDataForInvoice(referenceNumber));
//             "TURFBoomiDataValidation"::CreditMemo:
//                 Exit(GetReferenceDataForCreditMemo(referenceNumber));
//             "TURFBoomiDataValidation"::Payment:
//                 Exit(GetReferenceDataForPayment(referenceNumber));
//         end;
//     end;

//     local procedure GetReferenceDataForSalesOrder(referenceNumber: Code[50]): Text
//     var
//         SalesHeader: Record "Sales Header";
//     begin
//         SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::"Blanket Order");
//         SalesHeader.SetRange("TURFZuora Subscription No.", referenceNumber);
//         if SalesHeader.FindFirst() then
//             Exit(BuildJsonResponse(True, 'zuoraSubscriptionNumber', SalesHeader."TURFZuora Subscription No.", 'blanketSalesOrderNumber', SalesHeader."No.", SalesHeader."Sell-to Customer No.", SalesHeader.SystemCreatedAt))
//         else
//             Exit(BuildJsonResponse(false, 'zuoraSubscriptionNumber', SalesHeader."TURFZuora Subscription No.", 'blanketSalesOrderNumber', SalesHeader."No.", SalesHeader."Sell-to Customer No.", SalesHeader.SystemCreatedAt))
//     end;

//     local procedure GetReferenceDataForInvoice(referenceNumber: Code[50]): Text
//     begin
//         Error('Procedure GetReferenceDataForInvoice not implemented.');
//     end;

//     local procedure GetReferenceDataForCreditMemo(referenceNumber: Code[50]): Text
//     begin
//         Error('Procedure GetReferenceDataForCreditMemo not implemented.');
//     end;

//     local procedure GetReferenceDataForPayment(referenceNumber: Code[50]): Text
//     begin
//         Error('Procedure GetReferenceDataForPayment not implemented.');
//     end;

//     local procedure BuildJsonResponse(Found: Boolean; Caption1: Text; TURFZuoraSubscriptionNo: Code[50]; Caption2: Text; No: Code[20]; SelltoCustomerNo: Code[20]; SystemCreatedAt: DateTime): Text
//     var
//         JsonObj: JsonObject;
//         CreatedDateText: Text[30];
//         JsonText: Text;
//     begin
//         // Format the date as XML (yyyy-MM-ddTHH:mm:ss)
//         CreatedDateText := Format(SystemCreatedAt, 0, 9);

//         JsonObj.Add('found', Found);
//         JsonObj.Add(Caption1, TURFZuoraSubscriptionNo);
//         JsonObj.Add(Caption2, No);
//         JsonObj.Add('customer', SelltoCustomerNo);
//         JsonObj.Add('createdDate', CreatedDateText);

//         JsonObj.WriteTo(JsonText);
//         exit(JsonText);
//     end;
// }
