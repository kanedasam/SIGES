unit Controler.Functions;

interface

uses
  Windows, SysUtils, Classes, Forms, Messages, stdctrls,
  Dialogs, dbctrls, Variants, Db, Registry, Graphics, Mask, ComCtrls, Grids,
  DBGrids, Math, StrUtils,ImgList, PngImage, Controls,
  ShellAPI, IdSNTP, WiniNet, DateUtils,
  mshtml, ActiveX, ComObj, TlHelp32, jpeg, Vcl.Clipbrd,
  Rtti, Model.TypedGeral, System.Zip, System.Net.HttpClient, View.FrmStatus,
  System.Generics.Collections, FireDAC.Comp.Client, Model.ConstantsGerais;

type
  HttpCli1RequestDone = procedure(Sender: TObject; RqType: THttpRequest; Error: Word);

  {TListMnemonicos = class
    Ref : TRefMnemonicos;
  end;}

function close_form(vf_form_app: TForm): Boolean;

function close_tables(vf_form_app: TForm; vf_act_save: Boolean): Boolean;

function before_check_tables(vf_form_app: TForm): Boolean;

function StringToWideString(const s: AnsiString; codePage: Word): WideString;

function valida_email(const Email: string): Boolean;

function file_ext(vf_file: string): Integer;

function image_file(vf_num_ext: Integer): string;

function addpng(ImageList: TImageList; target_file_img: string): Integer;

procedure str_to_file(text_str, full_path_file: string);

function return_datetime_internet(const Servidor: string): string;

function status_wan_conection: Boolean;

function saudacao_time(): string;

procedure Show_Message(msn: string; action_window: TActionWindow);

function del_dir_recursivel(FullPath: string): Boolean;

function return_zip_file(vp_list_file: TStringlist; vp_ziped_file: string): string;

procedure CreatForm(Form_State: TForm_State; Type_Style: TForm_Style; TClassNameForm: TComponentClass; NameForm: TForm; Rotina: string);

function varrec_str(AVarRec: TVarRec): string;

function win_exec_wait(const Path: PChar; const Visibility: Word; const Wait: Boolean): Boolean;

function get_file_size(vf_file: string): string;

function get_drive_exist(LetrDrive: string): Boolean;

function get_type_drive(LetraDrive: string): TypeDrive;

function replace_caracter_esp(aTexto: string; aLimExt: boolean): string;

function break_String(input: string; separador: Char): TStringList;

function get_mac_address(): string;

procedure SwapTabToEnter(var Msg: TMsg; var Handled: Boolean);

//////////////////////////////////////////////////////////////////////////////////////

function IntegerToTipado(out ok: boolean; const s: Integer; const AIntegering: array of Integer; const ATipados: array of variant): variant;

function TipadoToInteger(const t: variant; const AIntegering: array of Integer; const ATipados: array of variant): variant;

function VarianteToStr(AVarRec: TVarRec): string;

//////////////////////////////////////////////////////////////////////////////////////

function WinVersion: string;

function get_var_system(const VarName: string): string;

function Calcula_Pascoa(AAno: Word): TDateTime;

function Str_to_Hex_Zebra(S: String): String;

function parse_html_txt(vf_content : TStrings; vf_out: string):  AnsiString;

function ProcessExists(exeFileName: string): Integer;

function RunAsAdmin(const Handle: Hwnd; const Path, Params: string): Boolean;

function GetPrintActivityWindow(vf_prefix:string) : string;

function AplicarMnemonicos(Texto:string;Param: TList<TRefMnemonicos>;Data: TFDQuery = nil): string;

procedure AddMnemonicos(Lista:TList<TRefMnemonicos>;MnemonicoTipado:TMnemonicos;FieldName:string); overload;

procedure AddMnemonicos(Lista:TList<TRefMnemonicos>;MnemonicoTipado:TMnemonicos;Texto:string;Variaveis:TArrTexto;Valores:TArrTexto); overload;

procedure AddMnemonicos(Lista:TList<TRefMnemonicos>;MnemonicoTipado:TMnemonicos;Formatar:Boolean;Valor:Variant); overload;

procedure Extract_resource_fb;

function CharIsNum(const C: Char): Boolean;

function OnlyNumber(const AValue: String): String;

function ValidaCnpjCeiCpf(Numero: String; ExibeMsgErro: Boolean=True): Boolean;

function FormataDocumento(doc : string) :string;

function ValidarEMail(aStr: string): Boolean;

implementation


function close_tables(vf_form_app: TForm; vf_act_save: Boolean): Boolean;
var
  vl_x, vl_i: integer;
  vl_class_ref: TClass;
begin
  vl_x := vf_form_app.ComponentCount;
  try
    try
      for vl_i := 0 to vl_x - 1 do
      begin

        vl_class_ref := vf_form_app.Components[vl_i].ClassType;

        while vl_class_ref <> nil do
        begin
          if vl_class_ref = TDataSet then
          begin
            if TDataSet(vf_form_app.Components[vl_i]).State in [dsEdit, dsInsert] then
            begin
              if vf_act_save then
                TDataSet(vf_form_app.Components[vl_i]).Post
              else
                TDataSet(vf_form_app.Components[vl_i]).Cancel;
              TDataSet(vf_form_app.Components[vl_i]).Close;
            end;
          end;
          vl_class_ref := vl_class_ref.ClassParent;
        end;

      end;
    except
      Result := False;
      abort;
    end;
  finally
    Result := True;
  end;
end;

function before_check_tables(vf_form_app: TForm): Boolean;
var
  vl_x, vl_i: integer;
  vl_class_ref: TClass;
begin
  Result := False;
  vl_x := vf_form_app.ComponentCount;
  for vl_i := 0 to vl_x - 1 do
  begin
    vl_class_ref := vf_form_app.Components[vl_i].ClassType;

    while vl_class_ref <> nil do
    begin
      if vl_class_ref = TDataSet then
      begin
        if TDataSet(vf_form_app.Components[vl_i]).State in [dsEdit, dsInsert] then
        begin
          Result := True;
        end;
      end;
      vl_class_ref := vl_class_ref.ClassParent;
    end;
  end;
end;

