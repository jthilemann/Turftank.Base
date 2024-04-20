pageextension 70316 "TURFUser Setup Extension" extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field("TURFEmployee Group"; Rec."TURFEmployee Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Employee Group field.';
            }
        }
    }
}