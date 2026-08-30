codeunit 70313 "TURFReport Substitution"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ReportManagement", 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnAfterSubstituteReport(ReportId: Integer; RunMode: Option; RequestPageXml: Text; RecordRef: RecordRef; var NewReportId: Integer)
    var
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        ReportSelections: Record "Report Selections";
        SubscrSettlementDocument: Record "TURFSubscr Settlement Document";
    begin
        // --- Sales Invoice substitution ---
        if RecordRef.Number = Database::"Sales Invoice Header" then begin
            // Only substitute if the report being printed is the one configured in Report Selection for Sales Invoice
            ReportSelections.SetRange(Usage, ReportSelections.Usage::"S.Invoice");
            ReportSelections.SetRange("Report ID", ReportId);
            if not ReportSelections.IsEmpty() then begin
                RecordRef.SetTable(SalesInvHeader);
                if SalesInvHeader."TURFSubscription No." <> '' then begin
                    // If the invoice is a settlement document, use the original report
                    SubscrSettlementDocument.SetRange("Invoice No.", SalesInvHeader."No.");
                    if not SubscrSettlementDocument.IsEmpty() then
                        exit;
                    NewReportId := Report::"TURFTank Contract S. Invoice";
                end;
            end;
            exit;
        end;

        // --- Sales Credit Memo substitution ---
        if RecordRef.Number = Database::"Sales Cr.Memo Header" then begin
            // Only substitute if the report being printed is the one configured in Report Selection for Sales Credit Memo
            ReportSelections.SetRange(Usage, ReportSelections.Usage::"S.Cr.Memo");
            ReportSelections.SetRange("Report ID", ReportId);
            if not ReportSelections.IsEmpty() then begin
                RecordRef.SetTable(SalesCrMemoHeader);
                if SalesCrMemoHeader."TURFSubscription No." <> '' then begin
                    // If the credit memo is a settlement document, use the standard report
                    SubscrSettlementDocument.SetRange("Credit Memo No.", SalesCrMemoHeader."No.");
                    if not SubscrSettlementDocument.IsEmpty() then
                        exit;
                    NewReportId := Report::"TURFTank Contract S. Cr. Memo";
                end;
            end;
        end;
    end;
}
