page 70315 "TURFBoomi Setup"
{

    PageType = Card;
    SourceTable = "TURFBoomi Setup";
    Caption = 'Boomi Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("TURFBoomi Default Order Type"; Rec."TURFBoomi Default Order Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Boomi Default Order Type field.', Comment = '%';
                }
                field("TURFDef. Boomi Order Location"; Rec."TURFDef. Boomi Order Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Default Boomi Order Location Code field.', Comment = '%';
                }
            }
            group("Customer Payments")
            {

                field("Payment Journal Template Name"; Rec."Payment Journal Template Name")
                {
                    ToolTip = 'Specifies the value of the Payment Journal Template Name field.', Comment = '%';
                }
                field("Payment Journal Batch Name"; Rec."Payment Journal Batch Name")
                {
                    ToolTip = 'Specifies the value of the Payment Journal Batch Name field.', Comment = '%';
                }
            }
            group(Tax)
            {

                field("Default Tax Item"; Rec."Default Tax Item")
                {
                    ToolTip = 'Specifies the value of the Default Tax Item field.', Comment = '%';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExists();
    end;

}