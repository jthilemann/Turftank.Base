Report 70302 "TURFItem Receipt Label"
{
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'TURF Item Label';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/TURFItemRcptLabel.rdlc';

    dataset
    {
        dataitem(PurchRcptLine; "Purch. Rcpt. Line")
        {
            DataItemTableView = where(Type = const(Item));
            column(Document_No_; "Document No.") { }
            column(LineNo; "Line No.") { }
            column(Image; TenantMedia.Content) { }
            column(ItemNo; Item."No.") { }
            column(itemCpt; Item.fieldcaption("No.")) { }
            column(Description; Description) { }

            trigger OnAfterGetRecord()
            begin
                Item.Get(PurchRcptLine."No.");
                if Item.Picture.Count > 0 then begin
                    TenantMedia.SetAutoCalcFields(Content);
                    if not TenantMedia.get(Item.Picture.Item(1)) then
                        Clear(TenantMedia)
                end;
            end;

        }
    }
    var
        Item: Record Item;
        TenantMedia: Record "Tenant Media";

}

