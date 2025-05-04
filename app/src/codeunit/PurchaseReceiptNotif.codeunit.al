codeunit 70316 "TURFPurchase Receipt Notif."
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchaseDoc', '', false, false)]
    local procedure OnAfterPostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20]; CommitIsSupressed: Boolean)
    var
        Vendor: Record Vendor;
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchaseReceipt: Report "Purchase - Receipt";
        EmailMessage: Codeunit "Email Message";
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        Email: Codeunit Email;
        BodyLbl: Label 'A new purchase receipt %1 has been posted.', Comment = '%1=PurchRcpHdrNo', Locked = true;
        SubjectLbl: Label 'Purchase Receipt %1', Comment = '%1=PurchRcpHdrNo', Locked = true;
        OStream: OutStream;
        IStream: InStream;
        Subject: Text;
        Body: Text;
    begin
        if PurchRcpHdrNo = '' then
            exit;

        if not PurchRcptHeader.Get(PurchRcpHdrNo) then
            exit;

        if not Vendor.Get(PurchRcptHeader."Buy-from Vendor No.") then
            exit;

        if Vendor."TURFPurchase Receipt Email" = '' then
            exit;

        Subject := StrSubstNo(SubjectLbl, PurchRcpHdrNo);
        Body := StrSubstNo(BodyLbl, PurchRcpHdrNo);

        EmailMessage.Create(Vendor."TURFPurchase Receipt Email", Subject, Body);

        TempBlob.CreateOutStream(OStream);

        PurchRcptHeader.SetRecFilter();
        PurchaseReceipt.SetTableView(PurchRcptHeader);
        PurchaseReceipt.SaveAs('', ReportFormat::Pdf, OStream);
        TempBlob.CreateInStream(IStream);
        EmailMessage.AddAttachment('Purchase Receipt.pdf', 'application/pdf', Base64Convert.ToBase64(IStream));
        Email.Send(EmailMessage);
    end;
}