Report 70301 "TURFItem Label"
{
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'TURF Item Label';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/TURFItemLabel.rdlc';

    dataset
    {
        dataitem("Sales Shipment Line"; "Sales Shipment Line")
        {
            DataItemTableView = where(Type = const(Item));
            //column(LabelContent; TxtBuilder.ToText()) { }

            trigger OnAfterGetRecord()
            var
                TenantMedia: Record "Tenant Media";
            // Image: Codeunit Image;
            // IStream: InStream;
            // InsertImageLbl: Label '~DG000.GRF,09856,044,%1', Locked = true;
            begin
                Clear(TxtBuilder);
                Clear(ImageBase64);
                Item.Get("Sales Shipment Line"."No.");
                if Item.Picture.Count > 0 then begin
                    TenantMedia.SetAutoCalcFields(Content);
                    if not TenantMedia.get(Item.Picture.Item(1)) then
                        Clear(TenantMedia)
                    //     else begin
                    //         TenantMedia.Content.CreateInStream(IStream);
                    //         Image.FromStream(IStream);
                    //         ImageBase64 := Image.ToBase64();
                    //     end;
                    // end;

                    // TxtBuilder.AppendLine('^XA~TA000~JSN^LT0^MNW^MTD^PON^PMN^LH0,0^JMA^PR5,5~SD15^JUS^LRN^CI0^XZ');
                    // if ImageBase64 <> '' then
                    //     TxtBuilder.AppendLine(StrSubstNo(InsertImageLbl, ImageBase64));
                    // TxtBuilder.AppendLine('^XA');
                    // TxtBuilder.AppendLine('^MMT');
                    // TxtBuilder.AppendLine('^PW344');
                    // TxtBuilder.AppendLine('^LL0440');
                    // TxtBuilder.AppendLine('^LS0');
                    // if ImageBase64 <> '' then
                    //     TxtBuilder.AppendLine('^FT0,384^XG000.GRF,1,1^FS');
                    // TxtBuilder.AppendLine('^FT20,68^A0N,28,28^FH\^FDNo.:^FS');
                    // TxtBuilder.AppendLine('^FT112,68^A0N,28,28^FH\^FDVarenr.inds\91ttes^FS');
                    // TxtBuilder.AppendLine('^FT20,119^A0N,28,28^FH\^FDBeskrivelse her^FS');
                    // TxtBuilder.AppendLine('^PQ1,0,1,Y^XZ');
                    // if ImageBase64 <> '' then
                    //     TxtBuilder.AppendLine('^XA^ID000.GRF^FS^XZ');
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
        TxtBuilder: TextBuilder;
        ImageBase64: Text;

}

