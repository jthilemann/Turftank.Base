page 70309 "TURFReturn Reason API"
{
    PageType = API;
    Caption = 'Order API';
    APIPublisher = 'turfTank';
    APIGroup = 'boomi';
    APIVersion = 'v1.0';
    EntityName = 'returnReason';
    EntitySetName = 'returnReasons';
    SourceTable = "Return Reason";
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(defaultLocationCode; Rec."Default Location Code")
                {
                    Caption = 'Default Location Code';
                }
            }
        }
    }
}