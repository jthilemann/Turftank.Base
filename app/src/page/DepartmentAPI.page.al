page 70311 "TURFDepartment API"
{
    PageType = API;
    Caption = 'TURFDepartment API';
    APIPublisher = 'turfTank';
    APIGroup = 'boomi';
    APIVersion = 'v1.0';
    EntityName = 'department';
    EntitySetName = 'departments';
    SourceTable = "Dimension Value";
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
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                }

            }
        }
    }
    trigger OnOpenPage()
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        GeneralLedgerSetup.GetRecordOnce();
        Rec.SetFilter("Dimension Code", GeneralLedgerSetup."Global Dimension 1 Code");
    end;
}