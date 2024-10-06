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
        page "TURFEmployee Groups" = X;
}