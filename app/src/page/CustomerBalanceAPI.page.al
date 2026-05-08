
page 70320 "TURFCustomer Balance API"
{
    APIPublisher = 'turfTank';
    APIGroup = 'hubspot';
    APIVersion = 'v1.0';
    Caption = 'customerBalances';
    DelayedInsert = true;
    EntityName = 'customerBalance';
    EntitySetName = 'customerBalances';
    PageType = API;
    SourceTable = Customer;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId) { }
                field(customerNo; Rec."No.") { }
                field(cloudId; Rec."TURFCloud Id") { }
                field(hubspotId; Rec."TURFHubspot Id") { }
                field(customerName; Rec.Name) { }
                field(currency; CurrencyTxt) { }
                field(totalBalance; Rec."Balance (LCY)") { }
                field(notDue; NotDueAmt) { }
                field(overdue1to30; Overdue1to30Amt) { }
                field(overdue30to60; Overdue30to60Amt) { }
                field(overdue60to90; Overdue60to90Amt) { }
                field(overdue90plus; Overdue90PlusAmt) { }
                field(totalDue; TotalDueAmt) { }
            }
        }
    }

    trigger OnOpenPage()
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        Rec.SetAutoCalcFields("Balance (LCY)");
        GeneralLedgerSetup.GetRecordOnce();
        CurrencyTxt := GeneralLedgerSetup."LCY Code";
    end;

    trigger OnAfterGetRecord()
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        // Single-pass aging calculation
        CustLedgEntry.Reset();
        CustLedgEntry.SetCurrentKey("Customer No.", Open, "Due Date");
        CustLedgEntry.SetLoadFields("Customer No.", Open, "Due Date", "Remaining Amount");
        CustLedgEntry.SetRange("Customer No.", Rec."No.");
        CustLedgEntry.SetRange(Open, true);
        CustLedgEntry.SetAutoCalcFields("Remaining Amount");
        NotDueAmt := 0;
        Overdue1to30Amt := 0;
        Overdue30to60Amt := 0;
        Overdue60to90Amt := 0;
        Overdue90PlusAmt := 0;
        if CustLedgEntry.FindSet() then
            repeat
                if CustLedgEntry."Due Date" >= Today() then
                    NotDueAmt += CustLedgEntry."Remaining Amount"
                else
                    if CustLedgEntry."Due Date" >= Today() - 30 then
                        Overdue1to30Amt += CustLedgEntry."Remaining Amount"
                    else
                        if CustLedgEntry."Due Date" >= Today() - 60 then
                            Overdue30to60Amt += CustLedgEntry."Remaining Amount"
                        else
                            if CustLedgEntry."Due Date" >= Today() - 90 then
                                Overdue60to90Amt += CustLedgEntry."Remaining Amount"
                            else
                                Overdue90PlusAmt += CustLedgEntry."Remaining Amount";
            until CustLedgEntry.Next() = 0;
        TotalDueAmt := Overdue1to30Amt + Overdue30to60Amt + Overdue60to90Amt + Overdue90PlusAmt;
    end;

    var
        CurrencyTxt: Text;
        NotDueAmt: Decimal;
        Overdue1to30Amt: Decimal;
        Overdue30to60Amt: Decimal;
        Overdue60to90Amt: Decimal;
        Overdue90PlusAmt: Decimal;
        TotalDueAmt: Decimal;
}
