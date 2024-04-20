pageextension 70317 "TURFChart of Accounts Ext" extends "Chart of Accounts"
{
    layout
    {

    }

    actions
    {
        addlast("F&unctions")
        {
            action(TURFSetMyFilter)
            {
                ApplicationArea = all;
                Caption = 'Set/Remove My Account Filter';
                Image = Filter;
                ToolTip = 'Executes the Set/Remove My Account Filter action.';
                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                    TURFEmployeeGroup: Record "TURFEmployee Group";
                begin
                    if Rec.GetFilter("No.") <> '' then
                        Rec.SetRange("No.")
                    else begin
                        UserSetup.Get(UserId);
                        UserSetup.TestField("TURFEmployee Group");
                        TURFEmployeeGroup.Get(UserSetup."TURFEmployee Group");
                        Rec.SetFilter("No.", TURFEmployeeGroup."G/L Account Filter");
                    end;
                end;
            }
            action(TURFSetEmpGrpFilter)
            {
                ApplicationArea = all;
                Caption = 'Set/Remove Emp. Grp. Filter';
                Image = Filter;
                ToolTip = 'Executes the Set/Remove Emp. Grp. Filter action.';
                trigger OnAction()
                var
                    TURFEmployeeGroup: Record "TURFEmployee Group";
                    TURFEmployeeGroups: Page "TURFEmployee Groups";
                begin
                    if Rec.GetFilter("No.") <> '' then
                        Rec.SetRange("No.")
                    else begin
                        TURFEmployeeGroups.LookupMode := true;
                        if TURFEmployeeGroups.RunModal() = Action::LookupOK then begin
                            TURFEmployeeGroups.GetRecord(TURFEmployeeGroup);
                            Rec.SetFilter("No.", TURFEmployeeGroup."G/L Account Filter");
                        end;
                    end;
                end;
            }
        }
        addlast(Category_Process)
        {
            actionref(TURFSetMyFitler_Promoted; TURFSetMyFilter)
            {
            }
            actionref(TURFSetEmpGrpFilter_Promoted; TURFSetEmpGrpFilter)
            {
            }
        }
    }
}