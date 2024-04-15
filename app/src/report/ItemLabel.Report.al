Report 70301 "TURFItem Label"
{
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Item';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/TURFItemLabel.rdlc';


    dataset
    {
        dataitem("Sales Shipment Line"; "Sales Shipment Line")
        {
            DataItemTableView = where(Type = const(Item));
            column(ItemCpt; 'SKU') { }
            column(ItemNo; Item."No.") { }
            column(Description; Description) { }

            trigger OnAfterGetRecord()
            var
                TenantMedia: Record "Tenant Media";
                Image: Codeunit Image;
                IStream: InStream;
            begin
                Item.Get("Sales Shipment Line"."No.");
                if Item.Picture.Count > 0 then begin
                    TenantMedia.SetAutoCalcFields(Content);
                    if not TenantMedia.get(Item.Picture.Item(1)) then
                        Clear(TenantMedia);

                    TenantMedia.Content.CreateInStream(IStream);
                    Image.FromStream(IStream);
                    Image.ToBase64()
                end
            end;

        }

    }

    requestpage
    {

        layout
        {
        }
    }

    labels
    {
    }

    var
        Item: Record Item;
}

