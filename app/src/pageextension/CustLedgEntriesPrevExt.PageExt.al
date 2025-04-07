pageextension 70332 TURFCustLedgEntriesPrevExt extends "Cust. Ledg. Entries Preview"
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