unit SgtsWizFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  SgtsChildFm, SgtsCoreIntf, SgtsWizFmIntf,
  SgtsVersionInfo;

type

  TSgtsWizForm = class(TSgtsChildForm)
    PanelBottom: TPanel;
    ButtonPrior: TButton;
    ButtonNext: TButton;
    ButtonCancel: TButton;
    BevelBottom: TBevel;
    PanelTop: TPanel;
    BevelTop: TBevel;
    ImageLogo: TImage;
    LabelCaption: TLabel;
    LabelHint: TLabel;
    PageControl: TPageControl;
    LabelCompany: TStaticText;
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonPriorClick(Sender: TObject);
    procedure ButtonNextClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FCancelQuestion: String;
    FQuestion: Boolean;
    FVersionInfo: TSgtsVersionInfo;
    procedure HideAllTabs;
    function GetFirstPage: TTabSheet;
    function GetLastPage: TTabSheet;
    procedure First;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;

    function CanNext: Boolean; virtual;
    function CanPrior: Boolean; virtual;
    function CanCancel: Boolean; virtual;

    function CheckNext: Boolean; virtual;
    procedure Next; virtual;
    procedure Prior; virtual;
    procedure Cancel; virtual;
    procedure Ready; virtual;

    procedure UpdateButtons; virtual;
    procedure UpdateLabels; virtual;

    property CancelQuestion: String read FCancelQuestion write FCancelQuestion;
    property Question: Boolean read FQuestion write FQuestion;
    property VersionInfo: TSgtsVersionInfo read FVersionInfo; 
  end;

  TSgtsWizIface=class(TSgtsChildIface,ISgtsWizForm)
  private
  end;

var
  SgtsWizForm: TSgtsWizForm;

implementation

uses Types, ShellAPI,
     SgtsConsts, SgtsUtils, SgtsDialogs;

{$R *.dfm}

{ TSgtsWizIface }


{ TSgtsWizForm }

constructor TSgtsWizForm.Create(ACoreIntf: ISgtsCore);
var
  lpIcon: Word;
begin
  inherited Create(ACoreIntf);
  FVersionInfo:=TSgtsVersionInfo.Create(ParamStr(0));
  FQuestion:=true;
  FCancelQuestion:=SCancelWizard;
  ButtonPrior.Caption:=SButtonCaptionPrior;
  ButtonNext.Caption:=SButtonCaptionNext;
  ButtonCancel.Caption:=SButtonCaptionCancel;
  ImageLogo.Picture.Icon.Handle:=ExtractAssociatedIcon(HInstance,PChar(Application.ExeName),lpIcon);
  HideAllTabs;
  First;
end;

destructor TSgtsWizForm.Destroy;
begin
  FVersionInfo.Free;
  inherited Destroy;
end;

procedure TSgtsWizForm.First;
begin
  PageControl.ActivePage:=GetFirstPage;
  UpdateLabels;
  UpdateButtons;
end;

function TSgtsWizForm.CanNext: Boolean;
var
  Page: TTabSheet;
begin
  Page:=PageControl.FindNextPage(PageControl.ActivePage,true,false);
  Result:=(Page<>GetFirstPage);
end;

function TSgtsWizForm.CanPrior: Boolean;
var
  Page: TTabSheet;
begin
  Page:=PageControl.FindNextPage(PageControl.ActivePage,false,false);
  Result:=(Page<>GetLastPage);
end;

function TSgtsWizForm.CanCancel: Boolean;
begin
  Result:=true;
end;

function TSgtsWizForm.CheckNext: Boolean;
begin
  Result:=true;
end;

procedure TSgtsWizForm.Next;
begin
  if CanNext then begin
    if CheckNext then
      PageControl.SelectNextPage(true,false);
  end else Ready;
  UpdateLabels;
  UpdateButtons;
end;

procedure TSgtsWizForm.Ready;
begin
  FQuestion:=false;
  Close;
end;

procedure TSgtsWizForm.Prior;
begin
  if CanPrior then begin
    PageControl.SelectNextPage(false,false);
  end;
  UpdateLabels;
  UpdateButtons;
end;

procedure TSgtsWizForm.Cancel;
begin
  if CanCancel then
    Close;
end;

procedure TSgtsWizForm.UpdateButtons;
begin
  ButtonPrior.Enabled:=CanPrior;
  ButtonNext.Caption:=iff(not CanNext,SButtonCaptionReady,SButtonCaptionNext);
  ButtonCancel.Enabled:=CanCancel;
end;

procedure TSgtsWizForm.UpdateLabels;
begin
  if Assigned(PageControl.ActivePage) then begin
    LabelCaption.Caption:=PageControl.ActivePage.Caption;
    LabelHint.Caption:=PageControl.ActivePage.Hint;
  end;  
end;

procedure TSgtsWizForm.ButtonCancelClick(Sender: TObject);
begin
  Cancel;
end;

procedure TSgtsWizForm.ButtonPriorClick(Sender: TObject);
begin
  Prior;
end;

procedure TSgtsWizForm.ButtonNextClick(Sender: TObject);
begin
  Next;
end;

procedure TSgtsWizForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  Button: TModalResult;
begin
  if FQuestion then begin
    Button:=ShowQuestion(FCancelQuestion,mbNo);
    case Button of
      mrYes: begin
        CanClose:=true;
      end;
      mrNo: begin
        CanClose:=false;
      end;
    end;
  end else CanClose:=true;  
end;

procedure TSgtsWizForm.HideAllTabs;
var
  i: Integer;
begin
  for i:=0 to PageControl.PageCount-1 do begin
    PageControl.Pages[i].TabVisible:=false;
  end;
end;

function TSgtsWizForm.GetFirstPage: TTabSheet;
begin
  Result:=nil;
  if PageControl.PageCount>0 then
    Result:=PageControl.Pages[0];
end;

function TSgtsWizForm.GetLastPage: TTabSheet;
begin
  Result:=nil;
  if PageControl.PageCount>0 then
    Result:=PageControl.Pages[PageControl.PageCount-1];
end;

end.
