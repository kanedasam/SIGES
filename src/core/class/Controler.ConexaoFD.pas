unit Controler.ConexaoFD;

interface

uses System.SysUtils, System.IniFiles,
     FireDAC.Comp.Client, FireDAC.Stan.Option,  Controler.Functions,
  FireDAC.Phys.FB, Model.ConstantsGerais, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util,
  FireDAC.Comp.Script, System.Classes, Model.TypedGeral;

type
  TFDConexao = class
  private
    FMyFDConnection : TFDConnection;
    FDPhysFBDriverLink : TFDPhysFBDriverLink;
    //FDManager: TFDManager;
    class function getValueIni(ArqIni: TIniFile; NameCampo: string): string;
  public
    destructor Destroy; override;
    constructor Create; overload;
    procedure setFDConnection(FDConnection: TFDConnection);

    procedure BeginTran;
    procedure Commit;
    procedure Rollback;
    function DACConnection: TFDConnection;

    property Connection:TFDConnection  read FMyFDConnection write FMyFDConnection;
  end;

  function Conexao: TFDConexao;

implementation


var ConexaoPrincipal, // prod dese homo
    ConexaoAmbienteAlternativo // homo, quando o principal for prod
    : TFDConexao;

function Conexao: TFDConexao;
begin
  if not Assigned(ConexaoPrincipal) then
    ConexaoPrincipal := TFDConexao.Create;
  Result := ConexaoPrincipal;
end;

{ TFDConexao }

procedure TFDConexao.BeginTran;
begin
  Self.FMyFDConnection.StartTransaction;
end;

procedure TFDConexao.Commit;
begin
  Self.FMyFDConnection.Commit;
end;

constructor TFDConexao.Create;
begin
    //FDManager          := TFDManager.Create(nil);
    FMyFDConnection    := TFDConnection.Create(nil);
    FDPhysFBDriverLink := TFDPhysFBDriverLink.Create(nil);
    Self.setFDConnection(FMyFDConnection);
end;

function TFDConexao.DACConnection: TFDConnection;
begin
  Result := Self.FMyFDConnection;
end;

destructor TFDConexao.Destroy;
begin
  //FDManager.Free;
  FMyFDConnection.Free;
  FDPhysFBDriverLink.Free;
  inherited;
end;



class function TFDConexao.getValueIni(ArqIni: TIniFile; NameCampo: string): string;
begin
  try
    Result := ArqIni.ReadString('FDConnection', NameCampo, Result);
  except
    Result := '';
  end;
end;

procedure TFDConexao.Rollback;
begin
  Self.FMyFDConnection.Rollback;
end;

procedure TFDConexao.setFDConnection(FDConnection: TFDConnection);
var
  ArqIni: TIniFile;
  DB_AMBIENTE, DB_SERVER_URL, DB_PATH, DB_NAME, DB_PASSWORD, DB_CONN_NAME,
  DB_VENDOR_DLL, DB_DRIVE_ID, DB_USER_NAME, CONTAINNER  : string;
  DB_SERVER_PORT : Integer;
  FDScript : TFDScript;
  SQLTEXT : TStringList;
  I, index : Integer;
  DB_EXIST : Boolean;
