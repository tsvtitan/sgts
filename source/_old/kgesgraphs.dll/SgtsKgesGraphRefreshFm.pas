unit SgtsKgesGraphRefreshFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Menus,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, DBClient, DB, DateUtils, CheckLst, Contnrs,
  SgtsGraphRefreshFm, SgtsFm, SgtsCoreIntf, SgtsGraphIfaceIntf, SgtsGraphChartFm,
  SgtsDateEdit, SgtsControls, SgtsGraphChartSeriesDefs, SgtsPeriodFm;

type
  TSgtsKgesGraphAxisParamType=(aptLine,aptPoint,aptBar,aptArea);

  TSgtsKgesGraphAxisParam=class(TObject)
  private
    FName: String;
    FChecked: Boolean;
    FGroup: Integer;
    FFieldName: String;
    FParamType: TSgtsKgesGraphAxisParamType;
    FXMerging: Boolean;
    FUseFilter: Boolean;
  public
    constructor Create;
    property Name: String read FName write FName;
    property Checked: Boolean read FChecked write FChecked;
    property Group: Integer read FGroup write FGroup;
    property FieldName: String read FFieldName write FFieldName;
    property ParamType: TSgtsKgesGraphAxisParamType read FParamType write FParamType;
    property XMerging: Boolean read FXMerging write FXMerging;
    property UseFilter: Boolean read FUseFilter write FUseFilter; 
  end;

  TSgtsKgesGraphAxisParams=class(TObjectList)
  private
    function GetItems(Index: Integer): TSgtsKgesGraphAxisParam;
    procedure SetItems(Index: Integer; Value: TSgtsKgesGraphAxisParam);
  public
    function Add(Name, FieldName: String; Group: Integer=-1; UseFilter: Boolean=false): TSgtsKgesGraphAxisParam;

    procedure CopyFrom(Source: TSgtsKgesGraphAxisParams; WithClear: Boolean=true; WithGroup: Boolean=true);

    function GetFirstCheckGroup: Integer;
    function GetFirstCheck: TSgtsKgesGraphAxisParam;
    procedure CheckAll;
    procedure UnCheckAll;
    function CheckCount: Integer;
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: TStream);
    function GetParamsStr: String;
    procedure SetParamsStr(Value: String);

    property Items[Index: Integer]: TSgtsKgesGraphAxisParam read GetItems write SetItems;
  end;

  TSgtsKgesGraphRefreshIface=class;

  TSgtsKgesGraphRefreshForm = class(TSgtsGraphRefreshForm)
    PanelType: TPanel;
    GroupBoxType: TGroupBox;
    ButtonDefault: TButton;
    PopupMenuParams: TPopupMenu;
    MenuItemParamCheckAll: TMenuItem;
    MenuItemParamUnCheckAll: TMenuItem;
    EditName: TEdit;
    PanelAxis: TPanel;
    GroupBoxAxis: TGroupBox;
    PanelAxis2: TPanel;
    TabControlAxis: TTabControl;
    CheckListBoxParams: TCheckListBox;
    procedure ButtonDefaultClick(Sender: TObject);
    procedure ButtonOkClick(Sender: TObject);
    procedure TabControlAxisChange(Sender: TObject);
    procedure CheckListBoxParamsClickCheck(Sender: TObject);
    procedure MenuItemParamCheckAllClick(Sender: TObject);
    procedure MenuItemParamUnCheckAllClick(Sender: TObject);
    procedure CheckListBoxParamsDblClick(Sender: TObject);
  private
    FCurrenAxisParams: TSgtsKgesGraphAxisParams;
    FLeftAxisParams: TSgtsKgesGraphAxisParams;
    FRightAxisParams: TSgtsKgesGraphAxisParams;
    FBottomAxisParams: TSgtsKgesGraphAxisParams;

    function GetIface: TSgtsKgesGraphRefreshIface;
    procedure FillParams(Index: Integer);
    function GetAxisParams(Index: Integer): TSgtsKgesGraphAxisParams;
    procedure CheckParams(Index: Integer);

  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;

    property Iface: TSgtsKgesGraphRefreshIface read GetIface;
  end;

  TSgtsKgesGraphRefreshIface=class(TSgtsGraphRefreshIface)
  private
    FDefaultLeftAxisParams: TSgtsKgesGraphAxisParams;
    FDefaultRightAxisParams: TSgtsKgesGraphAxisParams;
    FDefaultBottomAxisParams: TSgtsKgesGraphAxisParams;
    FLeftAxisParams: TSgtsKgesGraphAxisParams;
    FRightAxisParams: TSgtsKgesGraphAxisParams;
    FBottomAxisParams: TSgtsKgesGraphAxisParams;
    FParamLeftAxisParams: String;
    FParamRightAxisParams: String;
    FParamBottomAxisParams: String;
    FDefaultGraphName: String;
    FGraphName: String;

    function GetForm: TSgtsKgesGraphRefreshForm;
  protected
    function GetFormClass: TSgtsFormClass; override;
    procedure AfterCreateForm(AForm: TSgtsForm); override;
    procedure BeforeShowModal; override;
    procedure AfterShowModal(ModalResult: TModalResult); override;

    property DefaultLeftAxisParams: TSgtsKgesGraphAxisParams read FDefaultLeftAxisParams;
    property DefaultRightAxisParams: TSgtsKgesGraphAxisParams read FDefaultRightAxisParams;
    property DefaultBottomAxisParams: TSgtsKgesGraphAxisParams read FDefaultBottomAxisParams;
  public
    constructor Create(ACoreIntf: ISgtsCore; AIfaceIntf: ISgtsGraphIface); override;
    destructor Destroy; override;

    procedure ReadParams(DatabaseConfig: Boolean=true); override;
    procedure WriteParams(DatabaseConfig: Boolean=true); override;

    procedure BeforeReadParams; override;
    procedure BeforeWriteParams; override;

    property LeftAxisParams: TSgtsKgesGraphAxisParams read FLeftAxisParams;
    property RightAxisParams: TSgtsKgesGraphAxisParams read FRightAxisParams;
    property BottomAxisParams: TSgtsKgesGraphAxisParams read FBottomAxisParams;

    property Form: TSgtsKgesGraphRefreshForm read GetForm;
    property DefaultGraphName: String read FDefaultGraphName write FDefaultGraphName;
    property GraphName: String read FGraphName write FGraphName;
  end;