function close_form(vf_form_app: TForm): Boolean;
begin
  if before_check_tables(vf_form_app) then
  begin

    if Application.MessageBox('Existe dados que não foram gravados e que ' + #13 + 'podem ser perdidos. Deseja gravar ?', 'ATENÇÃO !!!!', MB_YESNOCANCEL + MB_ICONINFORMATION) = IDYES then
    begin
      if close_tables(vf_form_app, True) then
      begin
        Result := True;
      end
      else
      begin
        Result := True;
        ShowMessage('Não foi possivel salvar os dados.');
      end;
    end
    else
    begin
      if close_tables(vf_form_app, False) then
      begin
        Result := True;
      end
      else
      begin
        ShowMessage('Não foi possivel salvar os dados.');
      end;

    end;
  end
  else
  begin
    Result := True;
  end;
end;

function StringToWideString(const s: AnsiString; codePage: Word): WideString;
var
  l: integer;
begin
  if s = '' then
    Result := ''
  else
  begin
    l := MultiByteToWideChar(codePage, MB_PRECOMPOSED, PAnsiChar(@s[1]), -1, nil, 0);
    SetLength(Result, l - 1);
    if l > 1 then
      MultiByteToWideChar(codePage, MB_PRECOMPOSED, PAnsiChar(@s[1]), -1, PWideChar(@Result[1]), l - 1);
  end;
end;

function valida_email(const Email: string): Boolean;
const
  InvalidChar = 'àâêôûãõáéíóúçüñýÀÂÊÔÛÃÕÁÉÍÓÚÇÜÑÝ*;:⁄\|#$%&*§!()][{}<>˜ˆ´ªº+¹²³';
var
  I: Integer;
  C: Integer;
begin
  // Não existe email com menos de 8 caracteres.
  if Length(Email) < 8 then
  begin
    Result := False;
    Exit;
  end;

  // Verificando se há somente um @
  if ((Pos('@', Email) = 0) or (PosEx('@', Email, Pos('@', Email) + 1) > 0)) then
  begin
    Result := False;
    Exit;
  end;

  // Verificando se no m�nimo há um ponto
  if (Pos('.', Email) = 0) then
  begin
    Result := False;
    Exit;
  end;

  // Não pode começar ou terminar com @ ou ponto
  if (Email[1] in ['@', '.']) or (Email[Length(Email)] in ['@', '.']) then
  begin
    Result := False;
    Exit;
  end;

  // O @ e o ponto não podem estar juntos
  if (Email[Pos('@', Email) + 1] = '.') or (Email[Pos('@', Email) - 1] = '.') then
  begin
    Result := False;
    Exit;
  end;

  // Testa se tem algum caracter inválido.
  for I := 1 to Length(Email) do
  begin
    for C := 0 to Length(InvalidChar) do
      if (Email[I] = InvalidChar[C]) then
      begin
        Result := False;
        Exit;
      end;
  end;

  // Se não encontrou problemas, retorna verdadeiro
  Result := True;

end;

function file_ext(vf_file: string): Integer;
begin
  Result := 0;
  //ShowMessage(UpperCase(ExtractFileExt(vf_file)));
  if UpperCase(ExtractFileExt(vf_file)) = '.AS' then
    Result := 1;
  if UpperCase(ExtractFileExt(vf_file)) = '.BLANC' then
    Result := 2;
  if UpperCase(ExtractFileExt(vf_file)) = '.CSS' then
    Result := 3;

  if (UpperCase(ExtractFileExt(vf_file)) = '.DOC') or (UpperCase(ExtractFileExt(vf_file)) = '.DOCX') then
    Result := 4;

  if UpperCase(ExtractFileExt(vf_file)) = '.HTML' then
    Result := 5;

  if (UpperCase(ExtractFileExt(vf_file)) = '.PNG') or (UpperCase(ExtractFileExt(vf_file)) = '.BMP') or (UpperCase(ExtractFileExt(vf_file)) = '.JPEG') or (UpperCase(ExtractFileExt(vf_file)) = '.JPG') then
    Result := 6;

  if UpperCase(ExtractFileExt(vf_file)) = '.JS' then
    Result := 7;
  if UpperCase(ExtractFileExt(vf_file)) = '.PDF' then
    Result := 8;
  if UpperCase(ExtractFileExt(vf_file)) = '.PHP' then
    Result := 9;
  if UpperCase(ExtractFileExt(vf_file)) = '.RTF' then
    Result := 10;
  if UpperCase(ExtractFileExt(vf_file)) = '.SQL' then
    Result := 11;
  if UpperCase(ExtractFileExt(vf_file)) = '.TXT' then
    Result := 12;

  if (UpperCase(ExtractFileExt(vf_file)) = '.AVI') or (UpperCase(ExtractFileExt(vf_file)) = '.MPEG') or (UpperCase(ExtractFileExt(vf_file)) = '.DIVX') or (UpperCase(ExtractFileExt(vf_file)) = '.MP4') or (UpperCase(ExtractFileExt(vf_file)) = '.MOV') or (UpperCase(ExtractFileExt(vf_file)) = '.MPG') then
    Result := 13;

  if (UpperCase(ExtractFileExt(vf_file)) = '.XLS') or (UpperCase(ExtractFileExt(vf_file)) = '.XLSX') then
    Result := 14;

  if UpperCase(ExtractFileExt(vf_file)) = '.XML' then
    Result := 15;

end;

function image_file(vf_num_ext: Integer): string;
begin
  case vf_num_ext of
    0:
      Result := 'blanc.png';
    1:
      Result := 'as.png';
    2:
      Result := 'blanc.png';
    3:
      Result := 'css.png';
    4:
      Result := 'doc.png';
    5:
      Result := 'html.png';
    6:
      Result := 'image.png';
    7:
      Result := 'js.png';
    8:
      Result := 'pdf.png';
    9:
      Result := 'php.png';
    10:
      Result := 'rtf.png';
    11:
      Result := 'sql.png';
    12:
      Result := 'txt.png';
    13:
      Result := 'video.png';
    14:
      Result := 'xls.png';
    15:
      Result := 'xml.png';
  end;

end;

function addpng(ImageList: TImageList; target_file_img: string): Integer;
var
  Png: TPngImage;
  Bitmap: TBitmap;
begin

  Png := nil;
  Bitmap := nil;
  try
    Png := TPngImage.Create;
    Png.LoadFromFile(target_file_img);
    //FreeAndNil(ResStream);
    Bitmap := TBitmap.Create;
    Bitmap.Assign(Png);
    FreeAndNil(Png);
    Result := ImageList.Add(Bitmap, nil);
  finally
    Bitmap.Free;
    //ResStream.Free;
    Png.Free;
  end;
end;

procedure str_to_file(text_str, full_path_file: string);
var
  zText: TStringlist;
begin
  zText := TStringlist.create;
  try
    zText.Add(text_str);
    zText.SaveToFile(full_path_file);
  finally
    zText.Free
  end; {try}
end;
function return_datetime_internet(const Servidor: string): string;
var
  SNTP: TIdSNTP;
begin
  SNTP := TIdSNTP.Create(nil);
  try
    SNTP.Host := Servidor;
    Result := DateTimeToStr(SNTP.DateTime);
  finally
    SNTP.Disconnect;
    SNTP.Free;
  end;
end;

function status_wan_conection: Boolean;
var
  estado: Dword;
begin
  if not InternetGetConnectedState(@estado, 0) then
    Result := False
  else
  begin
    if (estado and INTERNET_CONNECTION_LAN <> 0) or (estado and INTERNET_CONNECTION_MODEM <> 0) or (estado and INTERNET_CONNECTION_PROXY <> 0) then
      Result := True;

  end;
end;

function saudacao_time(): string;
var
  i: integer;
  vl_comp: string;
begin
  i := Trunc(time * 24);
  case i of
    0..6:
      vl_comp := 'Boa Madrugada';
    7..12:
      vl_comp := 'Bom Dia';
    13..18:
      vl_comp := 'Boa Tarde';
  else
    vl_comp := 'Boa Noite';
  end;
  Result := vl_comp;
end;


procedure Show_Message(msn: string; action_window: TActionWindow);
begin
  if (action_window = awShow) then
  begin
    Application.MainFormOnTaskbar := True;
    if (frmStatusMsm = nil) then
       frmStatusMsm := TfrmStatusMsm.Create(Application);

    frmStatusMsm.lblStatus.Caption := msn;
    frmStatusMsm.Show;
    frmStatusMsm.BringToFront;
    frmStatusMsm.Refresh;
    frmStatusMsm.Repaint;
    frmStatusMsm.FormStyle := fsStayOnTop;
  end
  else
  begin
    Application.MainFormOnTaskbar := False;
    if (frmStatusMsm <> nil) then
    begin
      frmStatusMsm.Hide;
      frmStatusMsm.Close;
      Freeandnil(frmStatusMsm);
    end;
  end;
end;

function del_dir_recursivel(FullPath: string): Boolean;
var
  sr: TSearchRec;
  FullName: string;
begin
  Result := True;
  if (FindFirst(FullPath + '*.*', faAnyFile, sr) = 0) then
  try
    repeat
      FullName := IncludeTrailingPathDelimiter(FullPath) + sr.Name;
      if (sr.Name <> '.') and (sr.Name <> '..') then
      begin
        if ((sr.Attr and faDirectory) = 0) then
          Result := DeleteFile(FullName)
        else
          Result := del_dir_recursivel(FullName);
      end;
    until (FindNext(sr) <> 0) or not Result;
  finally
    FindClose(sr);
  end;
  Result := Result and DirectoryExists(FullPath); // and RemoveDir(FullPath);
end;

function return_zip_file(vp_list_file: TStringlist; vp_ziped_file: string): string;
var
  i: integer;
  ZipFile: TZipFile;
  vf_no_file_inclued, FileName: string;
begin

  ZipFile := TZipFile.Create;

  with ZipFile do
  begin
    // Aqui vem o codigo
    //Result := FileName;
    //CloseArchive;
  end;

  ZipFile.Destroy;
  ZipFile := nil;

end;

procedure CreatForm(Form_State: TForm_State; Type_Style: TForm_Style; TClassNameForm: TComponentClass; NameForm: TForm; Rotina: string);
var
  i: integer;
begin
  try
    try
      try

        Application.CreateForm(TClassNameForm, NameForm);
        with NameForm do
        begin
          // Configura o comportamento da janela
          case Type_Style of
            fswNormal:
              FormStyle := fsNormal;
            fswMDIChild:
              FormStyle := fsMDIChild;
            fswMDIForm:
              FormStyle := fsMDIForm;
            fswStayOnTop:
              FormStyle := fsStayOnTop;
          end;
          // Configura o comportamento da janela
          case Form_State of
            fsModal   : ShowModal;
            fsNoModal : Show;
          end;

        end;

      except
        on e: SysUtils.Exception do
          ShowMessage('Não foi possivel abrir o formulário : ' + e.message);
      end;
    finally
      // NameForm.Close;
      NameForm := nil;
      Freeandnil(NameForm);
    end;

  except
    NameForm := nil;
    Freeandnil(NameForm);
  end;
end;

function varrec_str(AVarRec: TVarRec): string;
const
  Bool: array[Boolean] of string = ('False', 'True');
var
  basicType: Integer;
begin
  case AVarRec.VType of
    vtInteger:
      Result := IntToStr(AVarRec.VInteger);
    vtBoolean:
      Result := Bool[AVarRec.VBoolean];
    vtChar:
      Result := QuotedStr(AVarRec.VChar);
    vtExtended:
      Result := FloatToStr(AVarRec.VExtended^);
    vtString:
      Result := QuotedStr(AVarRec.VString^);
    vtPChar:
      Result := QuotedStr(AVarRec.VPChar);
    vtObject:
      Result := AVarRec.VObject.ClassName;
    vtClass:
      Result := AVarRec.VClass.ClassName;
    vtWideChar:
      Result := QuotedStr(string(AVarRec.VWideChar));
    vtAnsiString:
      Result := QuotedStr(string(AVarRec.VAnsiString));
    vtCurrency:
      Result := CurrToStr(AVarRec.VCurrency^);
    //vtVariant:    Result := QuotedStr(string(AVarRec.VVariant^));
    vtVariant:
      begin

        basicType := VarType(AVarRec.VType) and VarTypeMask;

        case basicType of
          varEmpty:
            Result := QuotedStr(string(AVarRec.VVariant^));
          varNull:
            Result := QuotedStr('');
          varSmallInt:
            Result := IntToStr(Integer(AVarRec.VVariant^));
          varInteger:
            Result := IntToStr(Integer(AVarRec.VVariant^));
          varSingle:
            Result := IntToStr(Integer(AVarRec.VVariant^));
          varDouble:
            Result := FloatToStr(double(AVarRec.VVariant^));
          varCurrency:
            Result := CurrToStr(Currency(AVarRec.VVariant^));
          varDate:
            Result := DateToStr(TDateTime(AVarRec.VVariant^));
          varOleStr:
            Result := QuotedStr(string(AVarRec.VVariant^));
          varBoolean:
            Result := Bool[Boolean(AVarRec.VVariant^)];
          varVariant:
            Result := QuotedStr(string(AVarRec.VVariant^));
          varUnknown:
            Result := QuotedStr(string(AVarRec.VVariant^));
          varByte:
            Result := IntToStr(Integer(AVarRec.VVariant^));
          varWord:
            Result := QuotedStr(string(AVarRec.VVariant^));
          varLongWord:
            Result := QuotedStr(string(AVarRec.VVariant^));
          varInt64:
            Result := IntToStr(Integer(AVarRec.VVariant^));
          varStrArg:
            Result := QuotedStr(string(AVarRec.VVariant^));
          varString:
            Result := QuotedStr(string(AVarRec.VVariant^));
          varUString:
            Result := QuotedStr(string(AVarRec.VVariant^));
        end;
      end;
    vtPWideChar:
      Result := QuotedStr(string(AVarRec.VPWideChar));
    vtUnicodeString:
      Result := QuotedStr(string(AVarRec.VUnicodeString));
    vtWideString:
      Result := QuotedStr(string(AVarRec.VWideString));
  else
    // result := '';
    Result := QuotedStr(string(AVarRec.VPChar));
  end;
end;

function sefaz_round_to5(Valor: Double; Casas: Integer): Double;
var
  xValor, xDecimais: string;
  p, nCasas: Integer;
  nValor: Double;
begin
  nValor := Valor;
  xValor := Trim(FloatToStr(Valor));
  p := pos(',', xValor);
  if Casas < 0 then
    nCasas := -Casas
  else
    nCasas := Casas;
  if p > 0 then
  begin
    xDecimais := Copy(xValor, p + 1, length(xValor));
    if length(xDecimais) > nCasas then
    begin
      if xDecimais[nCasas + 1] >= '5' then
        SetRoundMode(rmUP)
      else
        SetRoundMode(rmNearest);
    end;
    nValor := RoundTo(Valor, Casas);
  end;
  Result := nValor;
end;

function win_exec_wait(const Path: PChar; const Visibility: Word; const Wait: Boolean): Boolean;
var
  ProcessInformation: TProcessInformation;
  StartupInfo: TStartupInfo;
begin
  FillChar(StartupInfo, SizeOf(TStartupInfo), 0);
  with StartupInfo do
  begin
    cb := SizeOf(TStartupInfo);
    lpReserved := NIL;
    lpDesktop := NIL;
    lpTitle := NIL;
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := Visibility;
    cbReserved2 := 0;
    lpReserved2 := NIL
  end;

  result := CreateProcess(NIL,       {address of module name}
    Path,      {address of command line}
    NIL,       {address of process security attributes}
    NIL,       {address of thread security attributes}
    FALSE,     {new process inherits handle}
    NORMAL_PRIORITY_CLASS,   {creation flags}
    NIL,       {address of new environment block}
    NIL,       {address of current directory name}
    StartupInfo, ProcessInformation);
  if Result then
  begin
    with ProcessInformation do
    begin
      if Wait then
        WaitForSingleObject(hProcess, INFINITE);
      CloseHandle(hThread);
      CloseHandle(hProcess)
    end;
  end;
end;

function get_file_size(vf_file: string): string;
const
  B = 1; // Byte
  KB = 1024 * B;  // Kilobyte
  MB = 1024 * KB; // Megabyte
  GB = 1024 * MB; // Gigabyte
var
  ProcurarArquivo: TSearchRec;
  TamanhoArquivo: Longint;

begin


    //*** Pega o tamanho do arquivo em "Bytes" que você selecionou...
  if FindFirst(vf_file, FaAnyFile, ProcurarArquivo) = 0 then
  begin
    TamanhoArquivo := Int64(ProcurarArquivo.FindData.nFileSizeHigh) shl Int64(32) +
                      Int64(ProcurarArquivo.FindData.nFileSizeLow);
  end;

    //*** Veirifica se o tamanho total do arquivo é em: B, KB, MB ou GB...
  if TamanhoArquivo > GB then
    result := FormatFloat('###,###,##0 GB', TamanhoArquivo / GB)
  else if TamanhoArquivo > MB then
    result := FormatFloat('###,###,##0 MB', TamanhoArquivo / MB)
  else if TamanhoArquivo > KB then
    result := FormatFloat('###,###,##0 KB', TamanhoArquivo / KB)
  else
    result := FormatFloat('###,###,##0 bytes', TamanhoArquivo);

end;

function get_type_drive(LetraDrive: string): TypeDrive;
begin
  case GetDriveType(PChar(LetraDrive + ':\')) of
    DRIVE_REMOVABLE:
      Result := tdRemovivel;
    DRIVE_FIXED:
      Result := tdFixo;
    DRIVE_REMOTE:
      Result := tdRemovivel;
    DRIVE_CDROM:
      Result := tdCDROM;
    DRIVE_RAMDISK:
      Result := tdRAMDISK;
  else //DRIVE_NO_ROOT_DIR :
    Result := tdNenhum;
  end;
end;

function get_drive_exist(LetrDrive: string): Boolean;
begin
  Result := get_type_drive(LetrDrive) <> tdNenhum;
end;

function replace_caracter_esp(aTexto: string; aLimExt: boolean): string;
const
  //Lista de caracteres especiais
  xCarEsp: array[1..38] of string = ('á', 'à', 'ã', 'â', 'ä', 'Á', 'À', 'Ã', 'Â', 'Ä', 'é', 'è', 'É', 'È', 'í', 'ì', 'Í', 'Ì', 'ó', 'ò', 'ö', 'õ', 'ô', 'Ó', 'Ò', 'Ö', 'Õ', 'Ô', 'ú', 'ù', 'ü', 'Ú', 'Ù', 'Ü', 'ç', 'Ç', 'ñ', 'Ñ');
  //Lista de caracteres para troca
  xCarTro: array[1..38] of string = ('a', 'a', 'a', 'a', 'a', 'A', 'A', 'A', 'A', 'A', 'e', 'e', 'E', 'E', 'i', 'i', 'I', 'I', 'o', 'o', 'o', 'o', 'o', 'O', 'O', 'O', 'O', 'O', 'u', 'u', 'u', 'u', 'u', 'u', 'c', 'C', 'n', 'N');
  //Lista de Caracteres Extras
  xCarExt: array[1..18] of string =(//'<','>','!','@','#','$','%','¨','&','*',
                                     //'(',')','_','+','=','{','}','[',']','?',
                                     //';',':',',','|','*','"','~','^','´','`',
    '¨', 'æ', 'Æ', 'ø', '£', 'Ø', 'ƒ', 'ª', 'º', '¿', '®', '½', '¼', 'ß', 'µ', 'þ', 'ý', 'Ý');
var
  xTexto: string;
  i: Integer;
begin
  xTexto := aTexto;
  for i := 1 to 38 do
    xTexto := StringReplace(xTexto, xCarEsp[i], xCarTro[i], [rfreplaceall]);
   //De acordo com o parâmetro aLimExt, elimina caracteres extras.
  if (aLimExt) then
    for i := 1 to 18 do
      xTexto := StringReplace(xTexto, xCarExt[i], '', [rfreplaceall]);
  Result := xTexto;
end;

function break_String(input: string; separador: Char): TStringList;
var
  resultado: TStringList;
begin
  resultado := TStringList.Create;
  resultado.Delimiter := separador;
    //resultado.LineBreak := separador;
  resultado.DelimitedText := input;
  Result := resultado;
end;

function get_mac_address(): string;
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
      if (Func(@GUID1) = 0) and (Func(@GUID2) = 0) and (GUID1.D4[2] = GUID2.D4[2]) and (GUID1.D4[3] = GUID2.D4[3]) and (GUID1.D4[4] = GUID2.D4[4]) and (GUID1.D4[5] = GUID2.D4[5]) and (GUID1.D4[6] = GUID2.D4[6]) and (GUID1.D4[7] = GUID2.D4[7]) then
      begin
        Result := IntToHex(GUID1.D4[2], 2) + '-' + IntToHex(GUID1.D4[3], 2) + '-' + IntToHex(GUID1.D4[4], 2) + '-' + IntToHex(GUID1.D4[5], 2) + '-' + IntToHex(GUID1.D4[6], 2) + '-' + IntToHex(GUID1.D4[7], 2);
      end;
    end;
  end;
end;

/// //////////////////////////////////////////////////////

  // get_param_tipo_fechamento : string;    // fechamente por [I]item ou por [D]documento
  // get_param_tipo_documento : string;
  // get_param_num_documento : string;


procedure SwapTabToEnter(var Msg: TMsg; var Handled: Boolean);
begin
  if not ((Screen.ActiveControl is TCustomMemo) or (Screen.ActiveControl is TCustomGrid) or (Screen.ActiveForm.ClassName = 'TMessageForm')) then
  begin
    if Msg.message = WM_KEYDOWN then
    begin
      case Msg.wParam of
        VK_RETURN, VK_DOWN:
          Screen.ActiveForm.Perform(WM_NextDlgCtl, 0, 0);
        VK_UP:
          Screen.ActiveForm.Perform(WM_NextDlgCtl, 1, 0);
      end;
    end;
  end;
end;

function IntegerToTipado(out ok: boolean; const s: Integer; const AIntegering: array of Integer; const ATipados: array of variant): variant;
var
  i: integer;
begin
  result := -1;
  for i := Low(AIntegering) to High(AIntegering) do
    if AnsiSameText(IntToStr(s), IntToStr(AIntegering[i])) then
      result := ATipados[i];
  ok := result <> -1;
  if not ok then
    result := ATipados[0];
end;

function TipadoToInteger(const t: variant; const AIntegering: array of Integer; const ATipados: array of variant): variant;
var
  i: integer;
begin
  result := '';
  for i := Low(ATipados) to High(ATipados) do
    if t = ATipados[i] then
      result := AIntegering[i];
end;

function VarianteToStr(AVarRec: TVarRec): string;
const
  Bool: array[Boolean] of string = ('False', 'True');
var
  basicType: Integer;
begin
  case AVarRec.VType of
    vtInteger:
      Result := IntToStr(AVarRec.VInteger);
    vtBoolean:
      Result := Bool[AVarRec.VBoolean];
    vtChar:
      Result := QuotedStr(AVarRec.VChar);
    vtExtended:
      Result := FloatToStr(AVarRec.VExtended^);
    vtString:
      Result := QuotedStr(AVarRec.VString^);
    vtPChar:
      Result := QuotedStr(AVarRec.VPChar);
    vtObject:
      Result := AVarRec.VObject.ClassName;
    vtClass:
      Result := AVarRec.VClass.ClassName;
    vtWideChar:
      Result := QuotedStr(string(AVarRec.VWideChar));
    vtAnsiString:
      Result := QuotedStr(string(AVarRec.VAnsiString));
    vtCurrency:
      Result := CurrToStr(AVarRec.VCurrency^);
    vtVariant:
      begin

        basicType := VarType(AVarRec.VType) and VarTypeMask;

        case basicType of
          varEmpty:
            Result := QuotedStr(string(AVarRec.VVariant^));
          varNull:
            Result := QuotedStr('');
          varSmallInt:
            Result := IntToStr(Integer(AVarRec.VVariant^));
          varInteger:
            Result := IntToStr(Integer(AVarRec.VVariant^));
          varSingle:
            Result := IntToStr(Integer(AVarRec.VVariant^));
          varDouble:
            Result := FloatToStr(Double(AVarRec.VVariant^));
          varCurrency:
            Result := CurrToStr(Currency(AVarRec.VVariant^));
          varDate:
            Result := DateToStr(TDateTime(AVarRec.VVariant^));
          varOleStr:
            Result := QuotedStr(string(AVarRec.VVariant^));
          varBoolean:
            Result := Bool[Boolean(AVarRec.VVariant^)];
          varVariant:
            Result := QuotedStr(string(AVarRec.VVariant^));
          varUnknown:
            Result := QuotedStr(string(AVarRec.VVariant^));
          varByte:
            Result := IntToStr(Integer(AVarRec.VVariant^));
          varWord:
            Result := QuotedStr(string(AVarRec.VVariant^));
          varLongWord:
            Result := QuotedStr(string(AVarRec.VVariant^));
          varInt64:
            Result := IntToStr(Integer(AVarRec.VVariant^));
          varStrArg:
            Result := QuotedStr(string(AVarRec.VVariant^));
          varString:
            Result := QuotedStr(string(AVarRec.VVariant^));
          varUString:
            Result := QuotedStr(string(AVarRec.VVariant^));
        end;
      end;
    vtPWideChar:
      Result := QuotedStr(string(AVarRec.VPWideChar));
    vtUnicodeString:
      Result := QuotedStr(string(AVarRec.VUnicodeString));
    vtWideString:
      Result := QuotedStr(string(AVarRec.VWideString));
  else
    // result := '';
    Result := QuotedStr(string(AVarRec.VPChar));
  end;
end;

function WinVersion: string;
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

function get_var_system(const VarName: string): string;
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


{-----------------------------------------------------------------------------
  Retornar uma data calculando apenas dias úteis, a partir de uma data inicial,
  exceto feriados.
 -----------------------------------------------------------------------------}
//Como regra básica, a Páscoa tem de cair no primeiro domingo após a lua cheia
//que seguir ao equinócio de primavera no hemisfério norte....
function Calcula_Pascoa(AAno: Word): TDateTime;
var
  R1, R2, R3, R4, R5: Longint;
  FPascoa: TDateTime;
  VJ, VM, VD: Word;
begin
  R1 := AAno mod 19;
  R2 := AAno mod 4;
  R3 := AAno mod 7;
  R4 := (19 * R1 + 24) mod 30;
  R5 := (6 * R4 + 4 * R3 + 2 * R2 + 5) mod 7;
  FPascoa := EncodeDate(AAno, 3, 22);
  FPascoa := FPascoa + R4 + R5;
  DecodeDate(FPascoa, VJ, VM, VD);
  case VD of
    26:
      FPascoa := EncodeDate(AAno, 4, 19);
    25:
      if R1 > 10 then
        FPascoa := EncodeDate(AAno, 4, 18);
  end;
  Result := FPascoa;
end;


function Str_to_Hex_Zebra(S: String): String;
var I: Integer;
begin
  Result:= '';
  for I := 1 to length (S) do
    Result:= Result+'_'+IntToHex(ord(S[i]),2);
end;

Function abrevia_nome(Nome: String): String;
var
    Nomes: array[1..20] of string;
    i, TotalNomes: Integer;
begin
    Result := Nome;
    {Insere um espaço para garantir que todas as letras sejam testadas}
    Nome := Nome + #32;
    {Pega a posição do primeiro espaço}
    i := Pos(#32, Nome);
    if i > 0 then
       begin
          TotalNomes := 0;
          {Separa todos os nomes}
         while i > 0 do
            begin
               Inc(TotalNomes);
               Nomes[TotalNomes] := Copy(Nome, 1, i - 1);
               Delete(Nome, 1, i);
               i := Pos(#32, Nome);
            end;
            if TotalNomes > 0 then
               begin
                  if (Nomes[TotalNomes] = 'FILHO')
                  or (Nomes[TotalNomes] = 'NETO')
                  or (Nomes[TotalNomes] = 'JUNIOR')
                  or (Nomes[TotalNomes] = 'JÚNIOR') then Dec(TotalNomes);
                 {Abreviar a partir do primeiro nome, exceto o último.}
                  for i := 1 to TotalNomes - 1 do
                  begin
                     if Length(Nomes[i]) > 3 then
                        {Pega apenas a primeira letra do nome e coloca um ponto após.}
                        Nomes[i] := Nomes[i][1] + '.'
                     else
                        {Apaga a variável quando for de, da, dos, das, etc}
                        Delete(Nomes[i],1,i);
                  end;
                  if (Nomes[TotalNomes + 1] = 'FILHO')
                  or (Nomes[TotalNomes + 1] = 'NETO')
                  or (Nomes[TotalNomes + 1] = 'JUNIOR')
                  or (Nomes[TotalNomes + 1] = 'JÚNIOR') then Inc(TotalNomes);
                  Result := '';
                  for i := 1 to TotalNomes do
                     if (Nomes[i] = 'FILHO')
                     or (Nomes[i] = 'NETO')
                     or (Nomes[i] = 'JUNIOR')
                     or (Nomes[i] = 'JÚNIOR') then
                        begin
                           Result := Result + (' ' + Nomes[i]);
                        end
                     else
                        begin
                           Result := Result + Trim(Nomes[i]);
                           Result := Trim(Result);
                        end;
               end;
       end;
end;

function parse_html_txt(vf_content : TStrings; vf_out: string):  AnsiString;
var
  IDoc:      IHTMLDocument2;
  Strl:      TStringList;
  sHTMLFile: String;
  v:         Variant;
  Links:     IHTMLElementCollection;
  i:         Integer;
  Link:    IHTMLAnchorElement;
begin

    Strl := TStringList.Create;
    try
      Strl.Text := vf_content.Text;
      Idoc:=CreateComObject(Class_HTMLDOcument) as IHTMLDocument2;
      try

        //IDoc.charset := Wide
        IDoc.designMode:='on';
        while IDoc.readyState<>'complete' do
          Application.ProcessMessages;
        v:=VarArrayCreate([0,0],VarVariant);
        v[0]:= Strl.Text;
        IDoc.write(PSafeArray(System.TVarData(v).VArray));
        IDoc.designMode:='off';
        while IDoc.readyState<>'complete' do
          Application.ProcessMessages;
        //Memo1.Lines.Text := IDoc.body.innerText;

        IDoc.body.innerText;
        IDoc.body.outerText;

        IDoc.body.innerHTML;
        IDoc.body.outerHTML;

        if vf_out = 'T' then
          //Result := WideStringToString(IDoc.body.innerText,CP_UTF8)

          Result := AnsiString(IDoc.body.innerText)
        else
          //Result := WideStringToString(IDoc.body.innerHTML,CP_UTF8);
          Result := AnsiString(IDoc.body.innerHTML);
      finally
        IDoc := nil;
      end;
    finally
      Strl.Free;
    end;
end;

function ProcessExists(exeFileName: string): Integer;
  var
    ContinueLoop: BOOL;
    FSnapshotHandle: THandle;
    FProcessEntry32: TProcessEntry32;
    CountInstance : Integer;
  begin
    FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
    ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
    CountInstance := 0;
    Result := CountInstance;
    while Integer(ContinueLoop) <> 0 do
    begin
      if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
        UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
        UpperCase(ExeFileName))) then
      begin
        CountInstance := CountInstance+1;
        Result := CountInstance-1;
      end;
      ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
    end;
    CloseHandle(FSnapshotHandle);
  end;


function TerminarProcesso(sFile: String): Boolean;
var
  verSystem: TOSVersionInfo;
  hdlSnap,hdlProcess: THandle;
  bPath,bLoop: Bool;
  peEntry: TProcessEntry32;
  arrPid: Array [0..1023] of DWORD;
  iC: DWord;
  k,iCount: Integer;
  arrModul: Array [0..299] of Char;
  hdlModul: HMODULE;
begin
  Result := False;
  if ExtractFileName(sFile)=sFile then
    bPath:=false
  else
    bPath:=true;
  verSystem.dwOSVersionInfoSize:=SizeOf(TOSVersionInfo);
  GetVersionEx(verSystem);
  if verSystem.dwPlatformId=VER_PLATFORM_WIN32_WINDOWS then
  begin
    hdlSnap:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    peEntry.dwSize:=Sizeof(peEntry);
    bLoop:=Process32First(hdlSnap,peEntry);
    while integer(bLoop)<>0 do
    begin
      if bPath then
      begin
        if CompareText(peEntry.szExeFile,sFile) = 0 then
        begin
          TerminateProcess(OpenProcess(PROCESS_TERMINATE,false,peEntry.th32ProcessID), 0);
          Result := True;
        end;
      end
      else
      begin
        if CompareText(ExtractFileName(peEntry.szExeFile),sFile) = 0 then
        begin
          TerminateProcess(OpenProcess(PROCESS_TERMINATE,false,peEntry.th32ProcessID), 0);
          Result := True;
        end;
      end;
      bLoop := Process32Next(hdlSnap,peEntry);
    end;
    CloseHandle(hdlSnap);
  end ;
 {
  else
    if verSystem.dwPlatformId=VER_PLATFORM_WIN32_NT then
    begin
      EnumProcesses(@arrPid,SizeOf(arrPid),iC);
      iCount := iC div SizeOf(DWORD);
      for k := 0 to Pred(iCount) do
      begin
        hdlProcess:=OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ,false,arrPid [k]);
        if (hdlProcess<>0) then
        begin
          EnumProcessModules(hdlProcess,@hdlModul,SizeOf(hdlModul),iC);
          GetModuleFilenameEx(hdlProcess,hdlModul,arrModul,SizeOf(arrModul));
          if bPath then
          begin
            if CompareText(arrModul,sFile) = 0 then
            begin
              TerminateProcess(OpenProcess(PROCESS_TERMINATE or PROCESS_QUERY_INFORMATION,False,arrPid [k]), 0);
              Result := True;
            end;
          end
          else
          begin
            if CompareText(ExtractFileName(arrModul),sFile) = 0 then
            begin
              TerminateProcess(OpenProcess(PROCESS_TERMINATE or PROCESS_QUERY_INFORMATION,False,arrPid [k]), 0);
              Result := True;
            end;
          end;
          CloseHandle(hdlProcess);
        end;
      end;
    end;      }
end;

function RunAsAdmin(const Handle: Hwnd; const Path, Params: string): Boolean;
var
  sei: TShellExecuteInfoA;
begin
  FillChar(sei, SizeOf(sei), 0);
  sei.cbSize := SizeOf(sei);
  sei.Wnd := Handle;
  sei.fMask := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI;
  sei.lpVerb := 'runas';
  sei.lpFile := PAnsiChar(Path);
  sei.lpParameters := PAnsiChar(Params);
  sei.nShow := SW_SHOWNORMAL;
  Result := ShellExecuteExA(@sei);
end;

function GetPrintActivityWindow(vf_prefix:string) : string;
var vl_imgbmp : TBitmap;
    vl_imgjpg : TJPEGImage;
    vl_full_path, vl_sufix, vl_dirroot :string;
    sc, ds : TRect;
    dc : THandle;
    cn : TCanvas;
begin
  //Clipboard.Clear;

  vl_imgbmp := TBitmap.Create;
  vl_sufix := FormatDateTime('yyyymmddhhnnss',Now());
  vl_dirroot := ExtractFileDir(application.ExeName);
  vl_full_path := UpperCase(vl_dirroot+'\TEMP\'+vf_prefix+vl_sufix+'.jpg');
  vl_imgjpg := TJPEGImage.Create;
  vl_imgjpg.CompressionQuality := 60;

  GetWindowRect(GetForegroundWindow,sc);
  ds.Top:=0;
  ds.Left:=0;
  ds.Right:=sc.Right-sc.Left;
  ds.Bottom:=sc.Bottom-sc.Top;
  vl_imgbmp.Height:=ds.Bottom;
  vl_imgbmp.Width:=ds.Right;
  dc:=getdc(0);
  cn:=tcanvas.create;
  cn.Handle:=dc;
  vl_imgbmp.Canvas.CopyRect(ds,cn,sc);



  //vl_imgbmp.SaveToFile(vl_full_path+'.bmp');

  vl_imgjpg.Assign(vl_imgbmp);
  vl_imgjpg.Compress;

  vl_imgjpg.SaveToFile(vl_full_path);
  vl_imgjpg.Free;
  vl_imgbmp.Free;
  cn.free;
  Result := vl_full_path;
end;

function AplicarMnemonicos(Texto:string;Param: TList<TRefMnemonicos>;Data: TFDQuery = nil): string;
var
  xTextoCompleto, TextoFormatado: string;
  I, X : Integer;
begin
  if Texto <> '' then
  Begin
    xTextoCompleto := Texto;

    for I := 0 to Param.Count-1 do
    begin
      if Param.Items[I].FieldName <> '' then
      begin

        Case Data.FieldByName(Param.Items[I].FieldName).DataType of
          ftDate,
          ftTime,
          ftDateTime : TextoFormatado := FormatDateTime('DD/MM/YYYY', Data.FieldByName(Param.Items[I].FieldName).AsDateTime);

          ftFloat,
          ftCurrency : TextoFormatado := FormatFloat('R$ #,##0.00',Data.FieldByName(Param.Items[I].FieldName).AsCurrency);
        else
          TextoFormatado := Data.FieldByName(Param.Items[I].FieldName).AsString;
        End
      end
      else
      begin

        if Param.Items[I].Texto <> '' then
        Begin

          TextoFormatado :=    Param.Items[I].Texto;

          for X := 0 to Length(Param.Items[I].VariaveisTexto)-1 do
          begin
            TextoFormatado := StringReplace(TextoFormatado,
                                            Param.Items[I].VariaveisTexto[X],
                                            Param.Items[I].ValoresTexto[X],
                                            [rfreplaceall]);
          end;
        End
        else
        Begin
          for X := 0 to Length(Param.Items[I].ValoresTexto)-1 do
          begin
            TextoFormatado := Param.Items[I].ValoresTexto[X];
          end;
        End;
      end;

      xTextoCompleto := StringReplace(xTextoCompleto, Param.Items[I].MnemonicoName, TextoFormatado, [rfreplaceall]);

    end;

    Result := xTextoCompleto;
  End
  else
    Result := '';
end;

procedure AddMnemonicos(Lista:TList<TRefMnemonicos>;MnemonicoTipado:TMnemonicos;Formatar:Boolean;Valor:Variant); overload;
var RefMnemonicos : TRefMnemonicos;
    Conteudo : TArrTexto;
begin
  RefMnemonicos := TRefMnemonicos.Create;
  RefMnemonicos.Mnemonico := MnemonicoTipado;
  SetLength(Conteudo,1);

  Case TVarData(Valor).vType of
    varDate     : Conteudo[0] := IfThen(Formatar,FormatDateTime('DD/MM/YYYY',Valor),Valor);

    varDouble,
    varCurrency : Conteudo[0] := ifthen(Formatar,FormatFloat('R$ #,##0.00',Valor),Valor);

    varString   : Conteudo[0] := string(Valor);
  else
    Conteudo[0] := VarToStr(Valor);
  End;
  RefMnemonicos.ValoresTexto := Conteudo;
  Lista.Add(RefMnemonicos);
end;

procedure AddMnemonicos(Lista:TList<TRefMnemonicos>;MnemonicoTipado:TMnemonicos;FieldName:string);
var RefMnemonicos : TRefMnemonicos;
begin
  RefMnemonicos := TRefMnemonicos.Create;
  RefMnemonicos.FieldName := FieldName;
  RefMnemonicos.Mnemonico := MnemonicoTipado;
  Lista.Add(RefMnemonicos);
end;

procedure AddMnemonicos(Lista:TList<TRefMnemonicos>;MnemonicoTipado:TMnemonicos;Texto:string;Variaveis:TArrTexto;Valores:TArrTexto);
var RefMnemonicos : TRefMnemonicos;
begin
  RefMnemonicos := TRefMnemonicos.Create;
  RefMnemonicos.Mnemonico := MnemonicoTipado;
  RefMnemonicos.Texto := Texto;
  RefMnemonicos.VariaveisTexto := Variaveis;
  RefMnemonicos.ValoresTexto := Valores;
  Lista.Add(RefMnemonicos);
end;

procedure Extract_resource_fb;
var
   fs: TFileStream;
   rs: TResourceStream;
   s : string;
   I : integer;
 begin
   for I := 0 to Length(RC_NAME_FB)-1 do
   begin
     try
      rs := TResourceStream.Create(hInstance, RC_NAME_FB[I], RT_RCDATA);
       s  := GetCurrentDir+'\'+RC_FILENAME_FB[I];
       fs := TFileStream.Create(s,fmCreate);
       rs.SaveToStream(fs);
     finally
      fs.Free;
     end;
   end;
 end;

 function ValidaCnpjCeiCpf(Numero: String; ExibeMsgErro: Boolean=True): Boolean;
//Verifica se o numero passado no parametro é CNPJ/CPF ou CEI e valida o mesmo. Se nao for válido e o parametro ExibeMSGErro for true, exibe um messagebox co icone de erro.
var
  i,d,b,
  Digito : Byte;
  Soma : Integer;
  CNPJ,CPF,CEI : Boolean;
  DgPass,
  DgCalc,DocMsg, MsgDialogo : String;

  function IIf(pCond:Boolean;pTrue,pFalse:Variant): Variant;
  begin
    If pCond Then Result := pTrue
    else Result := pFalse;
  end;

  function ValidaCEI(StrCEI:String):Boolean;
  const
    PESO = '74185216374';
  var
    Numero,DV_DIG,StrSoma :String;
    soma,i,valor1,valor2,
    resto,PRIDIG          :integer;
  begin
    Result := True;

    if Length(Trim(StrCEI)) = 0 then Exit;

    Numero := Copy(StrCEI,Length(StrCEI)-12+1,12);
    DV_DIG := Copy(Numero,12,1);
    soma   := 0;

    for i:= 1 to 11 do
      soma := soma + (StrToInt(Copy(Numero,i,1)) * StrToInt(Copy(PESO,i,1)));

    StrSoma:= FormatFloat('0000',soma);
    valor1 := StrToInt(Copy(StrSoma,4,1));
    valor2 := StrToInt(Copy(StrSoma,3,1));
    resto  := (valor1+valor2) Mod 10;

    if resto <> 0 then PRIDIG := 10 - resto;

    if PRIDIG <> StrToInt(DV_DIG) then
      Result := False;
  end;

begin
  Result := False;

  Numero := OnlyNumber(Numero);
  // Caso o número não seja 11 (CPF) ou 14 (CNPJ), aborta

  CPF := Length(Numero)=11;
  CNPJ:= Length(Numero)=14;
  CEI := Length(Numero)=12;

  case Length(Numero) of
    11: DocMsg:= 'CPF';
    14: DocMsg:= 'CNPJ';
    12: DocMsg:= 'CEI';
  end;

  if (Length(Numero) in [11,12,14]) then
  begin
    if CPF or CNPJ then
    begin
      // Separa o número do dígito
      DgCalc := '';
      DgPass := Copy(Numero,Length(Numero)-1,2);
      Numero := Copy(Numero,1,Length(Numero)-2);
      // Calcula o digito 1 e 2
      for d := 1 to 2 do
      begin
        B := IIF(D=1,2,3); // BYTE
        SOMA := IIF(D=1,0,STRTOINTDEF(DGCALC,0)*2);
        for i := Length(Numero) downto 1 do begin
          Soma := Soma + (Ord(Numero[I])-Ord('0'))*b;
          Inc(b);
          if (b > 9) And CNPJ Then
            b := 2;
        end;
        Digito := 11 - Soma mod 11;
        if Digito >= 10 then
          Digito := 0;
        DgCalc := DgCalc + Chr(Digito + Ord('0'));
      end;
      Result := DgCalc = DgPass;
    end else
      Result := ValidaCEI(Numero);
    MsgDialogo:= 'O número do '+DocMsg+' digitado é inválido!';
  end;
  if (not Result) and (ExibeMsgErro) then
    Application.MessageBox(Pchar(MsgDialogo),'Atenção',mb_ICONERROR+MB_OK);

end;

function OnlyNumber(const AValue: String): String;
Var
  I : Integer ;
  LenValue : Integer;
begin
  Result   := '' ;
  LenValue := Length( AValue ) ;
  For I := 1 to LenValue  do
  begin
     if CharIsNum( AValue[I] ) then
        Result := Result + AValue[I];
  end;
end ;

function CharIsNum(const C: Char): Boolean;
begin
  Result := CharInSet( C, ['0'..'9'] ) ;
end ;


function FormataDocumento(doc : string) :string;
Var
   FormatarCNPJ:String;
   FormatarCPF:String;
begin
   Result := '';
   doc := OnlyNumber(doc);
   if Length(Doc) <> 0 then
     if Length(doc) = 14 then
     Begin
       if ValidaCnpjCeiCpf(doc) = True Then
       Begin
         FormatarCNPJ := Copy(doc, 1, 2)
           + '.' + Copy(doc, 3, 3)
           + '.' + Copy(doc, 6, 3)
           + '/' + Copy(doc, 9, 4)
           + '-' + Copy(doc, 13, 2);
         Result := FormatarCNPJ;
       End
       Else
       begin
         ShowMessage('CNPJ com erro. favor verificar');
       end;
     End
     Else
     if Length(doc) = 11 then
     Begin
       if ValidaCnpjCeiCpf(doc) = True Then
       Begin
         FormatarCPF := Copy(doc, 1, 3)
           + '.' + Copy(doc, 4, 3)
           + '.' + Copy(doc, 7, 3)
           + '-' + Copy(doc, 10, 2);
         Result := FormatarCPF;
       End
       Else
       begin
         ShowMessage('CPF com erro. favor verificar');
       end;
     End
     Else
     Begin
       ShowMessage('O CPF tem 11 nº e CNPJ tem 14 nº.'#13'Prencha com números');
     End;
end;

function ValidarEMail(aStr: string): Boolean;
begin
 aStr := Trim(UpperCase(aStr));
 if Pos('@', aStr) > 1 then
 begin
   Delete(aStr, 1, pos('@', aStr));
   Result := (Length(aStr) > 0) and (Pos('.', aStr) > 2);
 end
 else
   Result := False;
end;

 end.
