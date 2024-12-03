page 70312 "TURFBoomi Sucr. List Part"
{
    Caption = 'Zuora Subscriptions';
    PageType = ListPart;
    SourceTable = "TURFCustomer Zuora Subscr";
    ApplicationArea = all;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Subscription Number"; Rec."Subscription Number")
                {
                    ToolTip = 'Specifies the value of the Subscription Number field.', Comment = '%';
                }
                field(CMRR; Rec.CMRR)
                {
                    ToolTip = 'Specifies the value of the CMRR field.', Comment = '%';
                }
                field("List of Products"; Rec."List of Products")
                {
                    ToolTip = 'Specifies the value of the List of Products field.', Comment = '%';
                }
                field("Contract Effective Date"; Rec."Contract Effective Date")
                {
                    ToolTip = 'Specifies the value of the Contract Effective Date field.', Comment = '%';
                }
                field("New Renewal Date"; Rec."New Renewal Date")
                {
                    ToolTip = 'Specifies the value of the New Renewal Date field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
        }
    }
}