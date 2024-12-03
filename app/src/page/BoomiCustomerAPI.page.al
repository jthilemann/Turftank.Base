page 70310 "TURFBoomi Customer API"
{
    APIPublisher = 'turfTank';
    APIGroup = 'boomi';
    APIVersion = 'v1.0';
    Caption = 'turfHubSpotCompanies';
    DelayedInsert = true;
    EntityName = 'customer';
    EntitySetName = 'customers';
    PageType = API;
    SourceTable = "TURFHubspot Company";
    InsertAllowed = true;
    ModifyAllowed = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId) { }
                field(no; Rec."No.") { }
                field(cloudId; Rec."Cloud Id") { }
                field(name; Rec.Name) { }
                field(name2; Rec."Name 2") { }
                field(address; Rec.Address) { }
                field(address2; Rec."Address 2") { }
                field(postCode; Rec."Post Code") { }
                field(city; Rec.City) { }
                field(county; Rec.County) { }
                field(countryRegionCode; Rec."Country/Region Code") { }
                field(phoneNo; Rec."Phone No.") { }
                field(eMail; Rec."E-Mail") { }
                field(billingEmail; Rec."Billing Email") { }
                field(homePage; Rec."Home Page") { }
                field(gln; Rec.GLN) { }
                field(vatRegistrationNo; Rec."VAT Registration No.") { }
                field(hubspotId; Rec."Hubspot Id") { }
                field(hubspotOwnerId; Rec."Hubspot Owner Id") { }
                field(hubspotOwnerName; Rec."Hubspot Owner Name") { }
                field(hubspotCompanyType; Rec."Hubspot Company Type") { }
                field(hubspotParentCompanyId; Rec."Hubspot Parent Company Id") { }
                field(hubspotAddress; Rec."TURFHubspot Address") { }
                field(zuoraAccountNumber; Rec."TURFZuora Account Number") { }
            }
        }
    }
}