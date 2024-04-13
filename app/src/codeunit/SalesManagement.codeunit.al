codeunit 70302 "TURFSales Management"
{
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeSetDefaultSalesperson', '', false, false)]
    local procedure CustomerOnBeforeSetDefaultSalesperson(var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;
}