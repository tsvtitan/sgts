unit SgtsMyFm;

interface

uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, Grids, DBGrids,
  SgtsFm, SgtsChildFm, SgtsCoreIntf, SgtsDatabaseCDS, SgtsProviders, ComCtrls,
  DBTables, ExtCtrls, ImgList, SgtsDataFm, ToolWin;

type
  TSgtsMyForm = class(TSgtsChildForm)
    PanelGraph: TPanel;
    PanelYear: TPanel;
    Panel1: TPanel;
    EditYear: TEdit;
    Label1: TLabel;
    ImageList: TImageList;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
  private
    FDataSet: TSgtsDatabaseCDS;
  public
    procedure ShowSubItems(ParentNode: TTreeNode);
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
  end;



var
  SgtsMyForm: TSgtsMyForm;

implementation

uses SgtsConsts, SgtsDatabaseIntf,
     SgtsDialogs, SgtsCDS, SgtsRbkTestFm, SgtsGetRecordsConfig;
{$R *.dfm}


{TSgtsMyform}

procedure TSgtsMyForm.ShowSubItems(ParentNode: TTreeNode);
var
  i, _indexDS: Integer;
begin
FDataSet.Orders.Add('PRIORITY', otAsc);
  FDataSet.First;
  for i := 0 to FDataSet.RecordCount - 1 do begin
      if FDataSet.FieldByName('PARENT_ID').AsInteger =
       Integer(ParentNode.Data) then begin
          {_curNode := TreeViewMeasureType.Items.AddChildObject(ParentNode,
              FDataSet.FieldByName('NAME').AsString,
              TObject(FDataSet.FieldByName('MEASURE_TYPE_ID').AsInteger));
              _indexDS := FDataSet.RecNo;
              ShowSubItems(_curNode);
              FDataSet.Orders.Add('PRIORITY', otAsc);
              FDataSet.First;
              FDataSet.MoveBy(_indexDS-1);
              }
      end;
        FDataSet.Next;
  end;
end;

constructor TSgtsMyForm.Create(ACoreIntf: ISgtsCore);
var
  _curNode: TTreeNode;
  i, _indexDS: Integer;
begin
  inherited Create(ACoreIntf);
  FDataSet:=TSgtsDataBaseCDS.Create(ACoreIntf);
  FDataSet.ProviderName:='MEASURE_TYPES';
  with FDataSet.SelectDefs do begin
    AddInvisible('MEASURE_TYPE_ID');
    AddInvisible('PARENT_ID');
    AddInvisible('NAME');
    AddInvisible('PRIORITY');
  end;

  FDataSet.CheckProvider:=false;
  FDataSet.Close;
  FDataSet.Open;
  FDataSet.Orders.Add('PRIORITY', otAsc);
  FDataSet.First;
  ShowInfo('Record count = '+IntToStr(FDataSet.RecordCount));
     {
  for i := 0 to FDataSet.RecordCount - 1 do begin
    if FDataSet.FieldByName('PARENT_ID').AsInteger = 0 then begin
      {_curNode := TreeViewMeasureType.Items.AddObject(nil,
          FDataSet.FieldByName('NAME').AsString,
          TObject(FDataSet.FieldByName('MEASURE_TYPE_ID').AsInteger));
            _indexDS := FDataSet.RecNo;
            ShowSubItems(_curNode);
            FDataSet.First;
            FDataSet.MoveBy(_indexDS-1)

    end;
    FDataSet.Next;
  end;
  }
end;

destructor TSgtsMyForm.Destroy;
begin
  inherited Destroy;
end;

end.
