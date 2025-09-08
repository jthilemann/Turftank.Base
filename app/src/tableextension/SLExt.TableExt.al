tableextension 70313 "TURF SL Ext" extends "Sales Line"
{
    fields
    {
        field(70301; "TURFBoomi Order"; Boolean)
        {
            Caption = 'Boomi Order';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."TURFBoomi Order" where("Document Type" = field("Document Type"), "No." = field("Document No.")));
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                TurfTankSetup: Record "TURFTurfTank Setup";
                SalesLine: Record "Sales Line";
            begin
                if Rec."Attached to Line No." <> 0 then
                    exit;

                TurfTankSetup.GetRecordOnce();
                SalesLine.SetRange("Document Type", Rec."Document Type");
                SalesLine.SetRange("Document No.", Rec."Document No.");
                SalesLine.SetRange("Attached to Line No.", Rec."Line No.");
                SalesLine.SetRange(Type, SalesLine.Type::Item);
                SalesLine.SetRange("No.", TurfTankSetup."TURFMarkup Item No.");
                if SalesLine.FindFirst() then begin
                    SalesLine.Validate(Quantity, Rec.Quantity);
                    SalesLine.Modify(false);
                end;
            end;
        }
    }

    internal procedure InsertMarkup()
    var
        TurfTankSetup: Record "TURFTurfTank Setup";
        SalesLine: Record "Sales Line";
    begin
        //600199 ∙ Robot Markup
        TurfTankSetup.GetRecordOnce();
        TurfTankSetup.testfield("TURFMarkup Item No.");
        TurfTankSetup.TestField("TURFMarkup Robot Unit Price");

        Rec.TestField(Type, Type::Item);
        if not (Rec."No." in ['600100', '600107', '600101']) then
            Rec.TestField("No.");

        SalesLine.Init();
        SalesLine.Validate("Document Type", Rec."Document Type");
        SalesLine.Validate("Document No.", Rec."Document No.");
        SalesLine.Validate("Line No.", Rec."Line No." + 1);
        SalesLine.Validate(Type, SalesLine.Type::Item);
        SalesLine.Validate("No.", TurfTankSetup."TURFMarkup Item No.");
        SalesLine.Validate("Attached to Line No.", Rec."Line No.");
        SalesLine.Validate("Unit Price", TurfTankSetup."TURFMarkup Robot Unit Price" - Rec."Unit Price");
        SalesLine.Validate(Quantity, Rec.Quantity);
        SalesLine.Insert(true);
    end;
}