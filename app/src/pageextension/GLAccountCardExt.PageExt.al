pageextension 70315 "TURFG/L Account Card Ext" extends "G/L Account Card"
{
    layout
    {
        addlast(General)
        {
            field("TURFEmployee Groups Filter"; Rec."TURFEmployee Groups Filter")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Employee Groups Filter field.';
                trigger OnLookup(var Text: Text): Boolean
                var
                    TURFEmployeeGroup: Record "TURFEmployee Group";
                    TURFEmployeeGroups: Page "TURFEmployee Groups";
                begin
                    TURFEmployeeGroups.LookupMode := true;
                    if TURFEmployeeGroups.RunModal() = Action::LookupOK then begin
                        TURFEmployeeGroups.GetRecord(TURFEmployeeGroup);
                        Rec."TURFEmployee Groups Filter" := Text + TURFEmployeeGroup."Code";
                    end;
                end;
            }
            field(TURFDescription; Rec.TURFDescription)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Description field.';
            }
        }
    }
}