unit SgtsBaseGraphPeriodObjectsRefreshFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  Menus, StdCtrls, ComCtrls,
  CheckLst, ExtCtrls,
  SgtsBaseGraphPeriodRefreshFm, SgtsFm;

type
  TSgtsBaseGraphPeriodObjectsRefreshIface=class;

  TSgtsBaseGraphPeriodObjectsRefreshForm = class(TSgtsBaseGraphPeriodRefreshForm)
    PanelGroups: TPanel;
    GroupBoxGroups: TGroupBox;
    ComboBoxGroups: TComboBox;
    procedure ButtonOkClick(Sender: TObject);
    procedure ComboBoxGroupsChange(Sender: TObject);
  private
    function GetIface: TSgtsBaseGraphPeriodObjectsRefreshIface;
    procedure FillGroupObjects;
  public
    procedure InitByIface(AIface: TSgtsFormIface); override;
    procedure Default; override;

    property Iface: TSgtsBaseGraphPeriodObjectsRefreshIface read GetIface;
  end;

  TSgtsBaseGraphPeriodObjectsRefreshIface=class(TSgtsBaseGraphPeriodRefreshIface)
  private
    FDetermination: String;
    FGroupId: Integer;
    FGroupName: String;
  protected

    property Determination: String read FDetermination;
  public
    procedure Init; override;
    procedure ReadParams(DatabaseConfig: Boolean=true); override;
    procedure WriteParams(DatabaseConfig: Boolean=true); override;

    property GroupId: Integer read FGroupId write FGroupId;
    property GroupName: String read FGroupName write FGroupName;
  end;

var
  SgtsBaseGraphPeriodObjectsRefreshForm: TSgtsBaseGraphPeriodObjectsRefreshForm;

implementation

uses SgtsGraphRefreshFm, SgtsBaseGraphPeriodObjectsIface, SgtsCoreObj, SgtsConfig,
     SgtsConsts, SgtsBaseGraphRefreshFm, SgtsDialogs, SgtsIface;

{$R *.dfm}

{ TSgtsBaseGraphPeriodObjectsRefreshIface }

procedure TSgtsBaseGraphPeriodObjectsRefreshIface.Init;
begin
  inherited Init;
  FGroupId:=-1;
  FormClass:=TSgtsBaseGraphPeriodObjectsRefreshForm;
  if ParentIface is TSgtsBaseGraphPeriodObjectsIface then begin
    FDetermination:=TSgtsBaseGraphPeriodObjectsIface(ParentIface).Determination;
  end;
end;

procedure TSgtsBaseGraphPeriodObjectsRefreshIface.ReadParams(DatabaseConfig: Boolean=true);
begin
  inherited ReadParams(DatabaseConfig);
  FGroupId:=ReadParam(SConfigParamGroupId,FGroupId);
end;

procedure TSgtsBaseGraphPeriodObjectsRefreshIface.WriteParams(DatabaseConfig: Boolean=true);
begin
  WriteParam(SConfigParamGroupId,FGroupId);
  inherited WriteParams(DatabaseConfig);
end;

{ TSgtsBaseGraphPeriodObjectsRefreshForm }

procedure TSgtsBaseGraphPeriodObjectsRefreshForm.InitByIface(AIface: TSgtsFormIface);
begin
  inherited InitByIface(AIface);
  FillGroupObjects;
end;

function TSgtsBaseGraphPeriodObjectsRefreshForm.GetIface: TSgtsBaseGraphPeriodObjectsRefreshIface;
begin
  Result:=TSgtsBaseGraphPeriodObjectsRefreshIface(inherited Iface);
end;

procedure TSgtsBaseGraphPeriodObjectsRefreshForm.ButtonOkClick(
  Sender: TObject);
begin
  ModalResult:=mrNone;
  if ComboBoxGroups.ItemIndex=-1 then begin
    ShowError(SNeedSelectGroupObjects);
    ComboBoxGroups.SetFocus;
    exit;
  end;
  inherited ButtonOkClick(Sender);
end;

procedure TSgtsBaseGraphPeriodObjectsRefreshForm.Default; 
begin
  inherited Default;
  ComboBoxGroups.ItemIndex:=-1;
  ComboBoxGroupsChange(nil);
end;

procedure TSgtsBaseGraphPeriodObjectsRefreshForm.FillGroupObjects;
var
  Config: TSgtsConfig;
  Strings: TStringList;
  i: Integer;
  S: String;
  GroupId: Integer;
  Index, NewIndex: Integer;
begin
  ComboBoxGroups.Items.BeginUpdate;
  Config:=TSgtsConfig.Create(CoreIntf);
  Strings:=TStringList.Create;
  try
    Config.LoadFromString(Iface.Determination);
    Config.ReadSection(SGraphDeterminationGroupObjects,Strings);
    NewIndex:=-1;
    ComboBoxGroups.Items.Clear;
    for i:=0 to Strings.Count-1 do begin
      S:=Config.Read(SGraphDeterminationGroupObjects,Strings[i],'');
      GroupId:=-1;
      if TryStrToInt(S,GroupId) then begin
        Index:=ComboBoxGroups.Items.AddObject(Strings[i],TObject(GroupId));
        if GroupId=Iface.GroupId then
          NewIndex:=Index;
      end;
    end;
    ComboBoxGroups.ItemIndex:=NewIndex;
    ComboBoxGroupsChange(nil);
  finally
    Strings.Free;
    Config.Free;
    ComboBoxGroups.Items.EndUpdate;
  end;
end;

procedure TSgtsBaseGraphPeriodObjectsRefreshForm.ComboBoxGroupsChange(
  Sender: TObject);
begin
  Iface.GroupId:=-1;
  Iface.GroupName:='';
  if ComboBoxGroups.ItemIndex<>-1 then begin
    Iface.GroupId:=Integer(ComboBoxGroups.Items.Objects[ComboBoxGroups.ItemIndex]);
    Iface.GroupName:=ComboBoxGroups.Text;
  end;
end;

end.
