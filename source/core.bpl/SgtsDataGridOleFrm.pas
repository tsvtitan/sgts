unit SgtsDataGridOleFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SgtsDataGridFrm, Menus, DB, ImgList, Grids, DBGrids, ExtCtrls,
  ComCtrls, ToolWin, StdCtrls, OleCtnrs;

type
  TSgtsDataGridOleFrame=class;

  TOleContainer=class(OleCtnrs.TOleContainer)
  private
    FFrame: TSgtsDataGridOleFrame;
  public
    procedure DblClick; override;

    property Frame: TSgtsDataGridOleFrame read FFrame write FFrame;
  end;
  
  TSgtsDataGridOleFrame = class(TSgtsDataGridFrame)
    ToolButtonView: TToolButton;
    Splitter: TSplitter;
    PanelOle: TPanel;
    OleContainer: TOleContainer;
    PanelCheck: TPanel;
    CheckBoxPreview: TCheckBox;
    procedure ToolButtonViewClick(Sender: TObject);
    procedure GridPatternDblClick(Sender: TObject);
    procedure CheckBoxPreviewClick(Sender: TObject);
  private
    FFieldFileName: String;
    function GetCurrentFileName: String;
  protected
    function GetCatalog: String; virtual;
    procedure DataSetAfterScroll(DataSet: TDataSet); override;
    procedure ActivateOle; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateButtons; override;
    function CanView: Boolean;
    procedure View;
    procedure CloseData; override;

    property FieldFileName: String read FFieldFileName write FFieldFileName;
  end;  

var
  SgtsDataGridOleFrame: TSgtsDataGridOleFrame;

implementation

{$R *.dfm}

uses Math, ShellApi;

{ TOleContainer }

procedure TOleContainer.DblClick; 
begin
  if Assigned(FFrame) then
    FFrame.View;
end;

{ TSgtsDataGridOleFrame }

constructor TSgtsDataGridOleFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  OleContainer.Frame:=Self;
end;

destructor TSgtsDataGridOleFrame.Destroy;
begin
  inherited Destroy;
end;

function TSgtsDataGridOleFrame.GetCatalog: String; 
begin
  Result:='';
end;

function TSgtsDataGridOleFrame.GetCurrentFileName: String;
var
  Field: TField;
begin
  Result:='';
  if DataSet.Active then begin
    Field:=DataSet.FindField(FFieldFileName);
    if Assigned(Field) then
      Result:=Field.AsString;
    if not FileExists(Result) then begin
      if DirectoryExists(GetCatalog) then
        Result:=GetCatalog+PathDelim+Result;
    end;  
  end;  
end;

function TSgtsDataGridOleFrame.CanView: Boolean;
begin
  Result:=DataSet.Active and
          not DataSet.IsEmpty and
          FileExists(GetCurrentFileName);
end;

procedure TSgtsDataGridOleFrame.View;
var
  FileName: String;
begin
  if CanView then begin
    FileName:=GetCurrentFileName;
    Repaint;
    ShellExecute(Handle,nil,PChar(FileName),nil,nil,sw_ShowNormal);
  end;
end;

procedure TSgtsDataGridOleFrame.UpdateButtons;
begin
  ToolButtonView.Enabled:=CanView;
  inherited UpdateButtons;
end;

procedure TSgtsDataGridOleFrame.ToolButtonViewClick(Sender: TObject);
begin
  View;
end;

procedure TSgtsDataGridOleFrame.GridPatternDblClick(Sender: TObject);
begin
  View;
end;

procedure TSgtsDataGridOleFrame.DataSetAfterScroll(DataSet: TDataSet);
begin
  inherited DataSetAfterScroll(DataSet);
  ActivateOle;
end;

procedure TSgtsDataGridOleFrame.ActivateOle;
begin
  if CanView and CheckBoxPreview.Checked then begin
    Repaint;
    OleContainer.CreateObjectFromFile(GetCurrentFileName,false);
  end else
    OleContainer.DestroyObject;
end;

procedure TSgtsDataGridOleFrame.CheckBoxPreviewClick(Sender: TObject);
begin
  ActivateOle;
end;

procedure TSgtsDataGridOleFrame.CloseData;
begin
  inherited CloseData;
  OleContainer.DestroyObject;
end;

end.
