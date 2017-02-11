unit SgtsReportFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ImgList, Menus, StdCtrls, ExtCtrls, ComCtrls, Contnrs,
  SgtsChildFm, SgtsReportFmIntf, SgtsReportIfaceIntf, SgtsFm, SgtsMenus,
  SgtsCoreIntf, SgtsDatabaseCDS;

type
  TSgtsReportIface=class;

  TSgtsReportForm = class(TSgtsChildForm)
  private
    function GetIface: TSgtsReportIface;
  public
    property Iface: TSgtsReportIface read GetIface;
  end;

  TSgtsReportIface=class(TSgtsChildIface,ISgtsReportForm,ISgtsReportIface)
  private
    function GetForm: TSgtsReportForm;
  protected
    function GetFormClass: TSgtsFormClass; override;
    procedure AfterCreateForm(AForm: TSgtsForm); override;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
    procedure Init; overload; override;
    procedure Init(AMenuPath: String); reintroduce; overload; virtual;
    function CanShow: Boolean; override;

    function CanGenerate: Boolean; virtual;
    procedure Generate; virtual;
    procedure UpdateButtons; virtual;

    property Form: TSgtsReportForm read GetForm;
  end;

  TSgtsReportIfaceClass=class of TSgtsReportIface;

  TSgtsReportIfaceClasses=class(TClassList)
  private
    function GetItems(Index: Integer): TSgtsReportIfaceClass;
    procedure SetItems(Index: Integer; Value: TSgtsReportIfaceClass);
  public
    property Items[Index: Integer]: TSgtsReportIfaceClass read GetItems write SetItems;
  end;

var
  SgtsReportForm: TSgtsReportForm;

implementation

uses SgtsIface, SgtsConsts, SgtsUtils;

{$R *.dfm}

{ TSgtsReportIfaceClasses }

function TSgtsReportIfaceClasses.GetItems(Index: Integer): TSgtsReportIfaceClass;
begin
  Result:=TSgtsReportIfaceClass(inherited Items[Index]);
end;

procedure TSgtsReportIfaceClasses.SetItems(Index: Integer; Value: TSgtsReportIfaceClass);
begin
  inherited Items[Index]:=Value;
end;

{ TSgtsReportIface }

constructor TSgtsReportIface.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;

destructor TSgtsReportIface.Destroy;
begin
  inherited Destroy;
end;

procedure  TSgtsReportIface.Init; 
begin
  inherited Init;
end;

procedure TSgtsReportIface.Init(AMenuPath: String);
begin
  Init;
  MenuPath:=AMenuPath;
  with Permissions do begin
    AddDefault(SPermissionNameShow);
  end;
end;

function TSgtsReportIface.GetFormClass: TSgtsFormClass;
begin
  Result:=TSgtsReportForm;
end;

function TSgtsReportIface.GetForm: TSgtsReportForm;
begin
  Result:=TSgtsReportForm(inherited Form);
end;

procedure TSgtsReportIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
  UpdateButtons;
end;

procedure TSgtsReportIface.UpdateButtons;
begin
  if Assigned(Form) then begin
    with Form do begin
    end;
  end;
end;

function TSgtsReportIface.CanShow: Boolean;
begin
  Result:=PermissionExists(SPermissionNameShow);
end;

function TSgtsReportIface.CanGenerate: Boolean;
begin
  Result:=CanShow and
          Assigned(Form);
end;

procedure TSgtsReportIface.Generate;
begin
  if CanGenerate then begin
  end;
end;

{ TSgtsReportForm }

function TSgtsReportForm.GetIface: TSgtsReportIface;
begin
  Result:=TSgtsReportIface(inherited Iface);
end;

end.