var
  SgtsKgesGraphRefreshForm: TSgtsKgesGraphRefreshForm;

implementation

uses SgtsUtils, SgtsConsts, SgtsKgesGraphsConsts, SgtsDialogs,
     SgtsRbkCyclesFm, SgtsCDS, SgtsIface, SgtsConfigIntf;

{$R *.dfm}

{ TSgtsKgesGraphAxisParam }

constructor TSgtsKgesGraphAxisParam.Create;
begin
  inherited Create;
  FXMerging:=true;
  FUseFilter:=false;
end;

{ TSgtsKgesGraphAxisParams }

function TSgtsKgesGraphAxisParams.GetItems(Index: Integer): TSgtsKgesGraphAxisParam;
begin
  Result:=TSgtsKgesGraphAxisParam(inherited Items[Index]);
end;

procedure TSgtsKgesGraphAxisParams.SetItems(Index: Integer; Value: TSgtsKgesGraphAxisParam);
begin
  inherited Items[Index]:=Value;
end;

function TSgtsKgesGraphAxisParams.Add(Name, FieldName: String; Group: Integer=-1; UseFilter: Boolean=false): TSgtsKgesGraphAxisParam;
var
  Param: TSgtsKgesGraphAxisParam;
begin
  Param:=TSgtsKgesGraphAxisParam.Create;
  Param.Name:=Name;
  Param.FieldName:=FieldName;
  Param.Group:=Group;
  Param.UseFilter:=UseFilter;
  Result:=Param;
  inherited Add(Param);
end;

procedure TSgtsKgesGraphAxisParams.CopyFrom(Source: TSgtsKgesGraphAxisParams; WithClear: Boolean=true; WithGroup: Boolean=true);
var
  i: Integer;
  Param1, Param2: TSgtsKgesGraphAxisParam;
begin
  if Assigned(Source) then begin
    if WithClear then
      Clear;
    for i:=0 to Source.Count-1 do begin
      Param1:=Source.Items[i];
      Param2:=Add(Param1.Name,Param1.FieldName,iff(WithGroup,Param1.Group,-1));
      Param2.Checked:=Param1.Checked;
      Param2.ParamType:=Param1.ParamType;
      Param2.XMerging:=Param1.XMerging;
      Param2.UseFilter:=Param1.UseFilter;
    end;
  end;
