unit Model.VariableSystem;

interface

uses Forms, System.SysUtils, Vcl.FileCtrl, System.StrUtils;

type

  TVariableSystem = class(TObject)
  private
    { private declarations }
    function LoadPath(vfPathRoot: string;vf_list_path: array of string): Boolean;
  protected
    { protected declarations }
  public
    { public declarations }
    vgSystemPathRoot : string;
    vgXMLStoragePath : string;
    vgPathPersonal : string;
    function GetSystemPathRoot : string;
    function GetSystemPathExe  : string;
    function GetSystemPathADD  : string;
    function GetSystemPathBIN  : string;
    function GetSystemPathBKP  : string;
    function GetSystemPathBOL  : string;
    function GetSystemPathDBG  : string;
    function GetSystemPathDFE  : string;
    function GetSystemPathDOC  : string;
    function GetSystemPathIMG  : string;
    function GetSystemPathINI  : string;
    function GetSystemPathINT  : string;
    function GetSystemPathLOG  : string;
    function GetSystemPathMOD  : string;
    function GetSystemPathPDF  : string;
    function GetSystemPathPKG  : string;
    function GetSystemPathRPT  : string;
    function GetSystemPathSCP  : string;
    function GetSystemPathSHM  : string;
    function GetSystemPathTMP  : string;
    function GetSystemPathUDP  : string;

    function GetRptPathBOL : string;
    function GetRptPathBPE : string;
    function GetRptPathCTE : string;
    function GetRptPathGNRE : string;
    function GetRptPathMDFE : string;
    function GetRptPathNFE : string;
    function GetRptPathNFSE : string;
    function GetRptPathSAT : string;

    function GetShmPathBPE : string;
    function GetShmPathCTE : string;
    function GetShmPathESOCIAL : string;
    function GetShmPathGNRE : string;
    function GetShmPathMDFE : string;
    function GetShmPathDFe : string;
    function GetShmPathNFSE : string;
    function GetShmPathREINF : string;

    function GetXmlPathANE : string;
    function GetXmlPathBPE : string;
    function GetXmlPathCTE : string;
    function GetXmlPathESOCIAL : string;
    function GetXmlPathGNRE : string;
    function GetXmlPathMDFE : string;
    function GetXmlPathNFCE : string;
    function GetXmlPathDFE : string;
    function GetXmlPathNFSE : string;
    function GetXmlPathREINF : string;
    function GetXmlPathCFE : string;
    function GetFilePathIBGE : string;
    function GetXmlPathDFEDownload : string;
    function GetPdfPathDFE : string;

    function GetPdfPathBOL(vfCodBanco:String) : string;
    function GetRemPathBOL(vfCodBanco:String) : string;
    function GetRetPathBOL(vfCodBanco:String) : string;
    function GetIniPathDFESERVICES : string;
    function GetIniPathReinf : string;
    function GetIniPathNFSE : string;

    function CheckPathIsOnline:Boolean;
    function GetXMLStoragePath : string;
    function GetXMLStoragePathDownload : string;

    procedure SetPathPersonal;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TVariableSystem }

function TVariableSystem.CheckPathIsOnline: Boolean;
begin

end;

constructor TVariableSystem.Create;
begin
  vgSystemPathRoot  :=  Self.GetSystemPathRoot;
  vgXMLStoragePath  := '';
end;

destructor TVariableSystem.Destroy;
begin

  inherited;
end;

function TVariableSystem.GetSystemPathADD: string;
begin
  Result := Self.vgSystemPathRoot+'\ADD\'
end;

function TVariableSystem.GetSystemPathDBG: string;
begin
  Result := Self.vgSystemPathRoot+'\DBG\'
end;

function TVariableSystem.GetSystemPathDFE: string;
var vlCaminho : string;
begin
  vlCaminho := ifthen(Self.vgXMLStoragePath = '', Self.vgSystemPathRoot, Self.vgXMLStoragePath);
  Result := vlCaminho +'\DFE\'+vgPathPERSONAL+'\';
