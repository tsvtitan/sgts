unit SgtsJrnJournalObservationsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Menus, ImgList, ComCtrls, StdCtrls, Grids, Mask, DBCtrls, Contnrs,
  CheckLst, 
  DBGrids, ExtCtrls, ToolWin, SgtsDataGridFm, SgtsSelectDefs, SgtsCoreIntf,
  SgtsFm, SgtsControls, SgtsConfig, SgtsDbGrid, SgtsDateEdit,
  SgtsFunSourceDataConditionFm;

type
  TSgtsJrnJournalObservationsIface=class;
  
  TSgtsJrnJournalObservationsForm = class(TSgtsDataGridForm)
    PanelFilter: TPanel;
    GroupBoxFiilter: TGroupBox;
    BevelFilter: TBevel;
    CheckListBoxCycles: TCheckListBox;
    LabelCycles: TLabel;
    EditMeasureType: TEdit;
    ButtonMeasureType: TButton;
    Label1: TLabel;
    LabelDateBegin: TLabel;
    DateTimePickerBegin: TDateTimePicker;
    LabelDateEnd: TLabel;
    DateTimePickerEnd: TDateTimePicker;
    ButtonDate: TButton;
    ButtonApply: TButton;
    GroupBoxInfo: TGroupBox;
    LabelPointCoordinateZ: TLabel;
    LabelConverter: TLabel;
    LabelPointObject: TLabel;
    EditPointCoordinateZ: TEdit;
    EditConverter: TEdit;
    MemoPointObject: TMemo;
    procedure ButtonMeasureTypeClick(Sender: TObject);
    procedure CheckListBoxCyclesClickCheck(Sender: TObject);
    procedure ButtonDateClick(Sender: TObject);
    procedure ButtonApplyClick(Sender: TObject);
  private
    FMeasureTypeId: Variant;
    FOldMeasureTypeId: Variant;
    FDateEditBegin: TSgtsDateEdit;
    FDateEditEnd: TSgtsDateEdit;
    FFilterCount: Integer;
    function GetIface: TSgtsJrnJournalObservationsIface;
    procedure FillCycles;
    function CycleChecked: Boolean;
    function GetFirstCheckedCycle: TSgtsCycleInfo;
    function GetLastCheckedCycle: TSgtsCycleInfo;
    procedure SetDateByCycle;
    procedure DeleteFirstFilters;
    procedure ApplyFilter(WithOpen: Boolean; WithDeleteOld: Boolean);
    procedure ReadParamsByMeasureTypeId(AMeasureTypeId: Variant);
    procedure WriteParamsByMeasureTypeId(AMeasureTypeId: Variant);
    procedure SetDataSetByMeasureTypeId(AMeasureTypeId: Variant);
  protected
    property MeasureTypeId: Variant read FMeasureTypeId; 
    property DateEditBegin: TSgtsDateEdit read FDateEditBegin;
    property DateEditEnd: TSgtsDateEdit read FDateEditEnd;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
    procedure InitByIface(AIface: TSgtsFormIface); override;

    property Iface: TSgtsJrnJournalObservationsIface read GetIface;
  end;

  TSgtsJrnJournalObservationsIface=class(TSgtsDataGridIface)
  private
    FOldPointId: Variant;
    FParamMeasureTypeId: Integer;
    FParamMeasureTypeName: String;
    function GetForm: TSgtsJrnJournalObservationsForm;
  protected
    procedure AfterCreateForm(AForm: TSgtsForm); override;
    procedure DataSetAfterScroll(DataSet: TDataSet); override;

    property ParamMeasureTypeId: Integer read FParamMeasureTypeId write FParamMeasureTypeId;
    property ParamMeasureTypeName: String read FParamMeasureTypeName write FParamMeasureTypeName;
  public
    procedure Init; override;
    procedure CloseData; override;
    procedure OpenData; override;
    procedure ReadParams(DatabaseConfig: Boolean=true); override;
    procedure WriteParams(DatabaseConfig: Boolean=true); override;
    function Adjust: Boolean; override;

    property Form: TSgtsJrnJournalObservationsForm read GetForm;

  end;

var
  SgtsJrnJournalObservationsForm: TSgtsJrnJournalObservationsForm;

implementation

