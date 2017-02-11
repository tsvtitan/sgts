unit SgtsIfaceIntf;

interface

uses SgtsObjIntf, SgtsConfigIntf;

type

  ISgtsIface=interface(ISgtsObj)
  ['{8AE673D4-8963-46CC-AE2D-B5D4396192EB}']
    { methods }
    procedure WriteParam(const Param: String; Value: Variant; Mode: TSgtsConfigMode=cmDefault; DatabaseConfig: Boolean=true);
    function ReadParam(const Param: String; Default: Variant; Mode: TSgtsConfigMode=cmDefault; DatabaseConfig: Boolean=true): Variant;
    procedure ReadParams(DatabaseConfig: Boolean=true);
    procedure WriteParams(DatabaseConfig: Boolean=true);
    function PermissionExists(const AName: String): Boolean;

  end;

implementation

end.
