unit SgtsMenus;

interface

uses Windows, Types, Graphics, Menus, SysUtils;

type

  TMenuItem=class(Menus.TMenuItem)
  protected
    procedure AdvancedDrawItem(ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState; TopLevel: Boolean); override;
  end;

implementation

{ TMenuItem }

procedure TMenuItem.AdvancedDrawItem(ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState; TopLevel: Boolean);
var
  OldMinor: Integer;
begin
  OldMinor:=Win32MinorVersion;
  try
    Win32MinorVersion:=0;
    inherited;
  finally
    Win32MinorVersion:=OldMinor;
  end;
end;


end.