begin

  DB_CONN_NAME   := 'bd_dac';
  DB_DRIVE_ID    := 'FD';
  DB_VENDOR_DLL  := GetCurrentDir+'\fbembed.dll';
  DB_SERVER_URL  := 'localhost';
  DB_PATH        := GetCurrentDir+'\';
  DB_NAME        := 'SIGES.FDB';
  DB_USER_NAME   := 'sysdba';
  DB_PASSWORD    := 'masterkey';
  DB_SERVER_PORT := 3050;
  DB_AMBIENTE    := 'PROD';

  ArqIni := TIniFile.Create(GetCurrentDir+'\SIGES.ini');

  if not ArqIni.SectionExists('FDConnection') then
  begin
    ArqIni.WriteString('FDConnection','DB_CONN_NAME',DB_CONN_NAME);
    ArqIni.WriteString('FDConnection','DB_DRIVE_ID',DB_DRIVE_ID);
    ArqIni.WriteString('FDConnection','DB_VENDOR_DLL',DB_VENDOR_DLL);
    ArqIni.WriteString('FDConnection','DB_SERVER_URL',DB_SERVER_URL);
    ArqIni.WriteString('FDConnection','DB_PATH',DB_PATH);
    ArqIni.WriteString('FDConnection','DB_NAME',DB_NAME);
    //ArqIni.WriteString('FDConnection','DB_PASSWORD',DB_PASSWORD);
    ArqIni.WriteInteger('FDConnection','DB_SERVER_PORT',DB_SERVER_PORT);
    ArqIni.WriteString('FDConnection','DB_AMBIENTE',DB_AMBIENTE);
    ArqIni.UpdateFile;
  end;



  try

    DB_AMBIENTE := TFDConexao.getValueIni(ArqIni, 'DB_AMBIENTE');

    DB_CONN_NAME   := TFDConexao.getValueIni(ArqIni, 'DB_CONN_NAME');
    DB_DRIVE_ID    := TFDConexao.getValueIni(ArqIni, 'DB_DRIVE_ID');
    DB_VENDOR_DLL  := TFDConexao.getValueIni(ArqIni, 'DB_VENDOR_DLL');
    DB_SERVER_URL  := TFDConexao.getValueIni(ArqIni, 'DB_SERVER_URL');
    DB_PATH        := TFDConexao.getValueIni(ArqIni, 'DB_PATH');
    DB_NAME        := TFDConexao.getValueIni(ArqIni, 'DB_NAME');
    //DB_PASSWORD    := TFDConexao.getValueIni(ArqIni, 'DB_PASSWORD');
    DB_SERVER_PORT := StrToInt(TFDConexao.getValueIni(ArqIni, 'DB_SERVER_PORT'));
    DB_AMBIENTE    := TFDConexao.getValueIni(ArqIni, 'DB_AMBIENTE');

    Self.FDPhysFBDriverLink.Release;
    Self.FDPhysFBDriverLink.DriverID := DB_DRIVE_ID;
    Self.FDPhysFBDriverLink.Embedded := True;
    Self.FDPhysFBDriverLink.VendorLib :=  DB_VENDOR_DLL;

    FDConnection.LoginPrompt := false;
    FDConnection.ResourceOptions.SilentMode := true;
    FDConnection.FetchOptions.AutoFetchAll := afAll;
    FDConnection.FetchOptions.Mode := fmAll;
    FDConnection.TxOptions.AutoCommit := False;


    FDConnection.ConnectionName := DB_CONN_NAME;
    FDConnection.DriverName := DB_DRIVE_ID;
    FDConnection.Params.Clear;
    FDConnection.Params.Add('ResultMode=store');

    DB_EXIST := FileExists(DB_PATH+DB_NAME);

    if not DB_EXIST then
    Begin
      Show_Message('Aguarde, preparando arquivos e banco de dados..',awShow);
      Extract_resource_fb;
    End;

    if DB_AMBIENTE = 'HOMO' then
    begin
      // Para Implementação
    end
    else if DB_AMBIENTE = 'DESE' then
    begin
      // Para Implementação
    end
    else if DB_AMBIENTE = 'PROD' then
    begin
      // Atribui este parametros somente quando o acesso for por tcp
      {
      FDConnection.Params.Add('Server='+DB_SERVER_URL);
      FDConnection.Params.Add('Port='+IntToStr(DB_SERVER_PORT));
      }
      FDConnection.Params.Add('Database='+DB_PATH+DB_NAME);
      FDConnection.Params.Add('User_Name='+DB_USER_NAME);
      FDConnection.Params.Add('DriverID='+DB_DRIVE_ID);
      FDConnection.Params.Add('CharacterSet=utf8');
      if DB_EXIST then
        FDConnection.Params.Add('OpenMode=Open')
      else
        FDConnection.Params.Add('OpenMode=OpenOrCreate');
    end
    else
       raise Exception.Create('Arquivo '+GetCurrentDir+'\SIGES.ini não foi encontrado.');

    FDConnection.Connected := True;

    if not DB_EXIST then
    begin
      try

        FDScript := TFDScript.Create(nil);
        SQLTEXT := TStringList.Create;
        FDScript.Connection := FDConnection;

        SQLTEXT.LoadFromFile(DB_PATH+'scriptdb.sql');

        with FDScript do
        begin

          SQLScripts.Clear;
          SQLScripts.Add;
          with SQLScripts[0].SQL do begin
            for I := 0 to SQLTEXT.Count-1 do
            begin
              Add(SQLTEXT.Strings[I]);
            end;
          end;
          ValidateAll;
          ExecuteAll;
        end;

      finally
        FreeAndNil(FDScript);
        FreeAndNil(SQLTEXT);
        DeleteFile(DB_PATH+'scriptdb.sql');
        Sleep(2000);
        Show_Message('',awClose);
      end;
    end;
  finally
    ArqIni.Free;
  end;
end;

initialization
       TFDConexao.Create;

end.
