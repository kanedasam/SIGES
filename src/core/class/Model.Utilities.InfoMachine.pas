unit Model.Utilities.InfoMachine;

interface

uses Winsock, Model.PcnTyped, System.Classes, IdStackWindows, Winapi.Windows;

type

  WKSTA_INFO_100 = record
    wki100_platform_id: DWORD;
    wki100_computername: LPWSTR;
    wki100_langroup: LPWSTR;
    wki100_ver_major: DWORD;
    wki100_ver_minor: DWORD;
  end;
  LPWKSTA_INFO_100 = ^WKSTA_INFO_100;

  _USER_INFO_0 = record
    usri0_name: LPWSTR;
  end;

  TInfoMachine = class(TObject)
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }

    function GetSerialHD(const SourceDrive: String): String;
    function GetMacAddress(): string;
    function GetWinVersion: string;
    function GetInfoOS: rc_win_info;
    function GetVarSystem(const VarName: string): string;
    function GetIPFromHost(var HostName, IPaddr, WSAErr: string): Boolean;
    function GetListIPs : Tstrings;
    function GetNameMachineFromIP(const IP: string): string;
    function FindAllComputersNetWork(Workgroup: string; WithIP: Boolean): TStringList;
    function GetNetParam(AParam: Integer): string;


    constructor Create;
    destructor Destroy; override;
  end;

const
  NERR_Success = 0;

  function NetWkstaGetInfo(ServerName: LPWSTR; Level: DWORD;
  BufPtr: Pointer): Longint; stdcall; external 'netapi32.dll' Name 'NetWkstaGetInfo';

implementation


uses
  System.SysUtils, OverbyteIcsWSocket;


{ TInfoMachine }

constructor TInfoMachine.Create;
begin

end;

destructor TInfoMachine.Destroy;
begin

  inherited;
end;

function TInfoMachine.GetSerialHD(const SourceDrive: String): String;
var SerialNumber, DirLenght, Marks: DWord;
  DriveLabel: Array[0..11] of Char;
  stringDrive: String;
  charDrive:  Char;
