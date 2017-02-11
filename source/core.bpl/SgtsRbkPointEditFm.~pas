unit SgtsRbkPointEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls, DB,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls, SgtsCoreIntf, SgtsExecuteDefs;

type
  TSgtsRbkPointEditForm = class(TSgtsDataEditForm)
    LabelName: TLabel;
    EditName: TEdit;
    LabelObject: TLabel;
    ButtonObject: TButton;
    LabelDescription: TLabel;
    MemoDescription: TMemo;
    LabelTypePoint: TLabel;
    ComboBoxTypePoint: TComboBox;
    ButtonTypePoint: TButton;
    LabelCoordinateX: TLabel;
    EditCoordinateX: TEdit;
    LabelCoordinateY: TLabel;
    EditCoordinateY: TEdit;
    LabelCoordinateZ: TLabel;
    EditCoordinateZ: TEdit;
    LabelDateEnter: TLabel;
    DateTimePickerEnter: TDateTimePicker;
    MemoObject: TMemo;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkPointInsertIface=class(TSgtsDataInsertIface)
  private
    FObjectIdDef: TSgtsExecuteDefMemoLink;
    FObjectNameDef: TSgtsExecuteDefInvisible;
    procedure ObjectIdDefCheckValue(Def: TSgtsExecuteDef; var NewValue: Variant; var CanSet: Boolean);
  public
    procedure Init; override;
  end;

  TSgtsRbkPointUpdateIface=class(TSgtsDataUpdateIface)
  private
    FObjectIdDef: TSgtsExecuteDefMemoLink;
    FObjectNameDef: TSgtsExecuteDefInvisible;
    procedure ObjectIdDefCheckValue(Def: TSgtsExecuteDef; var NewValue: Variant; var CanSet: Boolean);
  public
    procedure Init; override;
  end;

  TSgtsRbkPointDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkPointEditForm: TSgtsRbkPointEditForm;

implementation

uses DBClient, DateUtils,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs,
     SgtsRbkObjectsFm, SgtsRbkPointTypesFm, SgtsRbkObjectTreesFm, SgtsDataIfaceIntf;

{$R *.dfm}

procedure InternalObjectIdDefCheckValue(ObjectIdDef: TSgtsExecuteDefMemoLink;
                                        ObjectNameDef: TSgtsExecuteDefInvisible;
                                        var NewValue: Variant; var CanSet: Boolean);
var
  DS: TSgtsDatabaseCDS;
  OldCursor: TCursor;
begin
  OldCursor:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  DS:=TSgtsDatabaseCDS.Create(ObjectIdDef.CoreIntf);
  try
    DS.StopException:=true;
    DS.ProviderName:=SProviderGetObjectPaths;
    with DS.ExecuteDefs do begin
      AddInvisible('OBJECT_ID').Value:=NewValue;
      AddInvisible('PATHS',ptOutput);
      AddInvisible('NAME',ptOutput);
    end;
    DS.Execute;
    ObjectIdDef.Link.Value:=DS.ExecuteDefs.Find('PATHS').Value;
    ObjectNameDef.Value:=DS.ExecuteDefs.Find('NAME').Value;
    CanSet:=DS.ExecuteSuccess;
  finally
    DS.Free;
    Screen.Cursor:=OldCursor;
  end;
end;

{ TSgtsRbkPointInsertIface }

procedure TSgtsRbkPointInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPointEditForm;
  InterfaceName:=SInterfacePointInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertPoint;
    with ExecuteDefs do begin
      AddKey('POINT_ID');
      AddEditInteger('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoDescription','LabelDescription',false);
      AddComboLink('POINT_TYPE_ID','ComboBoxTypePoint','LabelTypePoint','ButtonTypePoint',
                   TSgtsRbkPointTypesIface,'POINT_TYPE_NAME','NAME','POINT_TYPE_ID',true).AutoFill:=true;
      FObjectIdDef:=AddMemoLink('OBJECT_ID','MemoObject','LabelObject','ButtonObject',
                                TSgtsRbkObjectTreesIface,'OBJECT_PATHS','OBJECT_PATHS','OBJECT_ID',true);
      FObjectIdDef.OnCheckValue:=ObjectIdDefCheckValue;
      AddEditFloat('COORDINATE_X','EditCoordinateX','LabelCoordinateX');
      AddEditFloat('COORDINATE_Y','EditCoordinateY','LabelCoordinateY');
      AddEditFloat('COORDINATE_Z','EditCoordinateZ','LabelCoordinateZ');
      AddDate('DATE_ENTER','DateTimePickerEnter','LabelDateEnter',true);
      FObjectNameDef:=AddInvisible('OBJECT_NAME',ptUnknown);
    end;
  end;
end;

procedure TSgtsRbkPointInsertIface.ObjectIdDefCheckValue(Def: TSgtsExecuteDef; var NewValue: Variant; var CanSet: Boolean);
begin
  InternalObjectIdDefCheckValue(FObjectIdDef,FObjectNameDef,NewValue,CanSet);
end;

{ TSgtsRbkPointUpdateIface }

procedure TSgtsRbkPointUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPointEditForm;
  InterfaceName:=SInterfacePointUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdatePoint;
    with ExecuteDefs do begin
      AddKeyLink('POINT_ID');
      AddEditInteger('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoDescription','LabelDescription',false);
      AddComboLink('POINT_TYPE_ID','ComboBoxTypePoint','LabelTypePoint','ButtonTypePoint',
                   TSgtsRbkPointTypesIface,'POINT_TYPE_NAME','NAME','POINT_TYPE_ID',true).AutoFill:=true;
      FObjectIdDef:=AddMemoLink('OBJECT_ID','MemoObject','LabelObject','ButtonObject',
                                TSgtsRbkObjectTreesIface,'OBJECT_PATHS','OBJECT_PATHS','OBJECT_ID',true);
      FObjectIdDef.OnCheckValue:=ObjectIdDefCheckValue;
      AddEditFloat('COORDINATE_X','EditCoordinateX','LabelCoordinateX');
      AddEditFloat('COORDINATE_Y','EditCoordinateY','LabelCoordinateY');
      AddEditFloat('COORDINATE_Z','EditCoordinateZ','LabelCoordinateZ');
      AddDate('DATE_ENTER','DateTimePickerEnter','LabelDateEnter',true);
      FObjectNameDef:=AddInvisible('OBJECT_NAME',ptUnknown);
    end;
  end;
end;

procedure TSgtsRbkPointUpdateIface.ObjectIdDefCheckValue(Def: TSgtsExecuteDef; var NewValue: Variant; var CanSet: Boolean);
begin
  InternalObjectIdDefCheckValue(FObjectIdDef,FObjectNameDef,NewValue,CanSet);
end;

{ TSgtsRbkPointDeleteIface }

procedure TSgtsRbkPointDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfacePointDelete;
  DeleteQuestion:='Удалить точку %NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeletePoint;
    with ExecuteDefs do begin
      AddKeyLink('POINT_ID');
      AddInvisible('NAME');
    end;
  end;
end;

{ TSgtsRbkPointEditForm }

constructor TSgtsRbkPointEditForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  DateTimePickerEnter.Date:=DateOf(Date);
end;

end.
