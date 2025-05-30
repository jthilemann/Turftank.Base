permissionset 70301 TURFTankBase
{
    Assignable = true;
    Permissions = tabledata "TURFOrder Type" = RIMD,
        table "TURFOrder Type" = X,
        codeunit "TURFReport Management Man" = X,
        codeunit "TURFSales Management" = X,
        page "TURFOrder Types" = X,
        tabledata "TURFOperation Location" = RIMD,
        table "TURFOperation Location" = X,
        report "TURFProd. Order - Job Card" = X,
        page "TURFRobot Models" = X,
        page "TURFOperation Locations" = X,
        tabledata "TURFRobot Model" = RIMD,
        table "TURFRobot Model" = X,
        tabledata "TURFEmployee Group" = RIMD,
        table "TURFEmployee Group" = X,
        tabledata "TURFItem Robot" = RIMD,
        table "TURFItem Robot" = X,
        report "TURFPurchase Order" = X,
        report TURFReminder = X,
        report "TURFReturn Order" = X,
        report "TURFSales Shipment" = X,
        report "TURFTank Base Sales Invoice" = X,
        codeunit "TURFFormat Report" = X,
        codeunit "TURFPurchase Management" = X,
        page "TURFEmployee Groups" = X,
        tabledata "TURFCustomer Zuora Subscr" = RIMD,
        table "TURFCustomer Zuora Subscr" = X,
        codeunit "TURFBoomi Events" = X,
        page "TURFBoomi Customer API" = X,
        page "TURFDepartment API" = X,
        page "TURFItem Robots" = X,
        page "TURFOrder API" = X,
        page "TURFOrder Lines API" = X,
        page "TURFOrder Type API" = X,
        page "TURFReturn Reason API" = X,
        tabledata "TURFBoomi Setup" = RIMD,
        table "TURFBoomi Setup" = X,
        page "TURFBoomi - Customer Payments" = X,
        page "TURFBoomi Setup" = X,
        page "TURFBoomi Sucr. List Part" = X,
        page "TURFCust. Subscriptions API" = X,
        tabledata "TURFTank Stripe Setup" = RIMD,
        table "TURFTank Stripe Setup" = X,
        report "TURFInventory to Excel" = X,
        report "TURFPick Instruction" = X,
        report "TURFPicking List" = X,
        report "TURFStandard Sales - Quote" = X,
        codeunit TURFBC2Boomi = X,
        codeunit "TURFBoomi Mgt" = X,
        codeunit "TURFStripe Management" = X,
        codeunit "TURFUpgrade Mgt" = X,
        page "TURFBoomi Post.S.Inv API" = X,
        page "TURFTank Stripe Setup" = X;
}