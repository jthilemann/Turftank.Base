codeunit 70313 "TURFReport Substitution"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ReportManagement", 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnAfterSubstituteReport(ReportId: Integer; RunMode: Option; RequestPageXml: Text; RecordRef: RecordRef; var NewReportId: Integer)
    var
        SalesInvHeader: Record "Sales Invoice Header";
        ReportSelections: Record "Report Selections";
    begin
        if RecordRef.Number <> Database::"Sales Invoice Header" then
            exit;

        // Only substitute if the report being printed is the one configured in Report Selection for Sales Invoice
        ReportSelections.SetRange(Usage, ReportSelections.Usage::"S.Invoice");
        ReportSelections.SetRange("Report ID", ReportId);
        if ReportSelections.IsEmpty() then
            exit;

        RecordRef.SetTable(SalesInvHeader);
        if SalesInvHeader."TURFSubscription No." <> '' then
            NewReportId := Report::"TURFTank Contract S. Invoice";
    end;
}
