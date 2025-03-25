page 70317 "TURFTank Stripe Setup"
{

    PageType = Card;
    SourceTable = "TURFTank Stripe Setup";
    Caption = 'TURFTank Stripe Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(PostingSetup)
            {
                Caption = 'Posting Setup';

                field("Stripe Fee G/L Account No."; Rec."Stripe Fee G/L Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stripe Fee G/L Account No. field.', Comment = '%';
                }
                field("Stripe Payments Bank No."; Rec."Stripe Payments Bank No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stripe Payments Bank field.', Comment = '%';
                }
                field("Stripe Interim Account"; Rec."Stripe Interim Account")
                {
                    ToolTip = 'Specifies the value of the Stripe Interim Account field.', Comment = '%';
                }
            }
            group(StripeAPISetup)
            {
                Caption = 'Stripe API Setup';
                field("Stripe Base URL"; Rec."Stripe Base URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stripe Base URL field.', Comment = '%';
                }
                field("Bearer Token"; Rec."Stripe Bearer Token")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bearer Token field.', Comment = '%';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExists();
    end;

}
