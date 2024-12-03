page 70313 "TURFCust. Subscriptions API"
{
    PageType = API;
    Caption = 'TurfSubscriptions API';
    APIPublisher = 'turfTank';
    APIGroup = 'boomi';
    APIVersion = 'v1.0';
    EntityName = 'customerSubscription';
    EntitySetName = 'customerSubscriptions';
    SourceTable = "TURFCustomer Zuora Subscr";
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
                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field(subscriptionNumber; Rec."Subscription Number")
                {
                    Caption = 'Subscription Number';
                }
                field(cmrr; Rec.CMRR)
                {
                    Caption = 'CMRR';
                }
                field(contractEffectiveDate; Rec."Contract Effective Date")
                {
                    Caption = 'Contract Effective Date';
                }
                field(listOfProducts; Rec."List of Products")
                {
                    Caption = 'List of Products';
                }
                field(newRenewalDate; Rec."New Renewal Date")
                {
                    Caption = 'New Renewal Date';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
            }
        }
    }
}