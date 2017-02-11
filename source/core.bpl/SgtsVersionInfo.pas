unit SgtsVersionInfo;

interface

uses Windows;

type
  TModuleVersion = record
    case Integer of
    0: (Minor, Major, Build, Release: Word);
    1: (VersionMS, VersionLS: LongInt);
  end;

  TWindowsVersion = (pvUnknown, pvWin32s, pvWindows95, pvWindows95OSR2,
    pvWindows98, pvWindows98Se, pvWindowsMe, pvWindowsNT, pvWindows2000,
    pvWindowsXP);

  TProductType = (ptUnknown, ptWinNT, ptServerNT, ptLanmanNT);

  TSgtsVersionInfo = class(TObject)
  private
    FFileName: PChar;
    FBuffer: PChar;
    FSize: Integer;
    FValidRead: boolean;
    procedure ReadVersionInfo;
    function GetFileName: string;
    procedure SetFileName(const Value: string);
    function GetTranslation: Pointer;
    function GetFixedFileInfo: PVSFixedFileInfo;
    function GetFileLongVersion: TModuleVersion;
    function GetProducTModuleVersion: TModuleVersion;
    function GetVersionNum: Longint;
    function GetTranslationString: string;
    function GetOSVersion: string;
    function GetMemoryTotal: string;
    function GetFileDate: TDateTime;
    function GetWindowsVersion: TWindowsVersion;
    function GetProductType: TProductType;
  protected
    property FixedFileInfo: PVSFixedFileInfo read GetFixedFileInfo;
  public
    constructor Create(const AFileName: string);
    destructor Destroy; override;
    function GetFileVersion: string;
    function GetProductVersion: string;
    function GetProductName: string;
    function GetVerValue(const VerName: string): string;
    property FileDate: TDateTime read GetFileDate;
    property FileLongVersion: TModuleVersion read GetFileLongVersion;
    property FileName: string read GetFileName write SetFileName;
    property MemoryTotal: string read GetMemoryTotal;
    property OSVersion: string read GetOSVersion;
    property ProductLongVersion: TModuleVersion read GetProducTModuleVersion;
    property ProductType: TProductType read GetProductType;
    property ValidRead: boolean read FValidRead;
    property VersionNum: Longint read GetVersionNum;
    property Values[const Name: string]: string read GetVerValue;
    property WindowsVersion: TWindowsVersion read GetWindowsVersion;
  end;

function GetWindowsVersion: TWindowsVersion;

implementation

uses SysUtils;

const
  INFO_FMT_VER     = '%s (Build %d.%2.2d.%d)';
  INFO_FMT_VERCSD  = '%s (Build %d.%2.2d.%d: %s)';

  INFO_FMT_PROJECT = 'Version %d.%d (Build %d.%d)';
  INFO_FMT_SYSTEM  = '%s';
  INFO_FMT_MEMORY  = 'Äîñòóïíî äëÿ Windows: %39s';
  INFO_FMT_URL     = 'Copyright© 1996-2001 %s';
  
type
  TVersionKeys =
     ( vkCompanyName     , vkFileDescription, vkFileVersion    ,
       vkInternalName    , vkLegalCopyright , vkLegalTrademarks,
       vkOriginalFileName, vkProductName    , vkProductVersion ,
       vkComments         );
const
  aVersionKeys: array[TVersionKeys] of PChar =
     ( 'CompanyName'     , 'FileDescription', 'FileVersion'    ,
       'InternalName'    , 'LegalCopyright' , 'LegalTrademarks',
       'OriginalFileName', 'ProductName'    , 'ProductVersion' ,
       'Comments'        );

  aWindowsVersion: array[TWindowsVersion] of PChar =
    ('Unknown', 'Win32s', 'Windows 95', 'Windows 95OSR2', 'Windows 98',
     'Windows 98Se', 'Windows Me', 'Windows NT', 'Windows 2000', 'Windows XP');

