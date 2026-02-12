codeunit 70307 "TURFUpgrade Mgt"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        UpgradeTag: Codeunit "Upgrade Tag";
    begin
        if not UpgradeTag.HasUpgradeTag(GetUpgradeTagUpdateItemLastCountingPeriod()) then begin
            UpdateItemLastCountingPeriod();
            UpgradeTag.SetUpgradeTag(GetUpgradeTagUpdateItemLastCountingPeriod());
        end;
    end;


    local procedure GetUpgradeTagNewAppMoveCompanyInfoFields(): Code[250]
    begin
        EXIT('MigrateCompanyDataToNewApp');
    end;

    local procedure GetUpgradeTagUpdateItemLastCountingPeriod(): Code[250]
    begin
        EXIT('UpdateItemLastCountingPeriodUpdate');
    end;


    local procedure UpdateItemLastCountingPeriod()
    var
        Item: Record Item;
    begin
        Item.setautoCalcFields("Last Phys. Invt. Date");
        if Item.FindSet(true) then
            repeat
                if Item."Last Phys. Invt. Date" > Item."Last Counting Period Update" then begin
                    Item.Validate("Last Counting Period Update", Item."Last Phys. Invt. Date");
                    Item.Modify(false);
                end;
            until Item.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Upgrade Tag", 'OnGetPerCompanyUpgradeTags', '', false, false)]
    local procedure OnGetPerCompanyTags(var PerCompanyUpgradeTags: List of [Code[250]]);
    begin
        PerCompanyUpgradeTags.Add(GetUpgradeTagNewAppMoveCompanyInfoFields());
        PerCompanyUpgradeTags.Add(GetUpgradeTagUpdateItemLastCountingPeriod());
    end;

}