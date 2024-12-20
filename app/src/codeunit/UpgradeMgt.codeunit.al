codeunit 70307 "TURFUpgrade Mgt"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    var
        UpgradeTag: Codeunit "Upgrade Tag";
    begin
        if not UpgradeTag.HasUpgradeTag(GetUpgradeTagNewAppMoveCompanyInfoFields()) then begin
            MoveCompanyInfoFields();
            UpgradeTag.SetUpgradeTag(GetUpgradeTagNewAppMoveCompanyInfoFields());
        end;
    end;


    local procedure GetUpgradeTagNewAppMoveCompanyInfoFields(): Code[250]
    begin
        EXIT('MigrateCompanyDataToNewApp');
    end;

    local procedure MoveCompanyInfoFields()
    var
        CompanyInformation: Record "Company Information";
        RecRef: RecordRef;
        Modify: Boolean;
    begin
        RecRef.Open(CompanyInformation.RecordId.TableNo);
        if CompanyInformation.get() then begin
            RecRef.GetTable(CompanyInformation);
            if RecRef.FieldExist(50000) then begin
                CompanyInformation."TURFE-Mail (Purchase)" := RecRef.Field(50000).Value;
                Modify := true;
            end;

            if RecRef.FieldExist(50005) then begin
                CompanyInformation."TURFSort Code" := RecRef.Field(50005).Value;
                CompanyInformation.Modify(false);
                Modify := true;
            end;

            if Modify then
                CompanyInformation.Modify(false);
        end;

        RecRef.Close();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Upgrade Tag", 'OnGetPerCompanyUpgradeTags', '', false, false)]
    local procedure OnGetPerCompanyTags(var PerCompanyUpgradeTags: List of [Code[250]]);
    begin
        PerCompanyUpgradeTags.Add(GetUpgradeTagNewAppMoveCompanyInfoFields());
    end;

}