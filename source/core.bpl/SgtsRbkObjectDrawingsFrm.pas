unit SgtsRbkObjectDrawingsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SgtsDataGridOleFrm, Menus, DB, ImgList, StdCtrls, Grids,
  DBGrids, ExtCtrls, ComCtrls, ToolWin, OleCtnrs,
  SgtsRbkObjectDrawingEditFm, SgtsDataInsertBySelect, SgtsExecuteDefs,
  SgtsRbkDrawingEditFm;

type
  TSgtsRbkObjectDrawingsFrame = class(TSgtsDataGridOleFrame)
  private
    { Private declarations }
  protected
    function GetCatalog: String; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TSgtsRbkObjectDrawingInsertIface=class(TSgtsDataInsertBySelectIface)
  private
    FPriorityDef: TSgtsExecuteDefCalc;
    FDrawingNameDef: TSgtsExecuteDefInvisible;
    FDrawingDescDef: TSgtsExecuteDefInvisible;
    function GetPriority(Def: TSgtsExecuteDefCalc): Variant;
  public
    procedure Init; override;
    procedure SetDefValues; override;
  end;

  TSgtsRbkPointDrawingUpdateIface=class(TSgtsRbkDrawingUpdateIface)
  private
    FDrawingNameDef: TSgtsExecuteDefEdit;
    FDrawingDescDef: TSgtsExecuteDefMemo;
  public
    procedure Init; override;
  end;

var
  SgtsRbkObjectDrawingsFrame: TSgtsRbkObjectDrawingsFrame;

implementation

{$R *.dfm}

uses SgtsDialogs, SgtsConsts, SgtsUtils, SgtsProviderConsts,
     SgtsGetRecordsConfig, SgtsDataGridFrm,
     SgtsCoreIntf, SgtsRbkDrawingsFm, SgtsCDS;

{ TSgtsRbkObjectDrawingInsertIface }

procedure TSgtsRbkObjectDrawingInsertIface.Init;
begin
  inherited Init;
  SelectClass:=TSgtsRbkDrawingsIface;
  with DataSet do begin
    ProviderName:=SProviderInsertObjectDrawing;
    with ExecuteDefs do begin
      AddInvisible('OBJECT_ID');
      AddInvisible('DRAWING_ID');
      FPriorityDef:=AddCalc('PRIORITY',GetPriority);
      FDrawingNameDef:=AddInvisible('DRAWING_NAME',ptUnknown);
      FDrawingNameDef.Twins.Add('NAME');
      FDrawingDescDef:=AddInvisible('DRAWING_DESCRIPTION',ptUnknown);
      FDrawingDescDef.Twins.Add('DESCRIPTION');
      AddInvisible('FILE_NAME',ptUnknown);
      AddInvisible('OBJECT_NAME',ptUnknown);
    end;
  end;
end;

function TSgtsRbkObjectDrawingInsertIface.GetPriority(Def: TSgtsExecuteDefCalc): Variant;
var
  DS: TSgtsCDS;
begin
  Result:=Def.DefaultValue;
  if Assigned(IfaceIntf) then begin
    DS:=TSgtsCDS.Create(nil);
    try
      DS.AddIndexDef(Def.FieldName,tsAsc);
      DS.Data:=IfaceIntf.DataSet.Data;
      if DS.Active then begin
        DS.SetIndexBySort(Def.FieldName,tsAsc);
        DS.Last;
        Result:=DS.FieldByName(Def.FieldName).AsInteger+1;
      end;
    finally
      DS.Free;
    end;
  end;
end;

procedure TSgtsRbkObjectDrawingInsertIface.SetDefValues; 
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    FPriorityDef.DefaultValue:=GetPriority(FPriorityDef);
    FPriorityDef.SetDefault;
  end;
end;

{ TSgtsRbkPointDrawingUpdateIface }

procedure TSgtsRbkPointDrawingUpdateIface.Init;
begin
  inherited Init;
  with DataSet do begin
    with ExecuteDefs do begin
      FDrawingNameDef:=TSgtsExecuteDefEdit(Find('NAME'));
      FDrawingNameDef.Twins.Add('DRAWING_NAME');
      FDrawingDescDef:=TSgtsExecuteDefMemo(Find('DESCRIPTION'));
      FDrawingDescDef.Twins.Add('DRAWING_DESCRIPTION');
    end;
  end;
end;

{ TSgtsRbkObjectDrawingsFrame }

constructor TSgtsRbkObjectDrawingsFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  InsertClass:=TSgtsRbkObjectDrawingInsertIface;
  UpdateClass:=TSgtsRbkPointDrawingUpdateIface;
  DeleteClass:=TSgtsRbkObjectDrawingDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectObjectDrawings;
    with SelectDefs do begin
      Add('DRAWING_NAME','Чертеж',70);
      AddInvisible('OBJECT_ID');
      AddInvisible('DRAWING_ID');
      AddInvisible('FILE_NAME');
      AddInvisible('OBJECT_NAME');
      AddInvisible('DRAWING_DESCRIPTION');
      AddInvisible('PRIORITY');
    end;
    Orders.Add('PRIORITY',otAsc);
  end;
  FieldFileName:='FILE_NAME';
end;

destructor TSgtsRbkObjectDrawingsFrame.Destroy;
begin
  inherited Destroy;
end;

function TSgtsRbkObjectDrawingsFrame.GetCatalog: String;
begin
  Result:=inherited GetCatalog;
  if Assigned(CoreIntf) then
    Result:=CoreIntf.OptionsForm.DrawingCatalog;
end;

end.