end;

function TSgtsKgesGraphAxisParams.GetFirstCheckGroup: Integer;
var
  Param: TSgtsKgesGraphAxisParam;
begin
  Result:=-2;
  Param:=GetFirstCheck;
  if Assigned(Param) then
    Result:=Param.Group;
end;

function TSgtsKgesGraphAxisParams.GetFirstCheck: TSgtsKgesGraphAxisParam;
var
  i: Integer;
begin
  Result:=nil;
  for i:=0 to Count-1 do begin
    if Items[i].Checked then begin
      Result:=Items[i];
      break;
    end;
  end;
end;

procedure TSgtsKgesGraphAxisParams.CheckAll;
var
  i: Integer;
  Group: Integer;
begin
  Group:=GetFirstCheckGroup;
  for i:=0 to Count-1 do begin
    if Group=-2 then begin
      Items[i].Checked:=true;
      Group:=Items[i].Group;
    end else begin
      if Group<>-1 then begin
        Items[i].Checked:=Group=Items[i].Group;
      end;  
    end;  
  end;  
end;

procedure TSgtsKgesGraphAxisParams.UnCheckAll;
var
  i: Integer;
begin
  for i:=0 to Count-1 do
    Items[i].Checked:=false;
end;

function TSgtsKgesGraphAxisParams.CheckCount: Integer;
var
  i: Integer;
begin
  Result:=0;
  for i:=0 to Count-1 do
    if Items[i].Checked then
      Inc(Result);
end;

procedure TSgtsKgesGraphAxisParams.LoadFromStream(Stream: TStream);
var
  Reader: TReader;
  Item: TSgtsKgesGraphAxisParam;
  S1, S2: String;
  Group: Integer;
begin
  Reader:=TReader.Create(Stream,FilerPageSize);
  try
    Reader.ReadListBegin;
    Clear;
    while not Reader.EndOfList do begin
      S1:=Reader.ReadString;
      S2:=Reader.ReadString;
      Group:=Reader.ReadInteger;
      Item:=Add(S1,S2,Group);
      if Assigned(Item) then begin
        Item.Checked:=Reader.ReadBoolean;
        Item.ParamType:=TSgtsKgesGraphAxisParamType(Reader.ReadInteger);
        Item.XMerging:=Reader.ReadBoolean;
        Item.UseFilter:=Reader.ReadBoolean;
      end;  
    end;
    Reader.ReadListEnd;
  finally
    Reader.Free;
  end;  
end;

procedure TSgtsKgesGraphAxisParams.SaveToStream(Stream: TStream);
var
  i: Integer;
  Writer: TWriter;
  Item: TSgtsKgesGraphAxisParam;
begin
  Writer:=TWriter.Create(Stream,FilerPageSize);
  try
    Writer.WriteListBegin;
    for i:=0 to Count-1 do begin
      Item:=Items[i];
      Writer.WriteString(Item.Name);
      Writer.WriteString(Item.FieldName);
      Writer.WriteInteger(Item.Group);
      Writer.WriteBoolean(Item.Checked);
      Writer.WriteInteger(Integer(Item.ParamType));
      Writer.WriteBoolean(Item.XMerging);
      Writer.WriteBoolean(Item.UseFilter);
    end;
    Writer.WriteListEnd;
  finally
    Writer.Free;
  end;
end;

function TSgtsKgesGraphAxisParams.GetParamsStr: String;
var
  S: String;
  Stream: TMemoryStream;
begin
  Stream:=TMemoryStream.Create;
  try
    Result:='';
    SaveToStream(Stream);
    SetLength(S,Stream.Size);
    System.Move(Stream.Memory^,Pointer(S)^,Stream.Size);
    Result:=S;
  finally
    Stream.Free;
  end;
end;

procedure TSgtsKgesGraphAxisParams.SetParamsStr(Value: String);
var
  Stream: TMemoryStream;
  DefStream: TMemoryStream;
