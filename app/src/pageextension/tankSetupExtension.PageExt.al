pageextension 70328 "TURF tank Setup Extension" extends "TURFTurfTank Setup"
{
    layout
    {
        addlast(General)
        {
            field("TURFMain Location"; Rec."TURFMain Location")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Main Location field.', Comment = '%';
            }
        }
    }
}