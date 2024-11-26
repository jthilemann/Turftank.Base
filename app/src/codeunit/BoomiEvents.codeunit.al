codeunit 70305 "TURFBoomi Events"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to Customer No.', false, false)]
    local procedure SalesHeaderOnAfterValidateEvent(var Rec: Record "Sales Header")
    var
        Customer: Record Customer;
    begin
        if Customer.get(Rec."Sell-to Customer No.") then
            if (Customer."TURFZuora ID" <> '') and (Customer."TURFZuora ID" <> Rec."TURFZuora ID") then
                Rec."TURFZuora ID" := Customer."TURFZuora ID";
    end;
}