begin
  Stream:=TMemoryStream.Create;
  DefStream:=TMemoryStream.Create;
  try
    SaveToStream(DefStream);
    DefStream.Position:=0;
    Stream.SetSize(Length(Value));
    System.Move(Pointer(Value)^,Stream.Memory^,Length(Value));
    try
      LoadFromStream(Stream);
    except
      LoadFromStream(DefStream);
    end;
  finally
    DefStream.Free;
    Stream.Free;
  end;
end;

{ TSgtsKgesGraphRefreshIface }

constructor TSgtsKgesGraphRefreshIface.Create(ACoreIntf: ISgtsCore; AIfaceIntf: ISgtsGraphIface);
begin
  inherited Create(ACoreIntf,AIfaceIntf);
  StoredInConfig:=true;

  FDefaultLeftAxisParams:=TSgtsKgesGraphAxisParams.Create;
  FDefaultRightAxisParams:=TSgtsKgesGraphAxisParams.Create;
  FDefaultBottomAxisParams:=TSgtsKgesGraphAxisParams.Create;

  FLeftAxisParams:=TSgtsKgesGraphAxisParams.Create;
  FRightAxisParams:=TSgtsKgesGraphAxisParams.Create;
  FBottomAxisParams:=TSgtsKgesGraphAxisParams.Create;

  FParamLeftAxisParams:='';
  FParamRightAxisParams:='';
  FParamBottomAxisParams:='';
end;

destructor TSgtsKgesGraphRefreshIface.Destroy;
begin
  FBottomAxisParams.Free;
  FRightAxisParams.Free;
  FLeftAxisParams.Free;
  FDefaultBottomAxisParams.Free;
  FDefaultRightAxisParams.Free;
  FDefaultLeftAxisParams.Free;
  inherited Destroy;
end;

function TSgtsKgesGraphRefreshIface.GetFormClass: TSgtsFormClass;
begin
  Result:=TSgtsKgesGraphRefreshForm;
end;

function TSgtsKgesGraphRefreshIface.GetForm: TSgtsKgesGraphRefreshForm;
begin
  Result:=TSgtsKgesGraphRefreshForm(inherited Form);
end;

procedure TSgtsKgesGraphRefreshIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
end;

procedure TSgtsKgesGraphRefreshIface.BeforeShowModal;
begin
  inherited BeforeShowModal;
  if Assigned(Form) then begin
    Form.FLeftAxisParams.CopyFrom(FLeftAxisParams);
    Form.FRightAxisParams.CopyFrom(FRightAxisParams);
    Form.FBottomAxisParams.CopyFrom(FBottomAxisParams);
    with Form do begin
      FillParams(TabControlAxis.TabIndex);
      CheckParams(TabControlAxis.TabIndex);
    end;
    Form.EditName.Text:=iff(Trim(FGraphName)<>'',FGraphName,Form.EditName.Text);
  end;
end;

procedure TSgtsKgesGraphRefreshIface.AfterShowModal(ModalResult: TModalResult);
begin
  inherited AfterShowModal(ModalResult);
  if ModalResult=mrOk then begin
    if Assigned(Form) then begin
      FLeftAxisParams.CopyFrom(Form.FLeftAxisParams);
      FRightAxisParams.CopyFrom(Form.FRightAxisParams);
      FBottomAxisParams.CopyFrom(Form.FBottomAxisParams);
      with Form do begin
        FillParams(TabControlAxis.TabIndex);
        CheckParams(TabControlAxis.TabIndex);
      end;
      FGraphName:=Form.EditName.Text;
    end;
  end;
end;

procedure TSgtsKgesGraphRefreshIface.BeforeReadParams;
begin
  inherited BeforeReadParams;
  FDefaultLeftAxisParams.CopyFrom(FLeftAxisParams);
  FDefaultRightAxisParams.CopyFrom(FRightAxisParams);
  FDefaultBottomAxisParams.CopyFrom(BottomAxisParams);
  FParamLeftAxisParams:=FLeftAxisParams.GetParamsStr;
  FParamRightAxisParams:=FRightAxisParams.GetParamsStr;
  FParamBottomAxisParams:=FBottomAxisParams.GetParamsStr;
  FDefaultGraphName:=FGraphName;
end;

procedure TSgtsKgesGraphRefreshIface.BeforeWriteParams;
begin
  inherited BeforeWriteParams;
  FParamLeftAxisParams:=FLeftAxisParams.GetParamsStr;
  FParamRightAxisParams:=FRightAxisParams.GetParamsStr;
  FParamBottomAxisParams:=FBottomAxisParams.GetParamsStr;
