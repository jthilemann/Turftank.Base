pageextension 70337 "TURF FP Prod. Orders" extends "Firm Planned Prod. Orders"
{
    layout
    {
        addlast(Control1)
        {
            field("TURF Production Start"; Rec."TURF Production Start")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TURF Production Start field.';
            }
            field("TURF Production End"; Rec."TURF Production End")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TURF Production End field.';
            }
            field("TURF Done"; Rec."TURF Done")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether this production order is done.';
            }
            field(TURFComment; Rec.TURFComment)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies a comment for the production order.';
            }
            field("TURF Printed"; Rec."TURF Printed")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether this production order has been printed.';
            }
            field("TURFWarehouse/Production"; Rec."TURFWarehouse/Production")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the warehouse/production value.';
            }
            field(TURFShipping; Rec.TURFShipping)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the shipping value.';
            }
            field("TURF Responsible"; Rec."TURF Responsible")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the person or group responsible for this production order.';
            }
            field("TURF Week"; Rec."TURF Week")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the production week for this production order.';
            }
        }
    }
}