end;

function TVariableSystem.GetSystemPathDOC: string;
begin
Result := Self.vgSystemPathRoot+'\DOC\'
end;

function TVariableSystem.GetXmlPathANE: string;
begin
  Result := Self.GetSystemPathDFE;//+'ANe\';
end;

function TVariableSystem.GetXmlPathBPE: string;
begin
  Result := Self.GetSystemPathDFE;//+'BPe\';
end;

function TVariableSystem.GetXmlPathCFE: string;
begin
  Result := Self.GetSystemPathDFE;//+'CFe\';
end;

function TVariableSystem.GetXmlPathCTE: string;
begin
  Result := Self.GetSystemPathDFE;//+'CTe\';
end;

function TVariableSystem.GetXmlPathESOCIAL: string;
begin
  Result := Self.GetSystemPathDFE;//+'eSocial\';
end;

function TVariableSystem.GetXmlPathGNRE: string;
begin
  Result := Self.GetSystemPathDFE;//+'GNRe\';
end;

function TVariableSystem.GetFilePathIBGE: string;
begin
  Result := Self.GetSystemPathADD+'IBGE\';
end;

function TVariableSystem.GetXmlPathMDFE: string;
begin
  Result := Self.GetSystemPathDFE;//+'MDFe\';
end;

function TVariableSystem.GetXmlPathNFCE: string;
begin
  Result := Self.GetSystemPathDFE;//+'NFCe\';
end;

function TVariableSystem.GetXmlPathDFE: string;
begin
  Result := Self.GetSystemPathDFE;//+'NFe\';
end;

function TVariableSystem.GetXmlPathDFEDownload: string;
begin
  Result := Self.GetSystemPathDFE+'DOWNLOAD\';
end;

function TVariableSystem.GetXmlPathNFSE: string;
begin
  Result := Self.GetSystemPathDFE;//+'NFSe\';
end;

function TVariableSystem.GetXmlPathREINF: string;
begin
  Result := Self.GetSystemPathDFE;//+'Reinf\';
end;

function TVariableSystem.GetSystemPathBIN: string;
begin
  Result := Self.vgSystemPathRoot+'\BIN\';
end;


function TVariableSystem.GetSystemPathBKP: string;
begin
   Result := Self.vgSystemPathRoot+'\BKP\';
end;

function TVariableSystem.GetSystemPathBOL: string;
begin
  Result := Self.vgSystemPathRoot+'\BOL\'+vgPathPERSONAL+'\';
end;

function TVariableSystem.GetPdfPathBOL(vfCodBanco: String): string;
begin
  Result :=  Self.GetSystemPathBOL+vfCodBanco+'\PDF\';
end;

function TVariableSystem.GetPdfPathDFE: string;
begin
   Result := Self.GetSystemPathDFE+'DFE\';
end;

function TVariableSystem.GetRemPathBOL(vfCodBanco: String): string;
begin
  Result :=  Self.GetSystemPathBOL+vfCodBanco+'\REM\';
end;

function TVariableSystem.GetRetPathBOL(vfCodBanco: String): string;
begin
  Result :=  Self.GetSystemPathBOL+vfCodBanco+'\RET\';
end;

function TVariableSystem.GetIniPathDFESERVICES: string;
begin
   Result := Self.vgSystemPathRoot+'\INI\DFe\Services\';
end;

function TVariableSystem.GetSystemPathIMG: string;
begin
  Result := Self.vgSystemPathRoot+'\IMG\';
end;

function TVariableSystem.GetIniPathNFSE: string;
begin
  Result := Self.vgSystemPathRoot+'\INI\DFe\NFSe\';
end;

function TVariableSystem.GetIniPathReinf: string;
begin
  Result := Self.vgSystemPathRoot+'\INI\DFe\Reinf\';
end;

function TVariableSystem.GetSystemPathINI: string;
begin
  Result := Self.vgSystemPathRoot+'\INI\'