begin
 Result := 'Error';
 if (length(SourceDrive) = 0) then Exit;

 stringDrive := SourceDrive[1]; charDrive := stringDrive[1];

 if (charDrive in ['A'..'Z','a'..'z'] = false) then Exit;

 try
     GetVolumeInformation(PChar(charDrive+':\'), DriveLabel, 12, @SerialNumber, DirLenght, Marks, nil, 0);
     Result := IntToHex(SerialNumber,8);
 except
     Result := 'Error';
 end;
end;

function TInfoMachine.GetMacAddress(): string;
var
  Lib: Cardinal;
  Func: function(GUID: PGUID): Longint; stdcall;
  GUID1, GUID2: TGUID;
begin
  Result := '';
  Lib := LoadLibrary('rpcrt4.dll');
  if Lib <> 0 then
  begin
    @Func := GetProcAddress(Lib, 'UuidCreateSequential');
    if Assigned(Func) then
    begin
      if (Func(@GUID1) = 0) and (Func(@GUID2) = 0) and (GUID1.D4[2] = GUID2.D4[2]) and
         (GUID1.D4[3] = GUID2.D4[3]) and (GUID1.D4[4] = GUID2.D4[4]) and
         (GUID1.D4[5] = GUID2.D4[5]) and (GUID1.D4[6] = GUID2.D4[6]) and
         (GUID1.D4[7] = GUID2.D4[7]) then
      begin
        Result := IntToHex(GUID1.D4[2], 2) + '-' + IntToHex(GUID1.D4[3], 2) +
                  '-' + IntToHex(GUID1.D4[4], 2) + '-' +
                  IntToHex(GUID1.D4[5], 2) + '-' +
                  IntToHex(GUID1.D4[6], 2) + '-' + IntToHex(GUID1.D4[7], 2);
      end;
    end;
  end;
end;

function TInfoMachine.GetWinVersion: string;
var
  VersionInfo: TOSVersionInfo;
begin
  VersionInfo.dwOSVersionInfoSize:=SizeOf(VersionInfo);
  GetVersionEx(VersionInfo);
  Result:='';
  with VersionInfo do
  begin
    case dwPlatformId of
      1:
        case dwMinorVersion of
          0:  Result:='Windows 95';
          10: Result:='Windows 98';
          90: Result:='Windows Me';
        end;
      2:

    case dwMajorVersion of
      5:
        case dwMinorVersion of
          0:
            Result := 'Windows 2000';
          1:
            Result := 'Windows XP';
          2:
            Result := 'Windows Server 2003';
        end;
      6:
        case dwMinorVersion of
          0:
            Result := 'Windows Vista';
          1:
            Result := 'Windows 7';
          2:
            Result := 'Windows 8';
          3:
            Result := 'Windows 8.1';
        end;
      10:
        case dwMinorVersion of
          0:
             Result := 'Windows 10';
            end;
        end;
    end;
  end;
  if (Result='') then
    Result:='OS desconhecido';
end;

function TInfoMachine.GetVarSystem(const VarName: string): string;
var
  BufSize: Integer;
begin
  BufSize := GetEnvironmentVariable(PChar(VarName), nil, 0);
  if BufSize > 0 then
  begin
    SetLength(Result, BufSize - 1);
    GetEnvironmentVariable(PChar(VarName),
      PChar(Result), BufSize);
  end
  else
    Result := '';
end;

function TInfoMachine.GetInfoOS: rc_win_info;

    function OSArchitectureToStr(const a: TOSVersion.TArchitecture): string;
    begin
      case a of
        arIntelX86: Result := 'IntelX86';
        arIntelX64: Result := 'IntelX64';
      else
        Result := 'UNKNOWN OS architecture';
      end;
    end;

    function OSPlatformToStr(const p: TOSVersion.TPlatform): string;
    begin
      case p of
        pfWindows: Result := 'Windows';
        pfMacOS: Result := 'MacOS';
      else
          Result := 'UNKNOWN OS Platform';
      end;
    end;
    function PlatformFromPointer: integer;
    begin
      Result := SizeOf(Pointer) * 8;
    end;

begin
  with Result do
  begin
    architecture := OSArchitectureToStr(TOSVersion.Architecture);
    Bits         := IntToStr(PlatformFromPointer);
    os           := OSPlatformToStr(TOSVersion.Platform) + IntToStr(PlatformFromPointer);
    build        := IntToStr(TOSVersion.Build);
    major        := IntToStr(TOSVersion.Major);
    minor        := IntToStr(TOSVersion.Minor);
    winname      := TOSVersion.Name;
    sp_major     := IntToStr(TOSVersion.ServicePackMajor);
    sp_minor     := IntToStr(TOSVersion.ServicePackMinor);
    descfull     := TOSVersion.ToString;
  end;
end;

function TInfoMachine.GetIPFromHost(var HostName, IPaddr, WSAErr: string): Boolean;
type
  Name = array [0 .. 100] of Char;
  PName = ^Name;
var
  {HEnt: pHostEnt;
  HName: PName;
  WSAData: TWSAData;
  i: Integer;}
  HName: array[0..100] of AnsiChar;
  HEnt: pHostEnt;
  WSAData: TWSAData;
  i: Integer;
begin
 Result := False;
  if WSAStartup($0101, WSAData) <> 0 then begin
    WSAErr := 'Winsock is not responding."';
    Exit;
  end;
  IPaddr := '';
  //New(HName);
  if GetHostName(HName, SizeOf(Name)) = 0 then
  begin
    HostName := StrPas(HName);
    HEnt := GetHostByName(HName);
    for i := 0 to HEnt^.h_length - 1 do
      IPaddr := Concat(IPaddr, IntToStr(Ord(HEnt^.h_addr_list^[i])) + '.');
    SetLength(IPaddr, length(IPaddr) - 1);
    Result := True;

  end
  else
  begin
    case WSAGetLastError of
      WSANOTINITIALISED:
        WSAErr := 'WSANotInitialised';
      WSAENETDOWN:
        WSAErr := 'WSAENetDown';
      WSAEINPROGRESS:
        WSAErr := 'WSAEInProgress';
    end;
  end;
  //Dispose(HName);
  WSACleanup;
end;

function TInfoMachine.GetListIPs: Tstrings;


type
  TaPInAddr = array[0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe: PHostEnt;
  pptr: PaPInAddr;
  Buffer:  array[0..100] of AnsiChar;
  Buffer2:  PAnsiChar;
  I: Integer;
  GInitData: TWSAData;
begin
  WSAStartup($101, GInitData);
  Result := TstringList.Create;
  Result.Clear;
  GetHostName(Buffer, SizeOf(Buffer));
  phe := GetHostByName(buffer);
  if phe = nil then Exit;
  pPtr := PaPInAddr(phe^.h_addr_list);
  Buffer2 := phe^.h_name;
  I    := 0;

  while pPtr^[I] <> nil do
  begin
    Result.Add(inet_ntoa(pptr^[I]^));
    Inc(I);
  end;
  WSACleanup;
end;

function TInfoMachine.GetNameMachineFromIP(const IP: string): string;
var
  IdStackWin: TIdStackWindows;
begin
  IdStackWin := TIdStackWindows.Create;
  try
      Result := IdStackWin.HostByAddress(IP);
  finally
      IdStackWin.Free;
  end;
end;


function TInfoMachine.GetNetParam(AParam: Integer): string;
var
  PBuf: LPWKSTA_INFO_100;
  Res: LongInt;
begin
  Result := '';
  Res := NetWkstaGetInfo(nil, 100, @PBuf);
  if Res = NERR_Success then
  begin
    case AParam of
      0: Result := string(PBuf^.wki100_computername);
      1: Result := string(PBuf^.wki100_langroup);
    end;
  end;
end;

function TInfoMachine.FindAllComputersNetWork(Workgroup: string; WithIP: Boolean): TStringList;
var
  EnumHandle : THandle;
  WorkgroupRS : TNetResource;
  Buf : Array[1..500] of TNetResource;
  BufSize : cardinal;
  Entries : cardinal;
  Res : Integer;
  Computers : Tstringlist;
  Limit, I: Integer;
  IPMachine,MachineName,_WorkgroupName  : String;
begin
  Limit := 0;

  if Workgroup = '' then Workgroup := GetNetParam(1);

  _WorkgroupName := Workgroup + #0;
  FillChar(WorkgroupRS, SizeOf(WorkgroupRS) , 0);
  With WorkgroupRS do
  begin
    dwScope := 2;
    dwType := 3;
    dwDisplayType := 1;
    dwUsage := 2;
    lpRemoteName := @_WorkgroupName[1];
  end;
  WNetOpenEnum(RESOURCE_GLOBALNET, RESOURCETYPE_ANY, 0,
    @WorkgroupRS, EnumHandle);
  Computers := TStringList.Create;
  repeat
    Entries := 1;
    BufSize := SizeOf(Buf);
    Res := WNetEnumResource(EnumHandle, Entries, @Buf, BufSize);
    if (Res = NO_ERROR) and (Entries = 1) then
    begin
      Computers.Add(StrPas(Buf[1].lpRemoteName));
    end;
    Inc(Limit);
  until (Res <> NO_ERROR) or (Limit > 100);
  WNetCloseEnum( EnumHandle );
  if WithIP then
  begin
    for I := 0 to Computers.Count-1 do
    Begin
      MachineName :=  Computers[I];
      Self.GetIPFromHost(MachineName,IPMachine,IPMachine);
      Computers[I] := 'Grupo de Rede: '+Workgroup+'|'+'PC: '+Computers[I] + '=' + IPMachine;
    End;
  end;
  Result :=  Computers;
end;

end.
