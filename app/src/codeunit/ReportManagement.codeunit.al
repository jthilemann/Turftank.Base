codeunit 70301 "TURFReport Management"
{
    EventSubscriberInstance = Manual;

    internal procedure PrintProformaInvoice(Rec: Record "Sales Header")
    var
        DocumentPrint: Codeunit "Document-Print";
        ReportManagement: Codeunit "TURFReport Management";
    begin
        BindSubscription(ReportManagement);
        DocumentPrint.PrintProformaSalesInvoice(Rec);
        UnbindSubscription(ReportManagement);
    end;

    [EventSubscriber(ObjectType::Report, Report::"Standard Sales - Pro Forma Inv", 'OnBeforeGetDocumentCaption', '', false, false)]
    local procedure StandardSalesProFormaInvOnBeforeGetDocumentCaption(var DocCaption: Text)
    var
        CustomsInvoiceLbl: Label 'Customs Invoice', Locked = true;
    begin
        DocCaption := CustomsInvoiceLbl;
    end;
}