end;

function TVariableSystem.GetSystemPathINT: string;
begin
  Result := Self.vgSystemPathRoot+'\INT\';
end;

function TVariableSystem.GetSystemPathLOG: string;
begin
  Result := Self.vgSystemPathRoot+'\LOG\';
end;

function TVariableSystem.GetSystemPathMOD: string;
begin
Result := Self.vgSystemPathRoot+'\MOD\'
end;

function TVariableSystem.GetSystemPathPDF: string;
begin
  Result := Self.vgSystemPathRoot+'\PDF\';
end;

function TVariableSystem.GetSystemPathPKG: string;
begin
  Result := Self.vgSystemPathRoot+'\PKG\'
end;

function TVariableSystem.GetSystemPathExe: string;
begin
  Result := ExtractFilePath(Application.ExeName);
end;

function TVariableSystem.GetSystemPathRPT: string;
begin
  Result := Self.vgSystemPathRoot+'\RPT\';
end;

function TVariableSystem.GetRptPathBOL: string;
begin
  Result := Self.GetSystemPathRPT+'Boleto\';
end;

function TVariableSystem.GetRptPathBPE: string;
begin
  Result := Self.GetSystemPathRPT+'BPe\';
end;

function TVariableSystem.GetRptPathCTE: string;
begin
  Result := Self.GetSystemPathRPT+'CTe\';
end;

function TVariableSystem.GetRptPathGNRE: string;
begin
  Result := Self.GetSystemPathRPT+'GNRE\';
end;

function TVariableSystem.GetRptPathMDFE: string;
begin
  Result := Self.GetSystemPathRPT+'MDFe\';
end;

function TVariableSystem.GetRptPathNFE: string;
begin
  Result := Self.GetSystemPathRPT+'NFe\';
end;

function TVariableSystem.GetRptPathNFSE: string;
begin
  Result := Self.GetSystemPathRPT+'NFSe\';
end;

function TVariableSystem.GetRptPathSAT: string;
begin
  Result := Self.GetSystemPathRPT+'SAT\';
end;

function TVariableSystem.GetSystemPathSCP: string;
begin
  Result := Self.vgSystemPathRoot+'\SCP\';
end;

function TVariableSystem.GetSystemPathSHM: string;
begin
  Result := Self.vgSystemPathRoot+'\SHM\Schemas\';
end;

function TVariableSystem.GetShmPathBPE: string;
begin
  Result := Self.GetSystemPathSHM+'BPe\';
end;

function TVariableSystem.GetShmPathCTE: string;
begin
  Result := Self.GetSystemPathSHM+'CTe\';
end;

function TVariableSystem.GetShmPathESOCIAL: string;
begin
  Result := Self.GetSystemPathSHM+'eSocial\';
end;

function TVariableSystem.GetShmPathGNRE: string;
begin
  Result := Self.GetSystemPathSHM+'GNRe\';
end;

function TVariableSystem.GetShmPathMDFE: string;
begin
  Result := Self.GetSystemPathSHM+'MDFe\';
end;

function TVariableSystem.GetShmPathDFe: string;
begin
  Result := Self.GetSystemPathSHM+'NFe\';
end;

function TVariableSystem.GetShmPathNFSE: string;
begin
  Result := Self.GetSystemPathSHM+'NFSe\';
end;

function TVariableSystem.GetShmPathREINF: string;
begin
  Result := Self.GetSystemPathSHM+'Reinf\';
end;

function TVariableSystem.GetSystemPathTMP: string;
begin
  Result := Self.vgSystemPathRoot+'\TMP\';
end;

function TVariableSystem.GetSystemPathUDP: string;
begin
  Result := Self.vgSystemPathRoot+'\UDP\';
end;

