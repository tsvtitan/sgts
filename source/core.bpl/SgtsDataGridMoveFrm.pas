unit SgtsDataGridMoveFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SgtsDataGridFrm, Menus, DB, ImgList, Grids, DBGrids, ExtCtrls,
  ComCtrls, ToolWin;

type
  TSgtsDataGridMoveFrame = class(TSgtsDataGridFrame)
    ToolButtonMoveUp: TToolButton;
    ToolButton1: TToolButton;
    ToolButtonMoveDown: TToolButton;
    procedure ToolButtonMoveUpClick(Sender: TObject);
    procedure ToolButtonMoveDownClick(Sender: TObject);
  private
    { Private declarations }
  public

    procedure UpdateButtons; override;

    procedure MoveUp; virtual;
    procedure MoveDown; virtual;

    function CanMoveUp: Boolean; virtual;
    function CanMoveDown: Boolean; virtual;
  end;

var
  SgtsDataGridMoveFrame: TSgtsDataGridMoveFrame;

implementation

{$R *.dfm}

{ TSgtsDataGridMoveFrame }

procedure TSgtsDataGridMoveFrame.UpdateButtons;
begin
  ToolButtonMoveUp.Enabled:=CanMoveUp;
  ToolButtonMoveDown.Enabled:=CanMoveDown;
  inherited UpdateButtons;
end;

procedure TSgtsDataGridMoveFrame.MoveUp;
begin
  if CanMoveUp then begin
    DataSet.MoveDataUp;
  end;
end;

procedure TSgtsDataGridMoveFrame.MoveDown;
begin
  if CanMoveDown then begin
    DataSet.MoveDataDown;
  end;
end;

function TSgtsDataGridMoveFrame.CanMoveUp: Boolean;
begin
  Result:=CanPrior;
end;

function TSgtsDataGridMoveFrame.CanMoveDown: Boolean;
begin
  Result:=CanNext;
end;

procedure TSgtsDataGridMoveFrame.ToolButtonMoveUpClick(Sender: TObject);
begin
  MoveUp;
end;

procedure TSgtsDataGridMoveFrame.ToolButtonMoveDownClick(Sender: TObject);
begin
  MoveDown;
end;

end.
