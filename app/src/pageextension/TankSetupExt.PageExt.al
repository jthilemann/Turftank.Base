pageextension 70320 "TURFTank Setup Ext" extends "TURFTurfTank Setup"
{
    layout
    {
        addafter(General)
        {
            group(TURFTurfBoomi)
            {
                Caption = 'Boomi';
                field("TURFBoomi Default Order Type"; Rec."TURFBoomi Default Order Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Boomi Default Order Type field.', Comment = '%';
                }
            }
        }
    }
}