function VersionToString(const Version: TModuleVersion): string;
begin
  with Version do
    Result := Format('%d.%d.%d.%d', [Major, Minor, Release, Build]);
end;

function GetWindowsVersion: TWindowsVersion;
begin
  Result := pvUnknown;
  case Win32Platform of
    VER_PLATFORM_WIN32s: Result := pvWin32s;
    VER_PLATFORM_WIN32_WINDOWS:
      begin
        if (Win32MajorVersion >= 4) and (Win32MinorVersion >= 10) then
        begin
          case Win32MinorVersion of
            90: Result := pvWindowsMe;
            else
              if Trim(Win32CSDVersion) = 'A' then
                Result := pvWindows98Se
              else
                Result := pvWindows98;
          end;
        end
        else begin
          if Trim(Win32CSDVersion) = 'B' then
            Result := pvWindows95OSR2
          else
            Result := pvWindows95;
        end;
      end;
    VER_PLATFORM_WIN32_NT:
      begin
        if (Win32MajorVersion > 4) then
        begin
          case Win32MinorVersion of
            0: Result := pvWindows2000;
            1: Result := pvWindowsXP;
          end;
        end
        else
          Result := pvWindowsNT;
      end;
   end;
end;

constructor TSgtsVersionInfo.Create(const AFileName: string);
begin
  inherited Create;
  FFileName := StrPCopy(StrAlloc(Length(AFileName) + 1), AFileName);
  ReadVersionInfo
end;

destructor TSgtsVersionInfo.Destroy;
begin
  if FBuffer <> nil then FreeMem(FBuffer, FSize);
  StrDispose(FFileName);
  inherited Destroy;
end;

procedure TSgtsVersionInfo.ReadVersionInfo;
 var
   Handle: DWord;
begin
  FValidRead := False;
  FSize := GetFileVersionInfoSize(FFileName, Handle);
  if FSize > 0 then
    try
      GetMem(FBuffer, FSize);
      FValidRead := GetFileVersionInfo(FFileName, Handle, FSize, FBuffer)
    except
      raise;
    end;
end;

function TSgtsVersionInfo.GetFileName: string;
begin
  Result := StrPas(FFileName);
end;

procedure TSgtsVersionInfo.SetFileName(const Value: string);
begin
  if FBuffer <> nil then FreeMem(FBuffer, FSize);
  FBuffer := nil;
  StrDispose(FFileName);
  FFileName := StrPCopy(StrAlloc(Length(Value) + 1), Value);
  ReadVersionInfo
end;

function TSgtsVersionInfo.GetTranslation: Pointer;
var
  Len: UINT;
begin
  if FValidRead then VerQueryValue(FBuffer, '\VarFileInfo\Translation', Result, Len)
  else Result := nil;
end;

function TSgtsVersionInfo.GetTranslationString: string;
var
  P: Pointer;
begin
  Result := '';
  P := GetTranslation;
  if P <> nil then
    Result := IntToHex(MakeLong(HiWord(Longint(P^)), LoWord(Longint(P^))), 8);
end;

function TSgtsVersionInfo.GetFixedFileInfo: PVSFixedFileInfo;
var
  Len: UINT;
