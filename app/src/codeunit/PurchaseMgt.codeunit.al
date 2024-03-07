// codeunit 70301 "TURFPurchase Mgt"
// {
//     [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeConfirmKeepExistingDimensions', '', false, false)]
//     local procedure PurchaseHeaderOnBeforeConfirmKeepExistingDimensions(xPurchaseHeader: Record "Purchase Header"; var PurchaseHeader: Record "Purchase Header"; var Confirmed: Boolean; var IsHandled: Boolean)
//     begin
//         if AutoInsertPoEnabled() then
//             if (xPurchaseHeader."Buy-from Vendor No." = '') and (PurchaseHeader."Buy-from Vendor No." <> '') then begin
//                 IsHandled := true;
//                 Confirmed := true;
//             end;
//     end;

//     internal procedure AutoInsertPoEnabled(): Boolean
//     var
//         UserSetup: Record "User Setup";
//     begin
//         if not UserSetup.Get(UserId) then
//             exit;

//         exit(UserSetup."TURFAuto Insert PO on New");
//     end;
// }