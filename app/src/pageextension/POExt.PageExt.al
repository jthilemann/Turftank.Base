pageextension 70318 "TURFPO Ext" extends "Purchase Order"
{
    layout
    {
        addafter("Ship-to Contact")
        {
            field("TURF Ship-To E-Mail"; Rec."TURF Ship-To E-Mail")
            {
                ApplicationArea = All;
                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                ToolTip = 'Specifies the value of the Ship-to Email field.', Comment = '%';
            }
            field("TURF Phone No."; Rec."TURF Ship-to Phone No.")
            {
                ApplicationArea = All;
                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                ToolTip = 'Specifies the value of the Ship-To Phone No. field.', Comment = '%';
            }
        }
    }
}