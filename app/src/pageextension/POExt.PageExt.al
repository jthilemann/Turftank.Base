// pageextension 70309 "TURFPO Ext" extends "Purchase Order"
// {
//     layout
//     {

//     }
//     trigger OnNewRecord(BelowxRec: Boolean)
//     var
//         PurchaseHeader: Record "Purchase Header";
//         TURFPurchaseMgt: Codeunit "TURFPurchase Mgt";
//     begin
//         if TURFPurchaseMgt.AutoInsertPoEnabled() then begin
//             PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::Order);
//             PurchaseHeader.Insert(true);
//             Rec := PurchaseHeader;
//             CurrPage.Update(false);
//         end;
//     end;
// }