end;

procedure TSgtsKgesGraphRefreshIface.ReadParams(DatabaseConfig: Boolean=true);
begin
  inherited ReadParams(DatabaseConfig);
  FParamLeftAxisParams:=ReadParam(SConfigParamLeftAxisParams,FParamLeftAxisParams,cmBase64);
  FLeftAxisParams.SetParamsStr(FParamLeftAxisParams);
  FParamRightAxisParams:=ReadParam(SConfigParamRightAxisParams,FParamRightAxisParams,cmBase64);
  FRightAxisParams.SetParamsStr(FParamRightAxisParams);
  FParamBottomAxisParams:=ReadParam(SConfigParamBottomAxisParams,FParamBottomAxisParams,cmBase64);
  FBottomAxisParams.SetParamsStr(FParamBottomAxisParams);
  FGraphName:=ReadParam(SConfigParamGraphName,FGraphName);
end;

procedure TSgtsKgesGraphRefreshIface.WriteParams(DatabaseConfig: Boolean=true);
begin
  WriteParam(SConfigParamLeftAxisParams,FParamLeftAxisParams,cmBase64);
  WriteParam(SConfigParamRightAxisParams,FParamRightAxisParams,cmBase64);
  WriteParam(SConfigParamBottomAxisParams,FParamBottomAxisParams,cmBase64);
  WriteParam(SConfigParamGraphName,FGraphName);
  inherited WriteParams(DatabaseConfig);
end;

{ TSgtsKgesGraphRefreshForm }

constructor TSgtsKgesGraphRefreshForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  FLeftAxisParams:=TSgtsKgesGraphAxisParams.Create;
  FRightAxisParams:=TSgtsKgesGraphAxisParams.Create;
  FBottomAxisParams:=TSgtsKgesGraphAxisParams.Create;
end;

destructor TSgtsKgesGraphRefreshForm.Destroy;
begin
  FBottomAxisParams.Free;
  FRightAxisParams.Free;
  FLeftAxisParams.Free;
  inherited Destroy;
end;

function TSgtsKgesGraphRefreshForm.GetIface: TSgtsKgesGraphRefreshIface;
begin
  Result:=TSgtsKgesGraphRefreshIface(inherited Iface);
end;

function TSgtsKgesGraphRefreshForm.GetAxisParams(Index: Integer): TSgtsKgesGraphAxisParams;
begin
  Result:=nil;
  case Index of
    0: Result:=FLeftAxisParams;
    1: Result:=FBottomAxisParams;
    2: Result:=FRightAxisParams;
  end;
end;

procedure TSgtsKgesGraphRefreshForm.CheckParams(Index: Integer);
var
  i: Integer;
  FirstCheckGroup: Integer;
  AxisParams: TSgtsKgesGraphAxisParams;
  Param: TSgtsKgesGraphAxisParam;
begin
  AxisParams:=GetAxisParams(Index);
  if Assigned(AxisParams) then begin
    FirstCheckGroup:=AxisParams.GetFirstCheckGroup;
    CheckListBoxParams.Items.BeginUpdate;
    try
      for i:=0 to CheckListBoxParams.Count-1 do begin
        Param:=TSgtsKgesGraphAxisParam(CheckListBoxParams.Items.Objects[i]);
        CheckListBoxParams.Checked[i]:=Param.Checked;
        if FirstCheckGroup<>-2 then begin
          if FirstCheckGroup<>-1 then
            CheckListBoxParams.ItemEnabled[i]:=Param.Group=FirstCheckGroup
          else
            if not Param.Checked then
              CheckListBoxParams.ItemEnabled[i]:=false;
        end else begin
          CheckListBoxParams.ItemEnabled[i]:=true;
        end;  
      end;
    finally
      CheckListBoxParams.Items.EndUpdate;
    end;
  end;
end;

procedure TSgtsKgesGraphRefreshForm.FillParams(Index: Integer);
var
  i: Integer;
  AxisParams: TSgtsKgesGraphAxisParams;
  Param: TSgtsKgesGraphAxisParam;
