unit SgtsConfigIntf;

interface

uses Classes, SgtsObjIntf;

type
  TSgtsConfigMode=(cmDefault,cmBase64);

  ISgtsConfig=interface(ISgtsObj)
  ['{7F1A3024-4DFD-462C-B7FB-3A659FCB052A}']
  { methods }
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromFile(const FileName: string);
    procedure SaveToFile(const FileName: string);
    procedure Write(const Section,Param: String; Value: Variant; Mode: TSgtsConfigMode=cmDefault);
    function Read(const Section,Param: String; Default: Variant; Mode: TSgtsConfigMode=cmDefault): Variant;
    procedure ReadSection(const Section: String; Strings: TStrings);
    procedure ReadSectionValues(const Section: String; Strings: TStrings);
    procedure UpdateFile;

  { properties }
    function _GetFileName: String;

    property FileName: String read _GetFileName;
  end;

implementation

end.
