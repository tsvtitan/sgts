unit SgtsDataExport;

interface

uses SgtsDbGrid, SgtsCDS, SgtsCoreIntf;

procedure ExportByGrid(ACoreIntf: ISgtsCore; AGrid: TSgtsDbGrid; ADataSet: TSgtsCDS; ASheetName: string=''; ACaption: string='');

implementation

uses Classes, Controls, DB, Grids, DbGrids, Forms, ActiveX, ComObj,
     SysUtils, Graphics, Variants,
     SgtsConsts, SgtsExcelConsts, SgtsDialogs;

threadvar
  Excel: OleVariant;

procedure ExportByGrid(ACoreIntf: ISgtsCore; AGrid: TSgtsDbGrid; ADataSet: TSgtsCDS; ASheetName: string=''; ACaption: string='');
var
  i: Integer;
  Counter1,Counter2: Integer;
  OutData: Variant;
  Wb,Sh: Variant;
  FColumn: TColumn;
  MaxCols: Integer;
  NewValue: OleVariant;
  List: TList;
  Captions: TStringList;
  StartY: Integer;
  OldCursor: TCursor;
  R: Variant;
begin
  if Assigned(ACoreIntf) and
     Assigned(AGrid) and
     Assigned(ADataSet) then begin
    try
      OldCursor:=Screen.Cursor;
      Screen.Cursor:=crHourGlass;
      List:=TList.Create;
      Captions:=TStringList.Create;
      CoInitialize(nil);
      try
        with ADataSet, AGrid do begin
          BeginUpdate(true);
          ACoreIntf.MainForm.Progress(0,RecordCount,0);
          try
            if Active and not IsEmpty and
              (Columns.Count>0) then begin
                Excel:=CreateOleObject(SExcelSheetOle);
                try
                  Wb:=Excel.WorkBooks.Add;
                  Sh:=Wb.Sheets.Add;
               //   Sh.Name:=ASheetName;   ?? Ругается на имя Журнал
                  Captions.Text:=Trim(ACaption);
                  for i:=0 to Captions.Count-1 do begin
                    Sh.Cells[i+1,1].Value:=Captions.Strings[i];
                    Sh.Cells[i+1,1].Font.Name:=Font.Name;
                    Sh.Cells[i+1,1].Font.Size:=Font.Size;
                  end;

                  Counter1:=0;
                  StartY:=Captions.Count+1;
                  for i:=0 to Columns.Count-1 do begin
                    FColumn:=Columns.Items[i];
                    if FColumn.Visible and
                       Assigned(FColumn.Field) then begin
                      Inc(Counter1);
                      List.Add(FColumn);
                      Sh.Cells[StartY,Counter1].Value:=FColumn.Title.Caption;
                      Sh.Cells[StartY,Counter1].Interior.Color:=ColorToRGB(FColumn.Title.Color);
                      Sh.Cells[StartY,Counter1].Font.Name:=FColumn.Title.Font.Name;
                      Sh.Cells[StartY,Counter1].Font.Color:=ColorToRGB(FColumn.Title.Font.Color);
                      Sh.Cells[StartY,Counter1].Font.Size:=FColumn.Title.Font.Size;
                      Sh.Cells[StartY,Counter1].Font.Bold:=fsBold in FColumn.Title.Font.Style;
                      Sh.Cells[StartY,Counter1].Font.Italic:=fsItalic in FColumn.Title.Font.Style;
                      Sh.Cells[StartY,Counter1].Columns.ColumnWidth:=FColumn.Width/Canvas.TextWidth('H')*1.1;
                    end;
                  end;

                  MaxCols:=Counter1;
                  OutData:=VarArrayCreate([1,RecordCount,1,MaxCols],varVariant);
                  Counter2:=1;
                  First;
                  while not Eof do begin
                    for i:=0 to List.Count-1 do begin
                      NewValue:=TColumn(List.Items[i]).Field.Value;
                      OutData[Counter2,i+1]:=NewValue;
                    end;
                    ACoreIntf.MainForm.Progress(0,RecordCount,Counter2);
                    Inc(Counter2);
                    Next;
                  end;
                  Sh.Range[Sh.Cells[StartY+1,1],Sh.Cells[StartY+RecordCount,MaxCols]].Value:=OutData;

                  for i:=0 to List.Count-1 do begin
                    FColumn:=TColumn(List.Items[i]);
                    R:=Sh.Range[Sh.Cells[StartY+1,i+1],Sh.Cells[StartY+RecordCount,i+1]];
                    R.Font.Name:=FColumn.Font.Name;
                    R.Font.Color:=ColorToRGB(FColumn.Font.Color);
                    R.Font.Size:=FColumn.Font.Size;
                    R.Font.Bold:=fsBold in FColumn.Font.Style;
                    R.Font.Italic:=fsItalic in FColumn.Font.Style;
//                    R.NumberFormat:='@';
                    case FColumn.Alignment of
                      taLeftJustify: R.HorizontalAlignment:=xlLeft;
                      taRightJustify: R.HorizontalAlignment:=xlRight;
                      taCenter: R.HorizontalAlignment:=xlCenter;
                    end;
                  end;

                  Sh.Activate;
                finally
                  if not VarIsEmpty(Excel) then begin
                    if not VarIsEmpty(Excel.ActiveWindow) then
                      Excel.ActiveWindow.WindowState:=xlMaximized;
                    Excel.Visible:=true;
                    Excel.WindowState:=xlMaximized;
                    Excel.WindowState:=xlMaximized;
                    Excel:=Unassigned;
                  end;
                end;
            end;
          finally
            ACoreIntf.MainForm.Progress(0,0,0);
            EndUpdate(false);
          end;
        end;
      finally
        Captions.Free;
        List.Free;
        CoUninitialize;
        Screen.Cursor:=OldCursor;
      end;
    except
      on E: Exception do
        ShowError(E.Message);
    end;
  end;
end;

end.
