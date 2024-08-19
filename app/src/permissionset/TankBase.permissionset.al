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
        page "TURFOperation Locations" = X,
        tabledata "TURFEmployee Group" = RIMD,
        table "TURFEmployee Group" = X;
}