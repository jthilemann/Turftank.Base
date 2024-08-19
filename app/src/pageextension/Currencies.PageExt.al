pageextension 70314 "TURFCurrencies" extends Currencies
{
    layout
    {
        addlast(Control1)
        {
            field("TURFReport Bank Account"; Rec."TURFReport Bank Account")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the bank for reports in this currency';
            }
        }

    }
}