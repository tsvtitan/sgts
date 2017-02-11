unit SgtsMainFmIntf;

interface

uses Menus, SgtsMenus,
     SgtsFmIntf;

type

  ISgtsMainForm=interface(ISgtsForm)
  ['{F05249BF-6F3E-4A83-B836-77E837F063F1}']
  { methods }

    procedure Progress(Min, Max, Position: Integer);
    procedure Progress2(Min, Max, Position: Integer);
    procedure Start;

  { properties }
    function _GetWindowMaximized: Boolean;
    procedure _SetWindowMaximized(Value: Boolean);
    function _GetClientHandle: THandle;
    function _GetMainMenu: TMainMenu;

    property WindowMaximized: Boolean read _GetWindowMaximized write _SetWindowMaximized;
    property ClientHandle: THandle read _GetClientHandle;
    property MainMenu: TMainMenu read _GetMainMenu;
  end;

implementation

end.