begin
  if FValidRead then VerQueryValue(FBuffer, '\', Pointer(Result), Len)
  else Result := nil;
end;

function TSgtsVersionInfo.GetProducTModuleVersion: TModuleVersion;
begin
  if Assigned(FixedFileInfo) then
  begin
    Result.VersionMS := FixedFileInfo^.dwProductVersionMS;
    Result.VersionLS := FixedFileInfo^.dwProductVersionLS;
  end
end;

function TSgtsVersionInfo.GetFileLongVersion: TModuleVersion;
begin
  if Assigned(FixedFileInfo) then
  begin
    Result.VersionMS := FixedFileInfo^.dwFileVersionMS;
    Result.VersionLS := FixedFileInfo^.dwFileVersionLS;
  end
end;

function TSgtsVersionInfo.GetVersionNum: Longint;
begin
  Result := FixedFileInfo^.dwFileVersionMS
end;

function TSgtsVersionInfo.GetVerValue(const VerName: string): string;
var
  szName: array[0..255] of Char;
  Value: Pointer;
  Len: UINT;
begin
  Result := '';
  StrPCopy(szName, '\StringFileInfo\' + GetTranslationString + '\' + VerName);
  if FValidRead and VerQueryValue(FBuffer, szName, Value, Len) then
    Result := StrPas(PChar(Value))
  else
    Result := '';
end;

function TSgtsVersionInfo.GetOSVersion: string;
 var
  Version: TModuleVersion;
begin
  {GetVersionEx}
  with Version do
  begin
    Major := Win32MajorVersion;
    Minor := Win32MinorVersion;
  end;
  case GetWindowsVersion of
    pvWindows95..pvWindowsMe:
      Version.Build := {LO Word} Win32BuildNumber and $FFFF;
    else
      Version.Build := Win32BuildNumber;
  end;
   with Version do
     if CompareStr(Trim(Win32CSDVersion), '') = 0 then
       Result := Format(INFO_FMT_VER, [aWindowsVersion[GetWindowsVersion],
         Major, Minor, Build])
     else
       Result := Format(INFO_FMT_VERCSD, [aWindowsVersion[GetWindowsVersion],
         Major, Minor, Build, Win32CSDVersion]);
end;

function TSgtsVersionInfo.GetMemoryTotal: string;
 var
  MS: TMemoryStatus;
begin
  MS.dwLength := SizeOf(TMemoryStatus);
  GlobalMemoryStatus(MS);
  Result := FormatFloat('#,###" KB"', MS.dwTotalPhys div 1024);
end;

function TSgtsVersionInfo.GetFileVersion: string;
begin
  Result := GetVerValue(aVersionKeys[vkFileVersion]);
  if Result = '' then begin
    if Assigned(FixedFileInfo) then
      Result := VersionToString(FileLongVersion);
  end;
end;

function TSgtsVersionInfo.GetProductVersion: string;
begin
  Result := GetVerValue(aVersionKeys[vkProductVersion]);
  if Result = '' then Result := VersionToString(ProductLongVersion);
end;

function TSgtsVersionInfo.GetProductName: string;
begin
  Result := GetVerValue(aVersionKeys[vkProductName]);
end;

function TSgtsVersionInfo.GetFileDate: TDateTime;
 var
  Age: integer;
begin
  Age := FileAge(FFileName);
  Result := FileDateToDateTime(Age);
end;

function TSgtsVersionInfo.GetWindowsVersion: TWindowsVersion;
begin
  Result := SgtsVersionInfo.GetWindowsVersion;
end;

function TSgtsVersionInfo.GetProductType: TProductType;
 const
  ProductType = 'System\CurrentControlSet\Control\ProductOptions';
  aProduct: array[ptWinNT..ptLanmanNT] of PChar = ('WinNT', 'ServerNT',
    'LanmanNT');
 var
  Product: string;
  i: TProductType;
  DataType, DataSize: Integer;
  TempKey: HKey;
  KeyOpenValue: boolean;
begin
  Result := ptUnknown;
  KeyOpenValue := RegOpenKeyEx(HKEY_LOCAL_MACHINE, ProductType, 0, KEY_READ,
    TempKey) = ERROR_SUCCESS;
  if KeyOpenValue and (RegQueryValueEx(TempKey, 'ProductType', nil, @DataType,
    nil, @DataSize) = ERROR_SUCCESS) then
  begin
    SetString(Product, nil, DataSize - 1);
    if RegQueryValueEx(TempKey, 'ProductType', nil, @DataType, PByte(Product),
      @DataSize) = ERROR_SUCCESS then
    begin
      for i := ptWinNT to ptLanmanNT do
        if CompareText(aProduct[i], Product) = 0 then
        begin
          Result := i;
          Break;
        end;
    end;
    RegCloseKey(TempKey);
  end;
end;

end.
