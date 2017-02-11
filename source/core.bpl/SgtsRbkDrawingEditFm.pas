unit SgtsRbkDrawingEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls, DB,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls, SgtsExecuteDefs;

type
  TSgtsRbkDrawingEditForm = class(TSgtsDataEditForm)
    LabelName: TLabel;
    EditName: TEdit;
    MemoNote: TMemo;
    LabelNote: TLabel;
    LabelFileName: TLabel;
    EditFileName: TEdit;
    ButtonFileName: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkDrawingInsertIface=class(TSgtsDataInsertIface)
  private
    FFileNameDef: TSgtsExecuteDefFileName;
    procedure FileNameCheckValue(Def: TSgtsExecuteDef; var NewValue: Variant; var CanSet: Boolean);
  public
    procedure Init; override;
  end;

  TSgtsRbkDrawingUpdateIface=class(TSgtsDataUpdateIface)
  private
    FFileNameDef: TSgtsExecuteDefFileName;
    procedure FileNameCheckValue(Def: TSgtsExecuteDef; var NewValue: Variant; var CanSet: Boolean);
  public
    procedure Init; override;
  end;

  TSgtsRbkDrawingDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;
  
var
  SgtsRbkDrawingEditForm: TSgtsRbkDrawingEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsOptionsFmIntf;

{$R *.dfm}

{ TSgtsRbkDrawingInsertIface }

procedure TSgtsRbkDrawingInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkDrawingEditForm;
  InterfaceName:=SInterfaceDrawingInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertDrawing;
    with ExecuteDefs do begin
      AddKey('DRAWING_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
      FFileNameDef:=AddFileName('FILE_NAME','EditFileName','LabelFileName','ButtonFileName',SFilterDrawings,true);
      FFileNameDef.InitialDir:=CoreIntf.OptionsForm.DrawingCatalog;
      FFileNameDef.OnCheckValue:=FileNameCheckValue;
    end;
  end;
end;

procedure TSgtsRbkDrawingInsertIface.FileNameCheckValue(Def: TSgtsExecuteDef; var NewValue: Variant; var CanSet: Boolean);
var
  FileName: String;
  Catalog: String;
  APos: Integer;
begin
  FileName:=VarToStrDef(NewValue,'');
  Catalog:=Trim(CoreIntf.OptionsForm.DrawingCatalog);
  APos:=AnsiPos(Catalog,FileName);
  if APos=1 then begin
    FileName:=Copy(FileName,APos+Length(Catalog)+Length(PathDelim),Length(FileName));
  end;
  NewValue:=FileName;
end;

{ TSgtsRbkDrawingUpdateIface }

procedure TSgtsRbkDrawingUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkDrawingEditForm;
  InterfaceName:=SInterfaceDrawingUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateDrawing;
    with ExecuteDefs do begin
      AddKeyLink('DRAWING_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
      FFileNameDef:=AddFileName('FILE_NAME','EditFileName','LabelFileName','ButtonFileName',SFilterDrawings,true);
      FFileNameDef.InitialDir:=CoreIntf.OptionsForm.DrawingCatalog;
      FFileNameDef.OnCheckValue:=FileNameCheckValue;
    end;
  end;
end;

procedure TSgtsRbkDrawingUpdateIface.FileNameCheckValue(Def: TSgtsExecuteDef; var NewValue: Variant; var CanSet: Boolean);
var
  FileName: String;
  Catalog: String;
  APos: Integer;
begin
  FileName:=VarToStrDef(NewValue,'');
  Catalog:=Trim(CoreIntf.OptionsForm.DrawingCatalog);
  APos:=AnsiPos(Catalog,FileName);
  if APos=1 then begin
    FileName:=Copy(FileName,APos+Length(Catalog)+Length(PathDelim),Length(FileName));
  end;
  NewValue:=FileName;
end;

{ TSgtsRbkDrawingDeleteIface }

procedure TSgtsRbkDrawingDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceDrawingDelete;
  DeleteQuestion:='Удалить чертеж %NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteDrawing;
    with ExecuteDefs do begin
      AddKeyLink('DRAWING_ID');
      AddInvisible('NAME');
    end;
  end;
end;

end.