uses DBClient, DateUtils,
     SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS, SgtsUtils, SgtsConsts,
     SgtsJrnJournalObservationEditFm, SgtsDataFm, SgtsGetRecordsConfig,
     SgtsRbkCyclesFm, SgtsRbkMeasureTypesFm, SgtsPeriodFm, SgtsDialogs,
     SgtsProviders, SgtsIface, SgtsConfigIntf;

{$R *.dfm}

{ TSgtsJrnJournalObservationsIface }

procedure TSgtsJrnJournalObservationsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsJrnJournalObservationsForm ;
  InterfaceName:=SInterfaceJournalObservations;
  InsertClass:=nil;
  UpdateClass:=nil;
  DeleteClass:=nil;
  FParamMeasureTypeId:=0;
end;

function TSgtsJrnJournalObservationsIface.GetForm: TSgtsJrnJournalObservationsForm;
begin
  Result:=TSgtsJrnJournalObservationsForm(inherited Form);
end;

procedure TSgtsJrnJournalObservationsIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
end;

procedure TSgtsJrnJournalObservationsIface.CloseData;
begin
  inherited CloseData;
end;

procedure TSgtsJrnJournalObservationsIface.OpenData;
begin
  FOldPointId:=Null;
  inherited OpenData;
end;

procedure TSgtsJrnJournalObservationsIface.ReadParams(DatabaseConfig: Boolean=true);
begin
  inherited ReadParams(DatabaseConfig);
  FParamMeasureTypeId:=ReadParam(SConfigParamMeasureTypeId,FParamMeasureTypeId);
  FParamMeasureTypeName:=ReadParam(SConfigParamMeasureTypeName,FParamMeasureTypeName);
  Columns:='';
  Orders:='';
  Filters:='';
end;

procedure TSgtsJrnJournalObservationsIface.WriteParams(DatabaseConfig: Boolean=true);
begin
  WriteParam(SConfigParamMeasureTypeId,FParamMeasureTypeId);
  WriteParam(SConfigParamMeasureTypeName,FParamMeasureTypeName);
  inherited WriteParams(DatabaseConfig);
end;

function TSgtsJrnJournalObservationsIface.Adjust: Boolean;
begin
  Result:=inherited Adjust;
  if Result then
    Form.WriteParamsByMeasureTypeId(Form.MeasureTypeId);
end;

procedure TSgtsJrnJournalObservationsIface.DataSetAfterScroll(DataSet: TDataSet);
var
  OldCursor: TCursor;
  DS: TSgtsDatabaseCDS;
  FieldPointId: TField;
begin
  inherited DataSetAfterScroll(DataSet);
  if Assigned(Form) then begin
    if DataSet.Active and not DataSet.IsEmpty then begin
      FieldPointId:=DataSet.FindField('POINT_ID');
      if Assigned(FieldPointId) then begin
        if (FOldPointId<>FieldPointId.Value) then begin
          OldCursor:=Screen.Cursor;
          Screen.Cursor:=crHourGlass;
          try
            DS:=TSgtsDatabaseCDS.Create(CoreIntf);
            try
              DS.ProviderName:=SProviderSelectRouteConverters;
              with DS.SelectDefs do begin
                AddInvisible('CONVERTER_NAME');
                AddInvisible('COORDINATE_Z');
                AddInvisible('OBJECT_PATHS');
              end;
              DS.FilterGroups.Add.Filters.Add('POINT_ID',fcEqual,FieldPointId.Value);
              DS.Open;
              if DS.Active and not DS.IsEmpty then begin
                Form.EditConverter.Text:=DS.FieldByName('CONVERTER_NAME').AsString;
                Form.EditPointCoordinateZ.Text:=DS.FieldByName('COORDINATE_Z').AsString;
                Form.MemoPointObject.Lines.Text:=DS.FieldByName('OBJECT_PATHS').AsString;
                FOldPointId:=FieldPointId.Value;
              end;
            finally
              DS.Free;
            end;
          finally
            Screen.Cursor:=OldCursor;
          end;
        end;
      end else begin
        Form.EditConverter.Text:='';
        Form.EditPointCoordinateZ.Text:='';
        Form.MemoPointObject.Lines.Clear;
      end;
    end else begin
      Form.EditConverter.Text:='';
      Form.EditPointCoordinateZ.Text:='';
      Form.MemoPointObject.Lines.Clear;
    end;
  end;
end;

{ TSgtsJrnJournalObservationsForm }

constructor TSgtsJrnJournalObservationsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  FMeasureTypeId:=Null;
  FOldMeasureTypeId:=Null;

  FDateEditBegin:=TSgtsDateEdit.Create(Self);
  FDateEditBegin.Parent:=DateTimePickerBegin.Parent;
  FDateEditBegin.SetBounds(DateTimePickerBegin.Left,DateTimePickerBegin.Top,DateTimePickerBegin.Width,DateTimePickerBegin.Height);
  FDateEditBegin.TabOrder:=DateTimePickerBegin.TabOrder;
  LabelDateBegin.FocusControl:=FDateEditBegin;
  DateTimePickerBegin.Free;

  FDateEditEnd:=TSgtsDateEdit.Create(Self);
  FDateEditEnd.Parent:=DateTimePickerEnd.Parent;
  FDateEditEnd.SetBounds(DateTimePickerEnd.Left,DateTimePickerEnd.Top,DateTimePickerEnd.Width,DateTimePickerEnd.Height);
  FDateEditEnd.TabOrder:=DateTimePickerEnd.TabOrder;
  LabelDateEnd.FocusControl:=FDateEditEnd;
  DateTimePickerEnd.Free;

  FFilterCount:=0;
end;

destructor TSgtsJrnJournalObservationsForm.Destroy;
begin
  DeleteFirstFilters;
  WriteParamsByMeasureTypeId(FMeasureTypeId);
  Grid.Parent:=nil;
  FDateEditEnd.Free;
  FDateEditBegin.Free;
  inherited Destroy;
end;

procedure TSgtsJrnJournalObservationsForm.InitByIface(AIface: TSgtsFormIface);
begin
  inherited InitByIface(AIface);
  if Iface.ParamMeasureTypeId<>0 then
    FMeasureTypeId:=Iface.ParamMeasureTypeId;
  FOldMeasureTypeId:=FMeasureTypeId;
  EditMeasureType.Text:=Iface.ParamMeasureTypeName;
  Grid.Hint:=Iface.InterfaceName+': '+EditMeasureType.Text;
  SetDataSetByMeasureTypeId(FMeasureTypeId);
  FillCycles;
  ApplyFilter(false,false);
end;

function TSgtsJrnJournalObservationsForm.GetIface: TSgtsJrnJournalObservationsIface;
begin
  Result:=TSgtsJrnJournalObservationsIface(inherited Iface);
end;

procedure TSgtsJrnJournalObservationsForm.FillCycles;
var
  DS: TSgtsDatabaseCDS;
  Obj: TSgtsCycleInfo;
  S: String;
  Index: Integer;
  Flag: Boolean;
begin
  if not VarIsNull(FMeasureTypeId) then begin
    ClearStrings(CheckListBoxCycles.Items);
    DS:=TSgtsDatabaseCDS.Create(CoreIntf);
    try
      DS.ProviderName:=SProviderSelectCycles;
      with DS.SelectDefs do begin
        AddInvisible('CYCLE_ID');
        AddInvisible('CYCLE_NUM');
        AddInvisible('CYCLE_MONTH');
        AddInvisible('CYCLE_YEAR');
        AddInvisible('IS_CLOSE');
      end;
      DS.Orders.Add('CYCLE_YEAR',otAsc);
      DS.Orders.Add('CYCLE_MONTH',otAsc);
      DS.Open;
      if DS.Active and not DS.IsEmpty then begin
        CheckListBoxCycles.Items.BeginUpdate;
        try
          Flag:=false;
          DS.First;
          while not DS.Eof do begin
            Obj:=TSgtsCycleInfo.Create;
            Obj.CycleId:=DS.Fields[0].Value;
            Obj.CycleNum:=DS.Fields[1].AsInteger;
            Obj.CycleMonth:=DS.Fields[2].AsInteger;
            Obj.CycleYear:=DS.Fields[3].AsInteger;
            Obj.CycleIsClose:=Boolean(DS.Fields[4].AsInteger);
            S:=Format(SCycleFormat,[Obj.CycleNum,GetMonthNameByIndex(Obj.CycleMonth),Obj.CycleYear]);
            Index:=CheckListBoxCycles.Items.AddObject(S,Obj);
            if not Obj.CycleIsClose and not Flag then begin
              CheckListBoxCycles.Checked[Index]:=true;
              CheckListBoxCycles.Selected[Index]:=true;
              Flag:=true;
            end;
            DS.Next;
          end;
          SetDateByCycle;
        finally
          CheckListBoxCycles.Items.EndUpdate;
        end;
      end;
    finally
      DS.Free;
    end;
  end;
