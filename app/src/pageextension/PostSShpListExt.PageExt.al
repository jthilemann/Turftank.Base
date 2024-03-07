pageextension 70305 "TURFPost. S. Shp. List Ext" extends "Posted Sales Shipments"
{
    layout
    {
        addlast(Control1)
        {

            field("TURFOrder Type"; Rec."TURFOrder Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Type field.';
            }
        }
    }
}