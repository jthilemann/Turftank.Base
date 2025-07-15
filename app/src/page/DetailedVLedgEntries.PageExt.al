pageextension 70335 "TURFDetailed V. Ledg. Entries" extends "Detailed Vendor Ledg. Entries"
{
    layout
    {
        addafter("Document No.")
        {
            field("TURFExternal Document No."; Rec."TURFExternal Document No.")
            {
                ApplicationArea = All;
                Caption = 'External Document No.';
                Editable = false;
                ToolTip = 'Specifies the value of the External Document No. field.';
            }
        }
    }
}