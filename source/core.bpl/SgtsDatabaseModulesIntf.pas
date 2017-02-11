unit SgtsDatabaseModulesIntf;

interface

uses SgtsModulesIntf, SgtsDatabaseIntf;

type

  ISgtsDatabaseModule=interface(ISgtsModule)
  ['{F758D73E-8AC8-4086-AC03-41B94E49B5B3}']

  { methods }
    procedure InitByDatabase(ADatabaseIntf: ISgtsDatabase);

  { properties }
    function _GetDatabase: ISgtsDatabase;

    property Database: ISgtsDatabase read _GetDatabase;
  end;

  ISgtsDatabaseModules=interface(ISgtsModules)
  ['{1305DFAD-5E1A-4820-BFBF-0998FD29AE16}']

  { methods }

  { properties }
    function _GetItems(Index: Integer): ISgtsDatabaseModule; 
    function _GetCurrent: ISgtsDatabaseModule;
    procedure _SetCurrent(Value: ISgtsDatabaseModule);

    property Items[Index: Integer]: ISgtsDatabaseModule read _GetItems;
    property Current: ISgtsDatabaseModule read _GetCurrent write _SetCurrent;
  end;

implementation

end.