end;

procedure TSgtsJrnJournalObservationsForm.ButtonMeasureTypeClick(
  Sender: TObject);
var
  AIface: TSgtsRbkMeasureTypesIface;
  DS: TSgtsCDS;
  Buffer: String;
begin
  AIface:=TSgtsRbkMeasureTypesIface.Create(CoreIntf);
  try
    if AIface.SelectOnlyLastNode('MEASURE_TYPE_ID',FMeasureTypeId,Buffer) then begin
      DS:=TSgtsCDS.Create(nil);
      try
        DS.XMLData:=Buffer;
        if DS.Active and not DS.IsEmpty then begin
          Self.Update;

          FMeasureTypeId:=DS.FieldByName('MEASURE_TYPE_ID').Value;

          if FMeasureTypeId<>FOldMeasureTypeId then begin
            DeleteFirstFilters;
            WriteParamsByMeasureTypeId(FOldMeasureTypeId);
          end;  

          FOldMeasureTypeId:=FMeasureTypeId;
          EditMeasureType.Text:=DS.FieldByName('NAME').AsString;

          Grid.Hint:=Iface.InterfaceName+': '+EditMeasureType.Text;

          Iface.ParamMeasureTypeId:=FMeasureTypeId;
          Iface.ParamMeasureTypeName:=EditMeasureType.Text;

          SetDataSetByMeasureTypeId(FMeasureTypeId);

          FillCycles;
          ApplyFilter(true,false);
        end;
      finally
        DS.Free;
      end;
    end;
  finally
    AIface.Free;
  end;
end;

function TSgtsJrnJournalObservationsForm.CycleChecked: Boolean;
var
  C1, C2: TSgtsCycleInfo;
begin
  C1:=GetFirstCheckedCycle;
  C2:=GetLastCheckedCycle;
  Result:=Assigned(C1) or
          Assigned(C2);
end;

procedure TSgtsJrnJournalObservationsForm.CheckListBoxCyclesClickCheck(
  Sender: TObject);
begin
  SetDateByCycle;
end;

function TSgtsJrnJournalObservationsForm.GetFirstCheckedCycle: TSgtsCycleInfo;
var
  i: Integer;
begin
  Result:=nil;
  for i:=0 to CheckListBoxCycles.Items.Count-1 do begin
    if CheckListBoxCycles.Checked[i] then begin
      Result:=TSgtsCycleInfo(CheckListBoxCycles.Items.Objects[i]);
      exit;
    end;
  end;
end;

function TSgtsJrnJournalObservationsForm.GetLastCheckedCycle: TSgtsCycleInfo;
var
  i: Integer;
begin
  Result:=nil;
  for i:=CheckListBoxCycles.Items.Count-1 downto 0 do begin
    if CheckListBoxCycles.Checked[i] then begin
      Result:=TSgtsCycleInfo(CheckListBoxCycles.Items.Objects[i]);
      exit;
    end;
  end;
end;

procedure TSgtsJrnJournalObservationsForm.SetDateByCycle;
var
  CycleInfo1, CycleInfo2: TSgtsCycleInfo;
  D1, D2: TDate;
begin
  CycleInfo1:=GetFirstCheckedCycle;
  CycleInfo2:=GetLastCheckedCycle;
  if Assigned(CycleInfo1) and
     Assigned(CycleInfo2) then begin
    D1:=EncodeDate(CycleInfo1.CycleYear,CycleInfo1.CycleMonth+1,1);
    D2:=EncodeDate(CycleInfo2.CycleYear,CycleInfo2.CycleMonth+1,DaysInAMonth(CycleInfo2.CycleYear,CycleInfo2.CycleMonth+1));
    FDateEditBegin.Date:=D1;
    FDateEditEnd.Date:=D2;
  end;
end;

procedure TSgtsJrnJournalObservationsForm.ButtonDateClick(Sender: TObject);
var
  AIface: TSgtsPeriodIface;
  PeriodType: TSgtsPeriodType;
  DateBegin: TDate;
  DateEnd: TDate;
