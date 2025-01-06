report 70307 "TURFInventory to Excel"
{
    Caption = 'Inventory to Excel';
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(BinContent; "Bin Content")
        {
            CalcFields = "Quantity (Base)";
            RequestFilterFields = "Item No.", "Variant Code", "Location Code", "Bin Code";

            trigger OnPreDataItem()
            begin
                if BinContent.Count > 0 then begin
#pragma warning disable AA0139
                    EnterCell(1, TempExcelBuffer, RowNo, BinContent.FieldCaption("Item No."), true, false, false, '', TempExcelBuffer."Cell Type"::Text);

                    EnterCell(2, TempExcelBuffer, RowNo, BinContent.FieldCaption("Variant Code"), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(3, TempExcelBuffer, RowNo, 'Inventory', true, false, false, '', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(4, TempExcelBuffer, RowNo, BinContent.FieldCaption("Location Code"), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(5, TempExcelBuffer, RowNo, BinContent.FieldCaption("Bin Code"), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
#pragma warning restore AA0139
                    EnterCell(6, TempExcelBuffer, RowNo, 'Serial Number', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                end;
            end;

            trigger OnAfterGetRecord()
            var
                ItemReference: Record "Item Reference";
            begin
                ItemReference.SetRange("Item No.", BinContent."Item No.");
                ItemReference.SetRange("Variant Code", BinContent."Variant Code");
                ItemReference.SetRange("Reference Type", ItemReference."Reference Type"::"Bar Code");
                if not ItemReference.FindFirst() then
                    Clear(ItemReference);

                RowNo += 1;
                EnterCell(1, TempExcelBuffer, RowNo, BinContent."Item No.", false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(2, TempExcelBuffer, RowNo, BinContent."Variant Code", false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(3, TempExcelBuffer, RowNo, Format(BinContent."Quantity (Base)"), false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                EnterCell(4, TempExcelBuffer, RowNo, BinContent."Location Code", false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(5, TempExcelBuffer, RowNo, BinContent."Bin Code", true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(6, TempExcelBuffer, RowNo, ItemReference."Reference No.", false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            end;

            trigger OnPostDataItem()
            var
                OStream: OutStream;
            begin
                CreateAndAddToStream(TempExcelBuffer, 'BinContents', 'BinContents', OStream, 'BinContents.xlsx');
            end;
        }
    }





    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        RowNo: Integer;

    procedure EnterCell(ColumnNo: Integer; var aTempExcelBuffer: Record "Excel Buffer" temporary; aRowNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean; NumberFormat: Text[30]; CellType: Option)
    begin
        aTempExcelBuffer.Init();
        aTempExcelBuffer.Validate("Row No.", aRowNo);
        aTempExcelBuffer.Validate("Column No.", ColumnNo);
        aTempExcelBuffer."Cell Value as Text" := CellValue;
        aTempExcelBuffer.Formula := '';
        aTempExcelBuffer.Bold := Bold;
        aTempExcelBuffer.Italic := Italic;
        aTempExcelBuffer.Underline := UnderLine;
        aTempExcelBuffer.NumberFormat := NumberFormat;
        aTempExcelBuffer."Cell Type" := CellType;
        aTempExcelBuffer.Insert();
    end;

    procedure CreateAndAddToStream(var aTempExcelBuffer: Record "Excel Buffer" temporary; aSheetName: Text; aReportHeader: Text; var OStream: OutStream; DownloadToFileName: Text)
    var
        TempBlob: Codeunit "Temp Blob";
        IStream: InStream;
        DownloadLbl: Label 'Download';
    begin
        if aTempExcelBuffer.Count > 1 then begin
            TempBlob.CreateOutStream(OStream);
            aTempExcelBuffer.CreateNewBook(Copystr(aSheetName, 1, 250));
            aTempExcelBuffer.WriteSheet(aReportHeader, CompanyName, UserId);
            aTempExcelBuffer.CloseBook();
            aTempExcelBuffer.SaveToStream(Ostream, true);
            if DownloadToFileName <> '' then begin
                TempBlob.CreateInStream(IStream, TextEncoding::Windows);
                DownloadFromStream(IStream, DownloadLbl, '', '', DownloadToFileName)
            end;
        end;
    end;
}