begin
  CheckListBoxParams.Items.BeginUpdate;
  try
    CheckListBoxParams.Items.Clear;
    AxisParams:=GetAxisParams(Index);
    FCurrenAxisParams:=AxisParams;
    if Assigned(AxisParams) then begin
      for i:=0 to AxisParams.Count-1 do begin
        Param:=AxisParams.Items[i];
        CheckListBoxParams.Items.AddObject(Param.Name,Param);
        CheckListBoxParams.Checked[i]:=Param.Checked;
      end;
    end;
  finally
    CheckListBoxParams.Items.EndUpdate;
  end;
end;

procedure TSgtsKgesGraphRefreshForm.ButtonDefaultClick(Sender: TObject);
begin
  FLeftAxisParams.CopyFrom(Iface.DefaultLeftAxisParams);
  FRightAxisParams.CopyFrom(Iface.DefaultRightAxisParams);
  FBottomAxisParams.CopyFrom(Iface.DefaultBottomAxisParams);
  FLeftAxisParams.UnCheckAll;
  FRightAxisParams.UnCheckAll;
  FBottomAxisParams.UnCheckAll;
  FillParams(TabControlAxis.TabIndex);
  CheckParams(TabControlAxis.TabIndex);
  EditName.Text:=Iface.DefaultGraphName;
end;

procedure TSgtsKgesGraphRefreshForm.ButtonOkClick(Sender: TObject);
begin
  ModalResult:=mrNone;
  if (FLeftAxisParams.CheckCount=0) or (FBottomAxisParams.CheckCount=0) then begin
    if FLeftAxisParams.CheckCount=0 then begin
      ShowError(SNeedParamsToLeftAxis);
      TabControlAxis.TabIndex:=0;
      TabControlAxisChange(nil);
      CheckListBoxParams.SetFocus;
      exit;
    end;
    if FBottomAxisParams.CheckCount=0 then begin
      ShowError(SNeedParamsToBottomAxis);
      TabControlAxis.TabIndex:=1;
      TabControlAxisChange(nil);
      CheckListBoxParams.SetFocus;
      exit;
    end;
  end;      
  ModalResult:=mrOk;
end;

procedure TSgtsKgesGraphRefreshForm.TabControlAxisChange(Sender: TObject);
begin
  FillParams(TabControlAxis.TabIndex);
  CheckParams(TabControlAxis.TabIndex);
end;

procedure TSgtsKgesGraphRefreshForm.CheckListBoxParamsClickCheck(
  Sender: TObject);
var
  Index: Integer;
  Param: TSgtsKgesGraphAxisParam;
begin
  Index:=CheckListBoxParams.ItemIndex;
  if Index<>-1 then begin
    Param:=TSgtsKgesGraphAxisParam(CheckListBoxParams.Items.Objects[Index]);
    Param.Checked:=CheckListBoxParams.Checked[Index];
  end;
  CheckParams(TabControlAxis.TabIndex);
end;

procedure TSgtsKgesGraphRefreshForm.MenuItemParamCheckAllClick(
  Sender: TObject);
begin
  if Assigned(FCurrenAxisParams) then begin
    FCurrenAxisParams.CheckAll;
    CheckParams(TabControlAxis.TabIndex);
  end;
end;

procedure TSgtsKgesGraphRefreshForm.MenuItemParamUnCheckAllClick(
  Sender: TObject);
begin
  if Assigned(FCurrenAxisParams) then begin
    FCurrenAxisParams.UnCheckAll;
    CheckParams(TabControlAxis.TabIndex);
  end;
end;

procedure TSgtsKgesGraphRefreshForm.CheckListBoxParamsDblClick(
  Sender: TObject);
var
  Index: Integer;
  Param: TSgtsKgesGraphAxisParam;
  S: String;
begin
  Index:=CheckListBoxParams.ItemIndex;
  if Index<>-1 then begin
    Param:=TSgtsKgesGraphAxisParam(CheckListBoxParams.Items.Objects[Index]);
    S:=CheckListBoxParams.Items.Strings[Index];
    if InputQuery(SCaptionAxisParam,SInputAxisParam,S) then begin
      if Trim(S)='' then begin
        ShowError(SParamNameNotEmpty);
      end else begin
        CheckListBoxParams.Items.Strings[Index]:=S;
        Param.Name:=S;
      end;
    end;
  end;
end;

end.