begin
  AIface:=TSgtsPeriodIface.Create(CoreIntf);
  try
    PeriodType:=ptMonth;
    DateBegin:=FDateEditBegin.Date;
    DateEnd:=FDateEditEnd.Date;
    if AIface.Select(PeriodType,DateBegin,DateEnd) then begin
      FDateEditBegin.Date:=DateBegin;
      FDateEditEnd.Date:=DateEnd;
    end;
  finally
    AIface.Free;
  end;
end;

procedure TSgtsJrnJournalObservationsForm.ButtonApplyClick(
  Sender: TObject);
begin
  if Trim(EditMeasureType.Text)='' then begin
    ShowError(SNeedSelectMeasureType);
    EditMeasureType.SetFocus;
    exit;
  end;
  if not CycleChecked then begin
    ShowError(SNeedCheckedCycle);
    CheckListBoxCycles.SetFocus;
    exit;
  end;
  if FDateEditEnd.Date<FDateEditBegin.Date then begin
    ShowError(SDateEndCanNotLessDateBegin);
    FDateEditEnd.SetFocus;
    exit;
  end;
  ApplyFilter(true,true);
end;

procedure TSgtsJrnJournalObservationsForm.DeleteFirstFilters;
var
  i: Integer;
begin
  if Iface.DataSet.FilterGroups.Count>0 then
    for i:=0 to FFilterCount-1 do begin
      Iface.DataSet.FilterGroups.Delete(0);
      Iface.DefaultFilterGroups.Delete(0);
    end;
  FFilterCount:=0;
end;

procedure TSgtsJrnJournalObservationsForm.ApplyFilter(WithOpen: Boolean; WithDeleteOld: Boolean);
var
  i: Integer;
  CycleI: TSgtsCycleInfo;
  AGroup: TSgtsGetRecordsConfigFilterGroup;
  OldCursor: TCursor;
  Temp: TSgtsGetRecordsConfigFilterGroups;
begin
  if CycleChecked then begin
    OldCursor:=Screen.Cursor;
    Screen.Cursor:=crHourGlass;
    Temp:=TSgtsGetRecordsConfigFilterGroups.Create;
    try
      if WithDeleteOld then
        DeleteFirstFilters;
      AGroup:=Temp.Add;
      for i:=0 to CheckListBoxCycles.Count-1 do begin
        if CheckListBoxCycles.Checked[i] then begin
          CycleI:=TSgtsCycleInfo(CheckListBoxCycles.Items.Objects[i]);
          AGroup.Filters.Add('CYCLE_ID',fcEqual,CycleI.CycleId).Operator:=foOr;
        end;
      end;
      if FDateEditBegin.Date<>NullDate then
        Temp.Add.Filters.Add('DATE_OBSERVATION',fcEqualGreater,FDateEditBegin.Date2);
      if FDateEditEnd.Date<>NullDate then
        Temp.Add.Filters.Add('DATE_OBSERVATION',fcEqualLess,FDateEditEnd.Date2);

      FFilterCount:=Temp.Count;

      Iface.CloseData;
      Iface.DataSet.IndexName:='';
      Iface.DataSet.FilterGroups.CopyFrom(Temp,False,True);
      Iface.DefaultFilterGroups.CopyFrom(Temp,False,True);

      if Grid.AutoFit then
        Grid.AutoFitColumns;

      if WithOpen then
        Iface.OpenData;
    finally
      Temp.Free;
      Screen.Cursor:=OldCursor;
    end;
  end;
end;

procedure TSgtsJrnJournalObservationsForm.ReadParamsByMeasureTypeId;
var
  NewSection: String;
begin
  if Assigned(CoreIntf) and
     not VarIsNull(FMeasureTypeId) then begin
    with CoreIntf.DatabaseConfig do begin
      NewSection:=Format('%s%s',[Iface.SectionName,VarToStrDef(FMeasureTypeId,'')]);
      Grid.SetColumnsStr(Read(NewSection,SConfigParamColumns,Grid.GetColumnsStr,cmBase64));
      UpdateGridColumnsBySelectDefs(Grid,Iface.DataSet.SelectDefs);
      Grid.AutoFit:=Read(NewSection,SConfigParamAutoFit,Grid.AutoFit);
      Iface.DataSet.Orders.SetOrdersStr(Read(NewSection,SConfigParamOrders,Iface.DataSet.Orders.GetOrdersStr,cmBase64));
      Iface.DataSet.FilterGroups.SetFiltersStr(Read(NewSection,SConfigParamFilters,Iface.DataSet.FilterGroups.GetFiltersStr,cmBase64));
    end;
  end;
