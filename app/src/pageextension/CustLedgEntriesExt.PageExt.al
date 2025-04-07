pageextension 70331 TURFCustLedgEntriesExt extends "Customer Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {

            field("TURFZuora Invoice No."; Rec."TURFZuora Invoice No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zuora Invoice No. field.', Comment = '%';
            }
        }
    }
}