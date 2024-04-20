page 70303 "TURFEmployee Groups"
{
    Caption = 'Employee Groups';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "TURFEmployee Group";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Order Type field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("G/L Account Filter"; Rec."G/L Account Filter")
                {
                    ToolTip = 'Specifies the value of the G/L Account Filter field.';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        GLAccount: Record "G/L Account";
                        ChartofAccounts: Page "Chart of Accounts";
                    begin
                        ChartofAccounts.LookupMode := true;
                        if ChartofAccounts.RunModal() = Action::LookupOK then begin
                            ChartofAccounts.GetRecord(GLAccount);
                            Rec."G/L Account Filter" := Text + GLAccount."No.";
                        end;
                    end;
                }
            }
        }
    }
}