end;

procedure TSgtsJrnJournalObservationsForm.WriteParamsByMeasureTypeId(AMeasureTypeId: Variant);
var
  NewSection: String;
begin
  if Assigned(CoreIntf) and
     not VarIsNull(AMeasureTypeId) then begin
    with CoreIntf.DatabaseConfig do begin
      NewSection:=Format('%s%s',[Iface.SectionName,VarToStrDef(AMeasureTypeId,'')]);
      Write(NewSection,SConfigParamColumns,Grid.GetColumnsStr,cmBase64);
      Write(NewSection,SConfigParamAutoFit,Grid.AutoFit);
      Write(NewSection,SConfigParamOrders,Iface.DataSet.Orders.GetOrdersStr,cmBase64);
      Write(NewSection,SConfigParamFilters,Iface.DataSet.FilterGroups.GetFiltersStr,cmBase64);
    end;
  end;
end;

procedure TSgtsJrnJournalObservationsForm.SetDataSetByMeasureTypeId(AMeasureTypeId: Variant);
var
  Config: TSgtsConfig;
  Columns: TStringList;
  i: Integer;
  DS: TSgtsDatabaseCDS;
  S: String;
  IsVisible: Boolean;
  AFieldName: String;
  AWidth: Integer;
  Def: TSgtsSelectDef;
  OldCursor: TCursor;
const
  SField='Поле';
  SWidth='Ширина';
  SFormat='Формат';
begin
  if not VarIsNull(AMeasureTypeId) and
     Assigned(Iface.Database) then begin
    OldCursor:=Screen.Cursor;
    Screen.Cursor:=crHourGlass;
    DS:=TSgtsDatabaseCDS.Create(CoreIntf);
    try
      DS.ProviderName:=SProviderSelectCuts;
      with DS.SelectDefs do begin
        AddInvisible('VIEW_NAME');
        AddInvisible('DETERMINATION');
        AddInvisible('CONDITION');
      end;
      DS.FilterGroups.Add.Filters.Add('CUT_ID',fcEqual,AMeasureTypeId);
      DS.Open;
      if DS.Active then begin
        with Iface.DataSet do begin
          Iface.CloseData;
          IndexName:='';
          SelectDefs.Clear;
          FilterGroups.Clear;
          Orders.Clear;
          ProviderName:=DS.FieldByName('VIEW_NAME').AsString;
          Iface.Database.GetRecordsProviders.AddDefault(ProviderName);
          Config:=TSgtsConfig.Create(CoreIntf);
          Columns:=TStringList.Create;
          try
            Config.LoadFromString(DS.FieldByName('DETERMINATION').AsString);
            Config.ReadSection(SCutDeterminationColumns,Columns);
            for i:=0 to Columns.Count-1 do begin
              S:=Columns[i];
              IsVisible:=Config.Read(SCutDeterminationColumns,S,true);
              AFieldName:=Config.Read(S,SField,'');
              if IsVisible then begin
                if Trim(AFieldName)<>'' then begin
                  AWidth:=Config.Read(S,SWidth,50);
                  Def:=SelectDefs.Add(AFieldName,S,AWidth);
                  if Assigned(Def) then begin
                    Def.DisplayFormat:=Config.Read(S,SFormat,'');
                  end;
                end;
              end else begin
                if Trim(AFieldName)<>'' then
                  SelectDefs.AddInvisible(AFieldName);
              end;
            end;
            FilterGroups.Add.Filters.AddSql(DS.FieldByName('CONDITION').AsString);

            Grid.ColumnSort:=nil;
            CreateGridColumnsBySelectDefs(Grid,SelectDefs);
            Orders.CopyFromSelectDefs(SelectDefs);
            Iface.DefaultOrders.CopyFrom(Orders);
            FilterGroups.CopyFromSelectDefs(SelectDefs);
            Iface.DefaultFilterGroups.CopyFrom(FilterGroups);

            Grid.AutoFit:=false;
            ReadParamsByMeasureTypeId(AMeasureTypeId);
            WriteParamsByMeasureTypeId(AMeasureTypeId);
          finally
            Columns.Free;
            Config.Free;
          end;
        end;
      end;
    finally
      DS.Free;
      Screen.Cursor:=OldCursor;
    end;
  end;   
end;

end.