function TVariableSystem.GetSystemPathRoot: string;
begin
   Result := StringReplace(UpperCase(Self.GetSystemPathExe),'\BIN\','',[]);
end;

function TVariableSystem.GetXMLStoragePath: string;
var
  Pasta : String;
begin
  Pasta := '';
  SelectDirectory('Selecione um Diretório','',  Pasta);
  if (Trim(Pasta) <> '') then
  begin
    if (Pasta[Length(Pasta)] = '\') then
      Pasta := Copy(Pasta,0,Length(Pasta)-1);
      //Pasta := Pasta+'\';
      vgXMLStoragePath := Pasta;
      Self.GetSystemPathDFE;
    {PathSchemas           := Self.GetPathSchemasDFe;
    PathNFe               := Self.GetPathFileXmlDFe;
    PathInu               := Self.GetPathFileXmlDFe;
    PathEvento            := Self.GetPathFileXmlDFe;}
  end;

  Result := Pasta;
end;

function TVariableSystem.GetXMLStoragePathDownload: string;
var
  Pasta : String;
begin
  Pasta := '';
  SelectDirectory('Selecione um Diretório Para o Download Das DFEs','',  Pasta);
  if (Trim(Pasta) <> '') then
  begin
    if (Pasta[Length(Pasta)] = '\') then
      Pasta := Copy(Pasta,0,Length(Pasta)-1);
      //Pasta := Pasta+'\';
      vgXMLStoragePath := Pasta;
      Self.GetSystemPathDFE;
    {PathSchemas           := Self.GetPathSchemasDFe;
    PathNFe               := Self.GetPathFileXmlDFe;
    PathInu               := Self.GetPathFileXmlDFe;
    PathEvento            := Self.GetPathFileXmlDFe;}
  end;

  Result := Pasta;
end;

function TVariableSystem.LoadPath(vfPathRoot: string;
  vf_list_path: array of string): Boolean;
var vl_numpaths : Integer;
    vl_1: Integer;
    vl_paths, vl_pathroot : string;
begin
  vl_numpaths := Length(vf_list_path);
  for vl_1 := 0 to vl_numpaths-1 do
  begin
    if not DirectoryExists(vfPathRoot+vf_list_path[vl_1]) then
     ForceDirectories(vfPathRoot+vf_list_path[vl_1]);
  end;
end;

procedure TVariableSystem.SetPathPersonal;
var vlDFEPersonal, vlBOLPersonal, vlCODBANCO, vlDFEPath : string;
  I,X: Integer;
begin
  vlDFEPersonal := '\DFE\'+vgPathPERSONAL;
  vlBOLPersonal := '\BOL\'+vgPathPERSONAL;

  LoadPath(Self.GetSystemPathRoot, [vlDFEPersonal,vlBOLPersonal]);

  for I := 0 to 5 do
  begin
    case I of
      0 : vlCODBANCO := '001';
      1 : vlCODBANCO := '033';
      2 : vlCODBANCO := '104';
      3 : vlCODBANCO := '237';
      4 : vlCODBANCO := '341';
      5 : vlCODBANCO := '756';
    end;

    LoadPath(Self.GetSystemPathRoot, [vlBOLPersonal+'\'+vlCODBANCO+'\PDF',
                               vlBOLPersonal+'\'+vlCODBANCO+'\REM',
                               vlBOLPersonal+'\'+vlCODBANCO+'\RET'
                              ]);
  end;

  {for X := 0 to 10 do
  begin
    case X of
      0 : vlDFEPath := 'ANe';
      1 : vlDFEPath := 'BPe';
      2 : vlDFEPath := 'CTe';
      3 : vlDFEPath := 'eSocial';
      4 : vlDFEPath := 'GNRe';
      5 : vlDFEPath := 'MDFe';
      6 : vlDFEPath := 'NFCe';
      7 : vlDFEPath := 'NFe';
      8 : vlDFEPath := 'NFSe';
      9 : vlDFEPath := 'Reinf';
      10 : vlDFEPath := 'CFe';
    end;

    LoadPath(Self.GetSystemPathRoot, [vlDFEPersonal+'\'+vlDFEPath]);
  end;}

end;

end.
