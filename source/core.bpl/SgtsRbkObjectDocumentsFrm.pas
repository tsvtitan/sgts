unit SgtsRbkObjectDocumentsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SgtsDataGridOleFrm, Menus, DB, ImgList, StdCtrls, Grids,
  DBGrids, ExtCtrls, ComCtrls, ToolWin, OleCtnrs,
  SgtsRbkObjectDocumentEditFm, SgtsDataInsertBySelect, SgtsExecuteDefs,
  SgtsRbkDocumentEditFm;

type
  TSgtsRbkObjectDocumentsFrame = class(TSgtsDataGridOleFrame)
  private
    { Private declarations }
  protected
    function GetCatalog: String; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TSgtsRbkObjectDocumentInsertIface=class(TSgtsDataInsertBySelectIface)
  private
    FPriorityDef: TSgtsExecuteDefCalc;
    FDocumentNameDef: TSgtsExecuteDefInvisible;
    FDocumentDescDef: TSgtsExecuteDefInvisible;
    function GetPriority(Def: TSgtsExecuteDefCalc): Variant;
  public
    procedure Init; override;
    procedure SetDefValues; override;
  end;

  TSgtsRbkPointDocumentUpdateIface=class(TSgtsRbkDocumentUpdateIface)
  private
    FDocumentNameDef: TSgtsExecuteDefEdit;
    FDocumentDescDef: TSgtsExecuteDefMemo;
  public
    procedure Init; override;
  end;

var
  SgtsRbkObjectDocumentsFrame: TSgtsRbkObjectDocumentsFrame;

implementation

{$R *.dfm}

uses SgtsDialogs, SgtsConsts, SgtsUtils, SgtsProviderConsts,
     SgtsGetRecordsConfig, SgtsDataGridFrm,
     SgtsCoreIntf, SgtsRbkDocumentsFm, SgtsCDS;

{ TSgtsRbkObjectDocumentInsertIface }

procedure TSgtsRbkObjectDocumentInsertIface.Init;
begin
  inherited Init;
  SelectClass:=TSgtsRbkDocumentsIface;
  with DataSet do begin
    ProviderName:=SProviderInsertObjectDocument;
    with ExecuteDefs do begin
      AddInvisible('OBJECT_ID');
      AddInvisible('DOCUMENT_ID');
      FPriorityDef:=AddCalc('PRIORITY',GetPriority);
      FDocumentNameDef:=AddInvisible('DOCUMENT_NAME',ptUnknown);
      FDocumentNameDef.Twins.Add('NAME');
      FDocumentDescDef:=AddInvisible('DOCUMENT_DESCRIPTION',ptUnknown);
      FDocumentDescDef.Twins.Add('DESCRIPTION');
      AddInvisible('FILE_NAME',ptUnknown);
      AddInvisible('OBJECT_NAME',ptUnknown);
    end;
  end;
end;

function TSgtsRbkObjectDocumentInsertIface.GetPriority(Def: TSgtsExecuteDefCalc): Variant;
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

procedure TSgtsRbkObjectDocumentInsertIface.SetDefValues; 
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    FPriorityDef.DefaultValue:=GetPriority(FPriorityDef);
    FPriorityDef.SetDefault;
  end;
end;

{ TSgtsRbkPointDocumentUpdateIface }

procedure TSgtsRbkPointDocumentUpdateIface.Init;
begin
  inherited Init;
  with DataSet do begin
    with ExecuteDefs do begin
      FDocumentNameDef:=TSgtsExecuteDefEdit(Find('NAME'));
      FDocumentNameDef.Twins.Add('DOCUMENT_NAME');
      FDocumentDescDef:=TSgtsExecuteDefMemo(Find('DESCRIPTION'));
      FDocumentDescDef.Twins.Add('DOCUMENT_DESCRIPTION');
    end;
  end;
end;

{ TSgtsRbkObjectDocumentsFrame }

constructor TSgtsRbkObjectDocumentsFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  InsertClass:=TSgtsRbkObjectDocumentInsertIface;
  UpdateClass:=TSgtsRbkPointDocumentUpdateIface;
  DeleteClass:=TSgtsRbkObjectDocumentDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectObjectDocuments;
    with SelectDefs do begin
      Add('DOCUMENT_NAME','Документ',70);
      AddInvisible('OBJECT_ID');
      AddInvisible('DOCUMENT_ID');
      AddInvisible('FILE_NAME');
      AddInvisible('OBJECT_NAME');
      AddInvisible('DOCUMENT_DESCRIPTION');
      AddInvisible('PRIORITY');
    end;
    Orders.Add('PRIORITY',otAsc);
  end;
  FieldFileName:='FILE_NAME';
end;

destructor TSgtsRbkObjectDocumentsFrame.Destroy;
begin
  inherited Destroy;
end;

function TSgtsRbkObjectDocumentsFrame.GetCatalog: String;
begin
  Result:=inherited GetCatalog;
  if Assigned(CoreIntf) then
    Result:=CoreIntf.OptionsForm.DocumentCatalog;
end;

end.
