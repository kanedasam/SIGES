unit Model.Utilities;

interface

uses Winapi.Windows, System.SysUtils, Vcl.Forms, Model.PcnTyped,
Dialogs, View.FrmStatus, View.FrmSearch, Data.DB,
ShellApi,Winapi.Messages, System.Variants, Vcl.Graphics,
Vcl.Controls, Vcl.StdCtrls,ShlObj,Model.ConstantsSQL,
View.FrmGetInfoCnpjWs, View.GetInfoCepWs, System.StrUtils,
View.FrmMessage, Model.Utilities.InfoMachine, System.Zip,
View.FrmStatusExtract, System.IOUtils,  Model.VariableSystem,
Model.Constants, Model.Cryption, System.Classes, Model.ArchiveCompress,
Vcl.Imaging.jpeg, View.CallHelpDesk,
Winapi.WinInet, IdBaseComponent, IdComponent, IdRawBase, IdRawClient, IdIcmpClient,
IdTCPConnection, IdTCPClient, IdHTTP, Vcl.FileCtrl, Math, DBCommon,Mask;

type

  TInputQueryExForm = class(TForm)
  public
    FCloseQueryFunc: TFunc<Boolean>;
    function CloseQuery: Boolean; override;
  end;

  TUtilities = class(TObject)
  private
    { private declarations }
    procedure UniDumpBackupProgress(Sender: TObject; ObjectName: string;
      ObjectNum, ObjectCount, Percent: Integer);

  protected
    { protected declarations }
  public
    { public declarations }
    InfoMachine : TInfoMachine;
    function RunAsAdmin(const Handle: Hwnd; const Path, Params: string): Boolean;
    function SetEnvVarValue(const VarName,VarValue: string): Integer;
    function RandomText(seed: integer; text: string): string;
    function LoadPath(vf_pathrot : string; vf_list_path : array of string): Boolean;
    function AuthenticateDocs(vf_tp_doc: pcn_type_doc_id; vf_num_doc: string; vf_compl_doc : string = ''): rc_valid_doc;
    //function InfoEnitedPessoaSefaz(vf_tp_ent: pcn_type_entid = peIndef; vf_num_cnpjcpf: string = ''): rc_info_ent;
    function InfoEnitedPessoaWS(vf_num_cnpjcpf: string): rc_info_ent;
    function GetCEPWS(vfCEP: string): rc_info_end;
    procedure ShowMessagePanel(msn: string; action_window: pcn_form_show);
    function ShowFormSearch(vf_dbconnection : TUniConnection;
                            vf_id_grid, vf_title_form, vf_script_sql:string;
                            vf_title_columns: array of string;
                            vf_sgdb_sorce : string = 'LOCAL'): rc_search;
    function WinExecAndWait32(FileName: string; Visibility: Integer): Longword;
    function ExecAndWait(const FileName: string; const CmdShow: Integer): Longword;
    function WinExecAndWait32V2(FileName: string; Visibility: Integer): DWORD;
    function ShellExecute_AndWait(Operation, FileName, Parameter, Directory: string; Show: Word; bWait: Boolean): Longint;
    procedure ShellExecute_AndWait2(FileName: string; Params: string);
    function FormatarFone(const AValue : String; DDDPadrao: String = '') : String ;
    function GetSpecialFolder( aFolder: Integer; var Location: String ): LongWord;
    function VarRecToStr(AVarRec: TVarRec): string;
    function GetReturnValue(vfDBConn: TUniConnection;
                            vfTable: string;
                            vfFieldsReturn: string;
                            vfFieldsParam: array of string;
                            vfFieldsParamValour: array of const;
                            vfFormatReturn: TFieldType = ftUnknown): Variant;

    function GetReturnArrayValue(vfDBConn: TUniConnection;
                                   vfTable: string;
                                   vfFieldsSelects: array of string;
                                   vfFieldsParam: array of string;
                                   vfFieldsParamValour: array of const
                                   ):TArrayofVariant;

    function GetExistValue(vfDBConn: TUniConnection;
                           vfTable: string;
                           vfFields: array of String;
                           vfValours: array of const;
                           vfFilter : array of String): Boolean;
    function ShowMessageEx(vfTitle, vfMessage:string;vfIcomImage:pcn_messageicom;
                           vfWindowType:pcn_window_type = wtAlert):Boolean;
    function IsMatriz(vCNPJ: string): Boolean;
    function SQLPrepareArrayString(vfArrayString: TArray<String>): string;
    function GetNextValue(vfDBConn: TUniConnection;
                          vfTabela: string;
                          vfField: string;
                          vfFilterParamValue: array of const;
                          vfFilterParamField: string = ''): integer;
    function SyncUP_LicenceWS(vfDBConnL: TUniConnection;
                              vfDBConnW: TUniConnection;
                              fvIDLIC:Integer;vfCPFCNPJ,vfSERIALSYS: string): Boolean;

    function SyncDW_LicenceWS(vfDBConnL: TUniConnection;
                              vfDBConnW: TUniConnection;
                              fvIDLIC:Integer;vfCPFCNPJ,SERIAL: string): Boolean;

    function SyncPessoaWS(vfDBConnL: TUniConnection;
                          vfDBConnW: TUniConnection;
                          vfCPFCNPJ: string): Boolean;

    function SyncDW_EquipamentoWS(vfDBConnL: TUniConnection;
                                  vfDBConnW: TUniConnection;
                                  vfCONTRATOID: integer): Boolean;

    function ServerIsOnline(vfDBConn: TUniConnection): Boolean;
    function SyncSend_EquipamentoWS(vfDBConnL, vfDBConnW: TUniConnection;
                                    vfCONTRATOID: integer): Boolean;
    function ExistDB(vfDBConn: TUniConnection;vfDB:string):Boolean;
    function CreatDB(vfDBConn: TUniConnection;vfDB:string):Boolean;
    function GetVersionSystem(vf_type_user: pcn_type_user_sys): string;
    procedure ClearDir(StDelDir: boolean; FullPath: string);
    procedure DeleteDir(FullPath: string);
    function GetFileSize(FileName: String; FormatSize: pcn_Byte_Format = bsfDefault;WtihFormatSize : Boolean = True): string;
    function SetFileNameBackup:string;
    function IsServer(vfSERVER:string):Boolean;
    function StringToStream(const AString: string):TStream;
    Function AbbreviateName(vfNome: String;vfAbreviar:Boolean;vfMaxAbreviacao,vfMaxCaracer:integer): String;
    function GerarBackupDB(vfDBConn: TUniConnection): Boolean;
    function RegisterBackupDB(vfDBConn: TUniConnection;vfFileBkp:string): Boolean;
    function UpLoadFtp(HostName: String;
                            UserName: String;
                            Password: String;
                            UploadFileName: String;
                            ServerFileName: String;
                            ToHostDir : String ):Boolean;
    procedure FtpClientProgress64(Sender: TObject; Count: Int64;var Abort: Boolean);
    function CheckCompanySync(vfDBConnL: TUniConnection;
                              vfDBConnW: TUniConnection;
                              vfCPFCNPJ: string): Boolean;
    function GetPrintActivityWindow(vfCodContrato:string) : string;
    function CreateCallHelpDesk : Boolean;
    function TimeStampUnix(vfConvertion:pcn_datetimestampunix;vfValue:string): string;
    function FileToHex(vfFileName:string): string;
    function SetCFGDephault(vfDBConnL: TUniConnection; vfCPFCNPJ: string): Boolean;
    function InternetConnectionKind: rc_connection_info;
    function GetIpInternet:string;
    function SetSelectADirectory(Title : string;DirAtual:WideString='') : string;
    function InsertContrato(vfDBConnL: TUniConnection;vfCLIENTEID, vfCONTRATOID:Integer): Boolean;
    function InsertLicenca(vfDBConnL: TUniConnection;vfCLIENTEID, vfCONTRATOID, vfVERSAOID:Integer;vfLICENCE:string): Boolean;
    function ContaPalavras(Texto :String) :Integer;

    Function Sat_valida_regras_tributo_saida(vf_force_check,
                                              vf_show_log,
                                              vf_save_log :Boolean;
                                              vf_cst_cson_cfop,
                                              vf_cst_ipi,
                                              vf_cst_pis,
                                              vf_cst_cofins : Integer;
                                              vf_perc_redbc_icms,
                                              vf_perc_diff,
                                              vf_perc_icms,
                                              vf_perc_icmssn,
                                              vf_perc_mva,
                                              vf_perc_ipi,
                                              vf_perc_pis,
                                              vf_perc_cofins : Currency;
                                              vf_flg_icms,
                                              vf_flg_ipi,
                                              vf_flg_pis,
                                              vf_flg_cofins,
                                              vf_flg_st:Boolean
                                              ):rc_acceppt_pf;

    Function RetornaPercentual(const pValorTotal, pValor: Currency): Currency;
    Function Percentual(const pPercentual: Double; const pValor: Currency): Currency;
    constructor Create;
    destructor Destroy; override;

    function EspelharRegistro(vfDBConn: TUniConnection;
                              TabelaMaster:string;
                              IdTabelaMaster:Integer;
                              TabelaDetail:array of string;
                              FiledNameRelDetail:array of string;
                              ImputMasterField: array of string;
                              ImputMasterFieldTitle: array of string;
                              ImputMasterFieldDefault: array of string;
                              ImputMasterValuesDefault: array of const) : Boolean;

    function GerarSQLSimples(DataSet:TUniQuery;TipoSQL:string='insert'):string;
    procedure AssignArrayString(const Aorigem: array of string; out ADestino : TArrayofString);
    procedure AssignArrayVariant(const Aorigem: array of Variant; out ADestino : TArrayofVariant);
    function CalcularPagamentos(vfDBConn: TUniConnection;vfConvenioID, vfTotalParcelas:Integer;vfValorDocumento,vfValorEntrada:Currency): tp_result_rec_pagamentos;
    function GerarParcelasNotas(vfDBConn: TUniConnection;
                                vfNotaID:Integer;
                                vfNotaConvenioID: array of Integer;
                                vfPagamentos : array of tp_result_rec_pagamentos): Boolean;
    function GetReturnValueFromSQL(vfDBConn: TUniConnection;
                                    vfSQL: string;
                                    vfFieldsReturn: string;
                                    vfFormatReturn: TFieldType = ftUnknown
                                   ): Variant;
    function ExecuteSQLSimples(vfDBConn: TUniConnection;SQL:string):Boolean;
    function InputBoxData(ACaption, APrompt : string; ADefault : Tdate): TDate;
  end;

implementation


{ TUtilities }

function TUtilities.AuthenticateDocs(vf_tp_doc: pcn_type_doc_id;
  vf_num_doc, vf_compl_doc: string): rc_valid_doc;
var
  vl_sat_validaor: TACBrValidador;
begin
  try
    vl_sat_validaor             := TACBrValidador.Create(Application);
    vl_sat_validaor.RaiseExcept := False;
    vl_sat_validaor.TipoDocto   := vf_tp_doc;
    vl_sat_validaor.Documento   := vf_num_doc;
    vl_sat_validaor.Complemento := vf_compl_doc;

    Result.is_valided           := vl_sat_validaor.Validar;
    Result.Doc_Formated         := vl_sat_validaor.Formatar;

  finally
    vl_sat_validaor.Free;
  end;
end;

function TUtilities.CreatDB(vfDBConn: TUniConnection; vfDB: string): Boolean;
var vlMmoContainer, vlMmoLoadSQL : TStrings;
    VariableSystem : TVariableSystem;
    vlRestoreDB: TUniDump;
    vlScript : Tstream;
begin
  try
    Result := True;
    try
      Self.ShowMessagePanel('Aguarde, criando a base de dados...', sfShow);

      vlRestoreDB := TUniDump.Create(nil);
      vlRestoreDB.Connection := vfDBConn;
      vlRestoreDB.Options.AddDrop := True;
      vlRestoreDB.Options.CompleteInsert := True;
      vlRestoreDB.Options.GenerateHeader := True;
      vlRestoreDB.Options.QuoteNames := True;
      vlRestoreDB.SpecificOptions.Clear;

      vlRestoreDB.SpecificOptions.Add('AddLock=False');
      vlRestoreDB.SpecificOptions.Add('BackupData=True');
      vlRestoreDB.SpecificOptions.Add('BackupStoredProcs=True');
      vlRestoreDB.SpecificOptions.Add('BackupTables=True');
      vlRestoreDB.SpecificOptions.Add('BackupTriggers=True');
      vlRestoreDB.SpecificOptions.Add('BackupViews=True');
      vlRestoreDB.SpecificOptions.Add('CommitBatchSize=0');
      vlRestoreDB.SpecificOptions.Add('DisableKeys=False');
      vlRestoreDB.SpecificOptions.Add('HexBlob=False');
      vlRestoreDB.SpecificOptions.Add('InsertType=itInsert');
      vlRestoreDB.SpecificOptions.Add('UseDelayedIns=False');
      vlRestoreDB.SpecificOptions.Add('UseExtSyntax=True');


      VariableSystem := TVariableSystem.Create;
      vlMmoLoadSQL   := TStringList.Create;
      vlMmoContainer := TStringList.Create;
      // Criando a database
      vlMmoLoadSQL.Clear;
      vlMmoContainer.Clear;
      vlMmoLoadSQL.LoadFromFile(VariableSystem.GetSystemPathTMP+'dbcreat.sql');
      vlMmoContainer.Text := StringReplace( vlMmoLoadSQL.text, '%DATABASENAME%', vfDB, [rfReplaceAll] );
      vlRestoreDB.RestoreFromStream(Self.StringToStream(vlMmoContainer.Text));

      // Criando as tabelas primarias e os dados alimentares
      vlRestoreDB.SQL.Clear;
      vlMmoLoadSQL.Clear;
      vlMmoContainer.Clear;
      vlMmoLoadSQL.LoadFromFile(VariableSystem.GetSystemPathTMP+'dbstruc.sql');
      vlMmoContainer.Text := 'USE `'+vfDB+'`;'+#13#10+vlMmoLoadSQL.Text;
      vlRestoreDB.RestoreFromStream(Self.StringToStream(vlMmoContainer.Text));
    except
      Result := False;
    end;
  finally
    Self.ShowMessagePanel('Aguarde, criando a base de dados...', sfClose);
    FreeAndNil(vlRestoreDB);
    FreeAndNil(VariableSystem);
    FreeAndNil(vlMmoContainer);
    FreeAndNil(vlMmoLoadSQL);
  end;
end;

constructor TUtilities.Create;
begin
  InfoMachine := TInfoMachine.Create;

end;

procedure TUtilities.DeleteDir(FullPath: string);
begin
  if System.IOUtils.TDirectory.Exists(FullPath) then
    System.IOUtils.TDirectory.Delete(FullPath,True);
end;

destructor TUtilities.Destroy;
begin
  InfoMachine.Free;
  inherited;
end;

function TUtilities.GerarBackupDB(vfDBConn: TUniConnection): Boolean;

var VariableSystem : TVariableSystem;
    ArchiveCompress : TArchiveCompress;
    vlBackupDB: TUniDump;
    vlScript : Tstream;
    vlFileBackup : string;
begin
  try
    Result := True;
    try
      frmStatusExtract := TfrmStatusExtract.Create(nil);
      case dayofweek(Date) of
        1 : vlFileBackup := 'DOM';
        2 : vlFileBackup := 'SEG';
        3 : vlFileBackup := 'TER';
        4 : vlFileBackup := 'QUA';
        5 : vlFileBackup := 'QUI';
        6 : vlFileBackup := 'SEX';
        7 : vlFileBackup := 'SAB';
      end;

      ArchiveCompress := TArchiveCompress.Create;

      vlFileBackup := vlFileBackup + vfDBConn.Database;

      vlBackupDB := TUniDump.Create(nil);
      vlBackupDB.Connection := vfDBConn;
      vlBackupDB.Options.AddDrop := True;
      vlBackupDB.Options.CompleteInsert := True;
      vlBackupDB.Options.GenerateHeader := True;
      vlBackupDB.Options.QuoteNames := True;
      vlBackupDB.SpecificOptions.Clear;

      vlBackupDB.SpecificOptions.Add('AddLock=False');
      vlBackupDB.SpecificOptions.Add('BackupData=True');
      vlBackupDB.SpecificOptions.Add('BackupStoredProcs=True');
      vlBackupDB.SpecificOptions.Add('BackupTables=True');
      vlBackupDB.SpecificOptions.Add('BackupTriggers=True');
      vlBackupDB.SpecificOptions.Add('BackupViews=True');
      vlBackupDB.SpecificOptions.Add('CommitBatchSize=0');
      vlBackupDB.SpecificOptions.Add('DisableKeys=False');
      vlBackupDB.SpecificOptions.Add('HexBlob=False');
      vlBackupDB.SpecificOptions.Add('InsertType=itInsert');
      vlBackupDB.SpecificOptions.Add('UseDelayedIns=False');
      vlBackupDB.SpecificOptions.Add('UseExtSyntax=True');

      vlBackupDB.OnBackupProgress :=  UniDumpBackupProgress;
      VariableSystem := TVariableSystem.Create;

      // Criando o backup da database
      frmStatusExtract.Show;
      Application.ProcessMessages;
      vlBackupDB.BackupToFile(VariableSystem.GetSystemPathBKP+vlFileBackup+'.sql');
      frmStatusExtract.Close;

      if ArchiveCompress.CreatArchive(VariableSystem.GetSystemPathBKP+vlFileBackup+'.fxc',
                                      '@disam356',
                                      VariableSystem.GetSystemPathBKP,
                                      vlFileBackup+'.sql')
      then
      begin
        DeleteFile(VariableSystem.GetSystemPathBKP+vlFileBackup+'.sql');
        Result := Self.RegisterBackupDB(vfDBConn, VariableSystem.GetSystemPathBKP+vlFileBackup+'.fxc');
      end;


    except
      frmStatusExtract.Close;
      Result := False;
    end;
  finally
    FreeAndNil(ArchiveCompress);
    FreeAndNil(frmStatusExtract);
    FreeAndNil(vlBackupDB);
    FreeAndNil(VariableSystem);
  end;
end;


function TUtilities.GerarParcelasNotas(vfDBConn: TUniConnection;
                                       vfNotaID:Integer;
                                       vfNotaConvenioID: array of Integer;
                                       vfPagamentos : array of tp_result_rec_pagamentos): Boolean;
var vlConveniosCount, vlParcelasCount : Integer;
    I,X: Integer;
    vTableParcelas: TVirtualTable;
    TableParcelas : TUniQuery;
begin
  try
    try
      vlConveniosCount :=  Length(vfPagamentos);

      vTableParcelas := TVirtualTable.Create(nil);

      TableParcelas  := TUniQuery.Create(nil);
      TableParcelas.AutoCalcFields := True;
      TableParcelas.Options.AutoPrepare := True;
      TableParcelas.Connection := vfDBConn;
      TableParcelas.Transaction := vfDBConn.DefaultTransaction;
      TableParcelas.CachedUpdates := True;
      TableParcelas.Close;
      TableParcelas.SQL.Clear;
      TableParcelas.SQL.Add(SQLGETNOTASPARCELAS);



      vTableParcelas.FieldDefs.Add('NOTA_ID',ftInteger);
      vTableParcelas.FieldDefs.Add('NOTAS_CONVENIO_ID',ftInteger);
      vTableParcelas.FieldDefs.Add('NUMERO_PARCELA',ftInteger);
      vTableParcelas.FieldDefs.Add('DATA_PARCELA',ftDate);
      vTableParcelas.FieldDefs.Add('VALOR_PARCELA',ftCurrency);
      vTableParcelas.IndexFieldNames := 'DATA_PARCELA';
      vTableParcelas.Open;
      vTableParcelas.Clear;


      for I := 0 to vlConveniosCount-1 do
      begin
          vlParcelasCount :=  Length(vfPagamentos[I]);
          for X := 0 to vlParcelasCount-1 do
          begin
            with vfPagamentos[I][X] do
            begin
              vTableParcelas.Insert;
              vTableParcelas.FieldByName('NOTA_ID').AsInteger := vfNotaID;
              vTableParcelas.FieldByName('NOTAS_CONVENIO_ID').AsInteger := vfNotaConvenioID[I];
              vTableParcelas.FieldByName('NUMERO_PARCELA').AsInteger := 0;
              vTableParcelas.FieldByName('DATA_PARCELA').AsDateTime := Data_Vencimento;
              vTableParcelas.FieldByName('VALOR_PARCELA').AsCurrency := Valor_Parcela;
              vTableParcelas.Post;
            end;
          end;
      end;

      vTableParcelas.Refresh;
      vTableParcelas.First;

      for I := 0 to vTableParcelas.RecordCount-1 do
      begin
        vTableParcelas.Edit;
        vTableParcelas.FieldByName('NUMERO_PARCELA').AsInteger := I+1;
        vTableParcelas.Post;
        vTableParcelas.Next;
      end;

      vTableParcelas.Refresh;
      TableParcelas.Open;
      vTableParcelas.First;

      for I := 0 to vTableParcelas.RecordCount-1 do
      Begin
        if TableParcelas.Locate('NOTA_ID;NOTAS_CONVENIO_ID;NUMERO_PARCELA',
                                VarArrayOf([vTableParcelas.FieldByName('NOTA_ID').AsInteger,
                                 vTableParcelas.FieldByName('NOTAS_CONVENIO_ID').AsInteger,
                                 vTableParcelas.FieldByName('NUMERO_PARCELA').AsInteger
                                ]),
                                []
                               ) then
        begin
          TableParcelas.Edit;
          TableParcelas.FieldByName('DATA_PARCELA').AsDateTime := vTableParcelas.FieldByName('DATA_PARCELA').AsDateTime ;
          TableParcelas.FieldByName('VALOR_PARCELA').AsCurrency := vTableParcelas.FieldByName('VALOR_PARCELA').AsCurrency;
          TableParcelas.Post;
        end
        else
        begin
          TableParcelas.Insert;
          TableParcelas.FieldByName('NOTA_ID').AsInteger := vTableParcelas.FieldByName('NOTA_ID').AsInteger;
          TableParcelas.FieldByName('NOTAS_CONVENIO_ID').AsInteger := vTableParcelas.FieldByName('NOTAS_CONVENIO_ID').AsInteger;
          TableParcelas.FieldByName('NUMERO_PARCELA').AsInteger := vTableParcelas.FieldByName('NUMERO_PARCELA').AsInteger ;
          TableParcelas.FieldByName('DATA_PARCELA').AsDateTime := vTableParcelas.FieldByName('DATA_PARCELA').AsDateTime ;
          TableParcelas.FieldByName('VALOR_PARCELA').AsCurrency := vTableParcelas.FieldByName('VALOR_PARCELA').AsCurrency ;
          TableParcelas.Post;
        end;
        vTableParcelas.Next;
      End;

      TableParcelas.Transaction.StartTransaction;
      TableParcelas.ApplyUpdates;
      TableParcelas.Transaction.Commit;
    except
      TableParcelas.RestoreUpdates;
      TableParcelas.Transaction.Rollback;
      raise;
    end;
    TableParcelas.CommitUpdates;
  finally
    FreeAndNil(vTableParcelas);
    FreeAndNil(TableParcelas);
  end;
end;

function TUtilities.CalcularPagamentos(vfDBConn: TUniConnection; vfConvenioID,
  vfTotalParcelas: Integer; vfValorDocumento,
  vfValorEntrada: Currency): tp_result_rec_pagamentos;
var VALOR_ENTRADA, VALOR_DOCUMENTO, VALOR_PARCELA, VALOR_DIFF_PARCELAS : Currency;
    NUMERO_TOTAL_PARCELAS, VL_I, DIAS_PARCELAS : Integer;
    PARCELAMENTO : tp_result_rec_pagamentos;
    var QryAux, QryConvenio : TUniQuery;
begin
  VALOR_ENTRADA         := 0;
  VALOR_DOCUMENTO       := 0;
  VALOR_PARCELA         := 0;
  VALOR_DIFF_PARCELAS   := 0;
  NUMERO_TOTAL_PARCELAS := 0;
  DIAS_PARCELAS         := 0;

  QryConvenio :=  TUniQuery.Create(nil);
  QryConvenio.Connection := vfDBConn;
  QryConvenio.AutoCalcFields := True;
  QryConvenio.Options.AutoPrepare := True;
  QryConvenio.SQL.Clear;
  QryConvenio.SQL.Add(SQLGETCONVENIO + ' WHERE ID = :VCP00');
  QryConvenio.ParamByName('VCP00').AsInteger :=  vfConvenioID;
  if not QryConvenio.Prepared then QryConvenio.Prepare;
  QryConvenio.Open;

  if vfTotalParcelas > 0 then
    NUMERO_TOTAL_PARCELAS := vfTotalParcelas
  else
    NUMERO_TOTAL_PARCELAS := QryConvenio.FieldByName('MAXIMO_PARCELAS').AsInteger;

  if NUMERO_TOTAL_PARCELAS = 0 then
  begin
    SetLength(PARCELAMENTO,1);

    with PARCELAMENTO[0] do
    begin
      Id_Convenio             := vfConvenioID;
      Total_parcelas          := 1;
      Numero_Parcela          := 1;
      IsAvistaEntrada         := True;
      Data_Geracao            := Date();
      Data_Vencimento         := Date();
      Data_Multa              := 0;
      Valor_Multa             := 0;
      Valor_Juros             := 0;
      Valor_Total_Documento   := vfValorDocumento;
      Valor_Parcela           := vfValorDocumento;
    end;

  end
  else
  Begin

    if vfValorEntrada > 0 then
      VALOR_ENTRADA := vfValorEntrada
    else
      VALOR_ENTRADA := 0;



    SetLength(PARCELAMENTO, NUMERO_TOTAL_PARCELAS);

    VALOR_DOCUMENTO := vfValorDocumento  - VALOR_ENTRADA;

    // Retira a entrada para calcular as demais parcelas e a diferença entre elas
    if  (VALOR_ENTRADA > 0) and (NUMERO_TOTAL_PARCELAS > 1) then
        NUMERO_TOTAL_PARCELAS := NUMERO_TOTAL_PARCELAS - 1;

    VALOR_PARCELA := Round((VALOR_DOCUMENTO / NUMERO_TOTAL_PARCELAS) * 100) / 100;

    // Valor da diferença dos totais, Somando a diferença na ultima parcela.
    If (VALOR_PARCELA * NUMERO_TOTAL_PARCELAS) <> VALOR_DOCUMENTO then
      VALOR_DIFF_PARCELAS := VALOR_DOCUMENTO - (VALOR_PARCELA * NUMERO_TOTAL_PARCELAS);

    // Retorna a entrada
    if  (VALOR_ENTRADA > 0) and (NUMERO_TOTAL_PARCELAS > 1) then
        NUMERO_TOTAL_PARCELAS := NUMERO_TOTAL_PARCELAS + 1;

    { Neceessita revisar o calculo
    if NUMERO_TOTAL_PARCELAS <> QryConvenio.FieldByName('MAXIMO_PARCELAS').AsInteger then
      NUMERO_TOTAL_PARCELAS :=QryConvenio.FieldByName('MAXIMO_PARCELAS').AsInteger;}

    DIAS_PARCELAS :=  Self.GetReturnValue(
                                          vfDBConn,
                                          'al_condicoes_pagamento',
                                          'DIAS',
                                          ['ID'],
                                          [QryConvenio.FieldByName('CONDICAO_ID').AsInteger]
                                         );

    if  (VALOR_ENTRADA > 0) and (NUMERO_TOTAL_PARCELAS > 1) then
    begin
       //PARCELAMENTO[0]
    end;

    for VL_I := 1 to NUMERO_TOTAL_PARCELAS do
    begin

      if VL_I = NUMERO_TOTAL_PARCELAS then
      Begin
        VALOR_PARCELA := VALOR_PARCELA + VALOR_DIFF_PARCELAS;
      end;

      PARCELAMENTO[VL_I - 1].Id_Convenio  := vfConvenioID;
      PARCELAMENTO[VL_I - 1].Total_parcelas := NUMERO_TOTAL_PARCELAS;
      PARCELAMENTO[VL_I - 1].Numero_Parcela := VL_I;
      PARCELAMENTO[VL_I - 1].Valor_Total_Documento := VALOR_DOCUMENTO + VALOR_ENTRADA;

      if (VALOR_ENTRADA > 0) and (NUMERO_TOTAL_PARCELAS > 1) and (VL_I = 1) then
      begin
        PARCELAMENTO[VL_I - 1].Valor_Parcela := VALOR_ENTRADA;
        PARCELAMENTO[VL_I - 1].IsAvistaEntrada     := True;
      end
      else
      begin
        PARCELAMENTO[VL_I - 1].Valor_Parcela := VALOR_PARCELA;
        PARCELAMENTO[VL_I - 1].IsAvistaEntrada     := False;
      end;

      if PARCELAMENTO[VL_I - 1].IsAvistaEntrada then
      begin
        PARCELAMENTO[VL_I - 1].Data_Vencimento :=  Date();
      end
      else
      begin
        PARCELAMENTO[VL_I - 1].Data_Vencimento :=  Date() + DIAS_PARCELAS*VL_I;
      end;

      PARCELAMENTO[VL_I - 1].Data_Geracao := Date();
    end;
  end;
  Result := PARCELAMENTO;
end;

function TUtilities.GerarSQLSimples(DataSet: TUniQuery;
  TipoSQL: string): string;
var
  I: Integer;
  FieldsNames,ParamNames, Table : string;
begin
  try
    Table := GetTableNameFromSQL(DataSet.SQL.Text);
    FieldsNames := '';
    ParamNames  := '';
    DataSet.First;
    if (UpperCase(TipoSQL) = 'INSERT') or VarIsEmpty(TipoSQL) then
    Begin
      for I := 0 to DataSet.FieldCount-1 do
      begin
        if DataSet.Fields[I].FieldName <> 'ID' then
        Begin
          FieldsNames := FieldsNames +'`'+DataSet.Fields[I].FieldName +'`'+
                         ifthen((I<>DataSet.FieldCount-1),',','');

          ParamNames  := ParamNames  +':'+ DataSet.Fields[I].FieldName +
                         ifthen((I<>DataSet.FieldCount-1),',','');
        End;
        DataSet.Next;
      end;
    End;
  finally
    if FieldsNames <> '' then
      Result := 'INSERT INTO `'+Table+'` ('+FieldsNames+') VALUES ('+ParamNames+');'
    else
      Result := '';
  end;
end;

function TUtilities.GetCEPWS(vfCEP: string): rc_info_end;
var
  vl_rc_info_end: rc_info_end;
begin

  try
    try
      Application.CreateForm(TFrmGetICEPWS, FrmGetICEPWS);
      with FrmGetICEPWS do
      begin
        if vfCEP <> '' then
        begin
          EditCEP.Text := FormatarCNPJ(OnlyNumber(vfCEP));
          //fm_pnl_button_11.btn_select.Caption := 'Atualizar';
        end;
        FormStyle := fsNormal;
        ShowModal;
      end;
    except
      on e: Exception do
        ShowMessage('Não foi possivel abrir o formulário : ' + e.message);
    end;
  finally

    with vl_rc_info_end do
    begin
      flg_put_record    := FrmGetICEPWS.vgINFOENDERECO.flg_put_record;
      Cep               := FrmGetICEPWS.vgINFOENDERECO.Cep;
      Logradouro        := FrmGetICEPWS.vgINFOENDERECO.Logradouro;
      Complemento       := FrmGetICEPWS.vgINFOENDERECO.Complemento;
      Bairro            := FrmGetICEPWS.vgINFOENDERECO.Bairro;
      Localidade        := FrmGetICEPWS.vgINFOENDERECO.Localidade;
      IBGE_Municipio    := FrmGetICEPWS.vgINFOENDERECO.IBGE_Municipio;
      IBGE_UF           := FrmGetICEPWS.vgINFOENDERECO.IBGE_UF;
      Unidade           := FrmGetICEPWS.vgINFOENDERECO.Unidade;
      GIA               := FrmGetICEPWS.vgINFOENDERECO.GIA;
    end;
    FrmGetICEPWS := nil;
    Freeandnil(FrmGetICEPWS);
  end;

  Result := vl_rc_info_end;
end;

{function TUtilities.InfoEnitedPessoaSefaz(vf_tp_ent: pcn_type_entid;
  vf_num_cnpjcpf: string): rc_info_ent;
var
  vl_rc_info_ent: rc_info_ent;
  vl_i: Integer;
begin
 { if (vf_tp_ent = peIndef) and (vf_num_cnpjcpf = '') then
  begin
    try
      try
        Application.CreateForm(TFrmSelectPessoa, FrmSelectPessoa);
        with FrmSelectPessoa do
        begin
          FormStyle := fsNormal;
          ShowModal;
        end;
      except
        on e: System.SysUtils.Exception do
          ShowMessage('Não foi possivel abrir o formulário : ' + e.message);
      end;
    finally
      vf_tp_ent := FrmSelectPessoa.vg_type_ent;
      with FrmSelectPessoa do
      begin
        FrmSelectPessoa := nil;
        Freeandnil(FrmSelectPessoa);
      end;
    end;
  end;

  if vf_tp_ent = peFisica then
  begin
    try
      try
        Application.CreateForm(TFrmGetInfoCpf, FrmGetInfoCpf);
        with FrmGetInfoCpf do
        begin
          if vf_num_cnpjcpf <> '' then
          begin
            //fm_pnl_button_11.btn_select.Caption := 'Atualizar';
            medtCpf.Text := FormatarCPF(OnlyNumber(vf_num_cnpjcpf));
          end;
          FormStyle := fsNormal;
          ShowModal;
        end;
      except
        on e: Exception do
          ShowMessage('Não foi possivel abrir o formulário : ' + e.message);
      end;
    finally

      with vl_rc_info_ent do
      begin
        flg_put_record := FrmGetInfoCpf.vg_put_record;
        flg_tp_ent := peFisica;
        ent_cnpjcpf := FrmGetInfoCpf.medtCpf.Text;
        ent_tp_empresa := '';
        ent_data_nasc := FrmGetInfoCpf.medtDtNasc.Text;
        ent_data_abert := '';
        ent_mail := '';
        ent_efr := '';
        ent_nome_razsoc := FrmGetInfoCpf.edtRazaoSocial.Text;
        ent_nome_fant := '';
        ent_end_log := FrmGetInfoCpf.EdtEndereco.Text;
        ent_end_num := FrmGetInfoCpf.EdtNumero.Text;
        ent_end_compl := FrmGetInfoCpf.EdtComplemento.Text;
        ent_end_bairro := FrmGetInfoCpf.EdtBairro.Text;
        ent_end_uf := FrmGetInfoCpf.EdtUF.Text;
        ent_end_cep := FrmGetInfoCpf.medtCep.Text;
        ent_end_cid := FrmGetInfoCpf.EdtCidade.Text;
        ent_end_tel := '';
        ent_ibge_cid := FrmGetInfoCpf.edtCodCid.Text;
        ent_ibge_uf := FrmGetInfoCpf.edtCodUf.Text;
        ent_sit := FrmGetInfoCpf.edtSituacao.Text;
        ent_sit_mot := '';
        ent_cane_pri := '';
        ent_cane_sec.Clear;
      end;

      with FrmGetInfoCpf do
      begin

      end;
    end;

  end;

  if vf_tp_ent = peJuridica then
  begin
    try
      try
        Application.CreateForm(TFrmGetInfoCnpj, FrmGetInfoCnpj);
        with FrmGetInfoCnpj do
        begin
          if vf_num_cnpjcpf <> '' then
          begin
            EditCNPJ.Text := FormatarCNPJ(OnlyNumber(vf_num_cnpjcpf));
            //fm_pnl_button_11.btn_select.Caption := 'Atualizar';
          end;
          FormStyle := fsNormal;
          ShowModal;
        end;
      except
        on e: Exception do
          ShowMessage('Não foi possivel abrir o formulário : ' + e.message);
      end;
    finally

      with vl_rc_info_ent do
      begin
        flg_put_record := FrmGetInfoCnpj.vg_put_record;
        flg_tp_ent := peJuridica;
        ent_cnpjcpf := FrmGetInfoCnpj.EditCNPJ.Text;
        ent_tp_empresa := FrmGetInfoCnpj.EditTipo.Text;
        ent_data_nasc := '';
        ent_data_abert := FrmGetInfoCnpj.EditAbertura.Text;
        ent_mail := FrmGetInfoCnpj.EditEmail.Text;
        ent_efr := FrmGetInfoCnpj.edtEFR.Text;
        ent_nome_razsoc := FrmGetInfoCnpj.EditRazaoSocial.Text;
        if FrmGetInfoCnpj.EditFantasia.Text = '********' then
          ent_nome_fant := FrmGetInfoCnpj.EditRazaoSocial.Text
        else
          ent_nome_fant := FrmGetInfoCnpj.EditFantasia.Text;
        ent_end_log := FrmGetInfoCnpj.EditEndereco.Text;
        ent_end_num := FrmGetInfoCnpj.EditNumero.Text;
        ent_end_compl := FrmGetInfoCnpj.EditComplemento.Text;
        ent_end_bairro := FrmGetInfoCnpj.EditBairro.Text;
        ent_end_uf := FrmGetInfoCnpj.EditUF.Text;
        ent_end_cep := FrmGetInfoCnpj.EditCEP.Text;
        ent_end_cid := FrmGetInfoCnpj.EditCidade.Text;
        ent_end_tel := FrmGetInfoCnpj.EditTelefone.Text;
        ent_ibge_cid := FrmGetInfoCnpj.edtCodCid.Text;
        ent_ibge_uf := FrmGetInfoCnpj.edtCodUf.Text;
        ent_sit := FrmGetInfoCnpj.EditSituacao.Text;
        ent_sit_mot := FrmGetInfoCnpj.edtSitMot.Text;
        ent_cane_pri := FrmGetInfoCnpj.EditCNAE1.Text;

        //ent_cane_sec.Assign(FrmGetInfoCnpj.ListCNAE2.Items);
        ent_cane_sec.Assign(FrmGetInfoCnpj.ACBrConsultaCNPJ1.CNAE2);

      end;

      with FrmGetInfoCnpj do
      begin

      end;
    end;
  end;

  if vf_tp_ent = peIndef then
  begin
    with vl_rc_info_ent do
    begin
      flg_put_record := nsNao;
      flg_tp_ent := peIndef;
      ent_cnpjcpf := '';
      ent_tp_empresa := '';
      ent_data_nasc := '';
      ent_data_abert := '';
      ent_mail := '';
      ent_efr := '';
      ent_nome_razsoc := '';
      ent_nome_fant := '';
      ent_end_log := '';
      ent_end_num := '';
      ent_end_compl := '';
      ent_end_bairro := '';
      ent_end_uf := '';
      ent_end_cep := '';
      ent_end_cid := '';
      ent_end_tel := '';
      ent_ibge_cid := '';
      ent_ibge_uf := '';
      ent_sit := '';
      ent_sit_mot := '';
      ent_cane_pri := '';
      ent_cane_sec.Clear;
    end;
  end;

  Result := vl_rc_info_ent;

end;}

function TUtilities.InfoEnitedPessoaWS(vf_num_cnpjcpf: string): rc_info_ent;
var
  vl_rc_info_ent: rc_info_ent;
  vl_i: Integer;
begin

  try
    try
      Application.CreateForm(TFrmGetInfoCnpjWS, FrmGetInfoCnpjWS);
      with FrmGetInfoCnpjWS do
      begin
        if vf_num_cnpjcpf <> '' then
        begin
          EditCNPJ.Text := FormatarCNPJ(OnlyNumber(vf_num_cnpjcpf));
          //fm_pnl_button_11.btn_select.Caption := 'Atualizar';
        end;
        FormStyle := fsNormal;
        ShowModal;
      end;
    except
      on e: Exception do
        ShowMessage('Não foi possivel abrir o formulário : ' + e.message);
    end;
  finally

    with vl_rc_info_ent do
    begin
      flg_put_record  := FrmGetInfoCnpjWS.vgCONFIRMACAO;
      flg_tp_ent      := tpJuridica;
      ent_cnpjcpf     := FrmGetInfoCnpjWS.vgINFOENTIDADE.ent_cnpjcpf;
      ent_tp_empresa  := FrmGetInfoCnpjWS.vgINFOENTIDADE.ent_tp_empresa;
      ent_data_abertnasc   := '';
      ent_data_abertnasc  := FrmGetInfoCnpjWS.vgINFOENTIDADE.ent_data_abertnasc;
      ent_mail        := FrmGetInfoCnpjWS.vgINFOENTIDADE.ent_mail;
      ent_efr         := FrmGetInfoCnpjWS.vgINFOENTIDADE.ent_efr;
      ent_nome_razsoc := FrmGetInfoCnpjWS.vgINFOENTIDADE.ent_nome_razsoc;
      if FrmGetInfoCnpjWS.vgINFOENTIDADE.ent_nome_fant = '********' then
        ent_nome_fant := FrmGetInfoCnpjWS.vgINFOENTIDADE.ent_nome_razsoc
      else
        ent_nome_fant := FrmGetInfoCnpjWS.vgINFOENTIDADE.ent_nome_fant;
      ent_end_log     := FrmGetInfoCnpjWS.vgINFOENTIDADE.ent_end_log;
      ent_end_num     := FrmGetInfoCnpjWS.vgINFOENTIDADE.ent_end_num;
      ent_end_compl   := FrmGetInfoCnpjWS.vgINFOENTIDADE.ent_end_compl;
      ent_end_bairro  := FrmGetInfoCnpjWS.vgINFOENTIDADE.ent_end_bairro;
      ent_end_cep     := FrmGetInfoCnpjWS.vgINFOENTIDADE.ent_end_cep;
      ent_end_cid     := FrmGetInfoCnpjWS.vgINFOENTIDADE.ent_end_cid;
      ent_end_tel     := FrmGetInfoCnpjWS.vgINFOENTIDADE.ent_end_tel;
      ent_ibge_codcid    := FrmGetInfoCnpjWS.vgINFOENTIDADE.ent_ibge_codcid;
      ent_ibge_uf     := FrmGetInfoCnpjWS.vgINFOENTIDADE.ent_ibge_uf;
      ent_sit         := FrmGetInfoCnpjWS.vgINFOENTIDADE.ent_sit;
      ent_sit_mot     := FrmGetInfoCnpjWS.vgINFOENTIDADE.ent_sit_mot;
      ent_cane_pri    := '';
      //ent_cane_sec.Clear;
    end;

    FrmGetInfoCnpjWS := nil;
    Freeandnil(FrmGetInfoCnpjWS);
  end;

  Result := vl_rc_info_ent;

end;

function TUtilities.IsMatriz(vCNPJ: string): Boolean;
var vlComparacao : string;
begin
  //04150535000108
  vlComparacao := '';
  vCNPJ := OnlyNumber(vCNPJ);
  vlComparacao := Copy(vCNPJ,9,4);
  if StrToInt(vlComparacao) = 1 then
    Result := True
  else
    Result := False;
end;

function TUtilities.IsServer(vfSERVER:string):Boolean;
var Cryption : TCryption;
    vlSERVER : string;
begin
  try
    Cryption := TCryption.Create;
    vlSERVER := UpperCase(Cryption.Decrypt_Str(vfSERVER));
    if ( vlSERVER = 'LOCALHOST') or (vlSERVER = '127.0.0.1') then
    begin
      Result := True;
    end
    else
    begin
      Result := False;
    end;

  finally
    Cryption.free;
  end;
end;

function TUtilities.LoadPath(vf_pathrot: string;
  vf_list_path: array of string): Boolean;
var vl_numpaths : Integer;
    vl_1: Integer;
    vl_paths, vl_pathroot : string;
begin
  vl_numpaths := Length(vf_list_path);
  for vl_1 := 0 to vl_numpaths-1 do
  begin
    if not DirectoryExists(vf_pathrot+vf_list_path[vl_1]) then
     ForceDirectories(vf_pathrot+vf_list_path[vl_1]);
  end;
end;

function TUtilities.GetNextValue(vfDBConn: TUniConnection;
                                 vfTabela: string;
                                 vfField: string;
                                 vfFilterParamValue: array of const;
                                 vfFilterParamField: string = ''): integer;
var uQrySQL : TUniQuery;
    vlCondiction : string;
begin
  try
    vlCondiction := '';
    if vfFilterParamField <> '' then
    begin
      vlCondiction := ' WHERE '+vfFilterParamField+'='+VarRecToStr(vfFilterParamValue[0]);
    end;

    vfField := UpperCase(Trim(vfField));
    uQrySQL := TUniQuery.Create(nil);
    uQrySQL.Connection := vfDBConn;
    uQrySQL.SQL.Text := 'SELECT MAX('+vfField+') as VALUE FROM '+vfTabela+vlCondiction;
    if not uQrySQL.Prepared then uQrySQL.Prepare;
    uQrySQL.Execute;
    Result := uQrySQL.FieldByName('VALUE').AsInteger+1;
  finally
    uQrySQL.Close;
    FreeAndNil(uQrySQL);
  end;
end;

function TUtilities.RandomText(seed: integer; text: string): string;
var
  x, r, len: integer;
  c: char;
begin
  RandSeed := seed;
  len := Length(text);
  for x := 1 to len do
  begin
    r := Random(len) + 1;
    c := text[x];
    text[x] := text[r];
    text[r] := c;
  end;
  result := text;
end;

function TUtilities.RegisterBackupDB(vfDBConn: TUniConnection;
  vfFileBkp: string): Boolean;
var vlQryAux : TUniQuery;
    vlNunDoc : string;
    Cryption : TCryption;
begin
  Result := True;
  try
    try
      Cryption := TCryption.Create;
      vlNunDoc := OnlyNumber(ExtractFileName(vfFileBkp));

      if Length(vlNunDoc) = 11 then
        vlNunDoc := Self.AuthenticateDocs(docCPF,vlNunDoc).Doc_Formated
      else
        vlNunDoc := Self.AuthenticateDocs(docCNPJ,vlNunDoc).Doc_Formated;

      vlQryAux := TUniQuery.Create(nil);
      vlQryAux.Connection := vfDBConn;
      if vlQryAux.Active then vlQryAux.Close;
      vlQryAux.SQL.Clear;
      vlQryAux.SQL.Add(SQLPUTREGBACKUP);
      vlQryAux.ParamByName('VCP01').AsDateTime := Now();
      vlQryAux.ParamByName('VCP02').AsString   := vlNunDoc;
      vlQryAux.ParamByName('VCP03').AsString := '';
      vlQryAux.ParamByName('VCP04').AsString := Cryption.GetFileHashMD5F(vfFileBkp);
      vlQryAux.ParamByName('VCP05').AsBoolean := True;
      vlQryAux.ParamByName('VCP06').AsBoolean := True;
      vlQryAux.ParamByName('VCP07').AsBoolean := False;
      vlQryAux.ParamByName('VCP08').AsString := ExtractFileName(vfFileBkp);
      vlQryAux.ParamByName('VCP09').AsString := Self.GetFileSize(vfFileBkp);
      if not vlQryAux.Prepared then vlQryAux.Prepare;
      vlQryAux.Execute;
    except
      Result := False;
    end;
  finally
    vlQryAux.Close;
    FreeAndNil(Cryption);
    FreeAndNil(vlQryAux);
  end;

end;

function TUtilities.ServerIsOnline(vfDBConn: TUniConnection): Boolean;
begin
  try
    try
      if not vfDBConn.Connected then
      begin
        vfDBConn.Options.LocalFailover := True;
        vfDBConn.connect;
      end;
    except
      on E: EMySqlException do
      begin
        case E.ErrorCode of
          2013 : Self.ShowMessageEx('Importante...',
                                    'Falha na comunicação com o servidor, '+
                                    'Favor Tentar Novamente.',
                                    msStop);
        else
                 Self.ShowMessageEx('Importante...',
                                    'ErroCode: '+
                                    IntToStr(E.ErrorCode)+#13#10+
                                    E.Message,
                                    msStop);
        end;
      end;
    end;
  finally
    Result := vfDBConn.Connected;
  end;

end;

function TUtilities.SetCFGDephault(vfDBConnL: TUniConnection;
  vfCPFCNPJ: string): Boolean;
var  vlQryDest : TUniQuery;
     vlCNPJCPF, vlUFPessoa : string;
     vlIDPessoa : Integer;
     VariableSystem : TVariableSystem;
begin
  try
    try

      Result := True;
      VariableSystem := TVariableSystem.Create;

      vlCNPJCPF := OnlyNumber(vfCPFCNPJ);
      VariableSystem.vgPathPersonal := vlCNPJCPF;

      if Length(vlCNPJCPF) = 11 then
        vlCNPJCPF := Self.AuthenticateDocs(docCPF,vlCNPJCPF).Doc_Formated
      else
        vlCNPJCPF := Self.AuthenticateDocs(docCNPJ,vlCNPJCPF).Doc_Formated;

      vlIDPessoa := GetReturnValue(vfDBConnL,
                                   'pessoa',
                                   'ID',
                                   ['TIPO_PESSOA_ENTIDADE1','IDENT_CNPJCPF'],
                                   [1,vlCNPJCPF]);

      if not VarIsNull(vlIDPessoa) then
      begin
        if not Self.GetExistValue(vfDBConnL,
                                  'cfgsys',
                                  ['GERAL_PESSOA_ID'],
                                  [vlIDPessoa],
                                  ['']
                                  )
        then
        begin
          try
            vlUFPessoa := GetReturnValue(vfDBConnL,
                                   'pessoa',
                                   'END_UF',
                                   ['TIPO_PESSOA_ENTIDADE1','IDENT_CNPJCPF'],
                                   [1,vlCNPJCPF]);

            vlQryDest  := TUniQuery.Create(nil);
            vlQryDest.Connection :=  vfDBConnL;
            if vlQryDest.Active then vlQryDest.Close;
            vlQryDest.SQL.Clear;
            vlQryDest.SQL.Add(MYSQLGETCFGSYS+' WHERE `GERAL_PESSOA_ID`='+IntToStr(vlIDPessoa));
            if not vlQryDest.Prepared then vlQryDest.Prepare;
            vlQryDest.Open;
            if vlQryDest.IsEmpty then
            Begin
              vlQryDest.Insert;
              vlQryDest.FieldByName('GERAL_PESSOA_ID').AsInteger := vlIDPessoa;
              vlQryDest.FieldByName('MONITOR_MODO_TCP').AsBoolean := FALSE;
              vlQryDest.FieldByName('MONITOR_MODO_TXT').AsBoolean := FALSE;
              vlQryDest.FieldByName('MONITOR_MONITORAPASTA').AsBoolean := FALSE;
              vlQryDest.FieldByName('MONITOR_TCP_PORTA').AsInteger := 3434;
              vlQryDest.FieldByName('MONITOR_TCP_TIMEOUT').AsInteger := 10000;
              vlQryDest.FieldByName('MONITOR_CONVERTE_TCP_ANSI').AsBoolean := FALSE;
              vlQryDest.FieldByName('MONITOR_TXT_ENTRADA').AsString := 'ENT.TXT';
              vlQryDest.FieldByName('MONITOR_TXT_SAIDA').AsString := 'SAI.TXT';
              vlQryDest.FieldByName('MONITOR_CONVERTE_TXT_ENTRADA_ANSI').AsBoolean := FALSE;
              vlQryDest.FieldByName('MONITOR_CONVERTE_TXT_SAIDA_ANSI').AsBoolean := FALSE;
              vlQryDest.FieldByName('MONITOR_INTERVALO').AsInteger := 50;
              vlQryDest.FieldByName('MONITOR_GRAVAR_LOG').AsBoolean := FALSE;
              vlQryDest.FieldByName('MONITOR_ARQUIVO_LOG').AsString := 'LOG.TXT';
              vlQryDest.FieldByName('MONITOR_LINHAS_LOG').AsInteger := 0;
              vlQryDest.FieldByName('MONITOR_COMANDOS_REMOTOS').AsBoolean := FALSE;
              vlQryDest.FieldByName('MONITOR_UMA_INSTANCIA').AsBoolean := TRUE;
              vlQryDest.FieldByName('MONITOR_MOSTRAABAS').AsBoolean := FALSE;
              vlQryDest.FieldByName('MONITOR_MOSTRARNABARRADETAREFAS').AsBoolean := FALSE;
              vlQryDest.FieldByName('MONITOR_RETIRARACENTOSNARESPOSTA').AsBoolean := FALSE;
              vlQryDest.FieldByName('MONITOR_MOSTRALOGEMRESPOSTASENVIADAS').AsBoolean := TRUE;
              vlQryDest.FieldByName('MONITOR_HASHSENHA').AsString := '';
              vlQryDest.FieldByName('MONITOR_SENHA').AsString := '';
              vlQryDest.FieldByName('MONITOR_VERSAOSSL').AsInteger := 0;
              vlQryDest.FieldByName('ECF_MODELO').AsInteger := 0;
              vlQryDest.FieldByName('ECF_PORTA').AsString := 'PROCURAR';
              vlQryDest.FieldByName('ECF_SERIALPARAMS').AsString := '';
              vlQryDest.FieldByName('ECF_TIMEOUT').AsInteger := 3;
              vlQryDest.FieldByName('ECF_INTERVALOAPOSCOMANDO').AsInteger := 100;
              vlQryDest.FieldByName('ECF_MAXLINHASBUFFER').AsInteger := 0;
              vlQryDest.FieldByName('ECF_PAGINACODIGO').AsInteger := 0;
              vlQryDest.FieldByName('ECF_LINHASENTRECUPONS').AsInteger := 0;
              vlQryDest.FieldByName('ECF_ARREDONDAMENTOPORQTD').AsBoolean := FALSE;
              vlQryDest.FieldByName('ECF_ARREDONDAMENTOITEMMFD').AsBoolean := FALSE;
              vlQryDest.FieldByName('ECF_DESCRICAOGRANDE').AsBoolean := TRUE;
              vlQryDest.FieldByName('ECF_GAVETASINALINVERTIDO').AsBoolean := FALSE;
              vlQryDest.FieldByName('ECF_IGNORARTAGSFORMATACAO').AsBoolean := FALSE;
              vlQryDest.FieldByName('ECF_CONTROLEPORTA').AsBoolean := FALSE;
              vlQryDest.FieldByName('ECF_ARQLOG').AsString := '';
              vlQryDest.FieldByName('CHQ_MODELO').AsInteger := 0;
              vlQryDest.FieldByName('CHQ_PORTA').AsString := '';
              vlQryDest.FieldByName('CHQ_SERIALPARAMS').AsString := '';
              vlQryDest.FieldByName('CHQ_VERIFICAFORMULARIO').AsBoolean := FALSE;
              vlQryDest.FieldByName('CHQ_FAVORECIDO').AsString := '';
              vlQryDest.FieldByName('CHQ_CIDADE').AsString := '';
              vlQryDest.FieldByName('CHQ_PATHBEMAFIINI').AsString := '';
              vlQryDest.FieldByName('GAV_MODELO').AsInteger := 0;
              vlQryDest.FieldByName('GAV_PORTA').AsString := '';
              vlQryDest.FieldByName('GAV_STRINGABERTURA').AsString := '';
              vlQryDest.FieldByName('GAV_ABERTURAINTERVALO').AsInteger := 5000;
              vlQryDest.FieldByName('GAV_ACAOABERTURAANTECIPADA').AsInteger := 1;
              vlQryDest.FieldByName('DIS_MODELO').AsInteger := 0;
              vlQryDest.FieldByName('DIS_PORTA').AsString := '';
              vlQryDest.FieldByName('DIS_INTERVALO').AsInteger := 300;
              vlQryDest.FieldByName('DIS_PASSOS').AsInteger := 1;
              vlQryDest.FieldByName('DIS_INTERVALOENVIOBYTES').AsInteger := 3;
              vlQryDest.FieldByName('LCB_PORTA').AsString := 'SEMLEITOR';
              vlQryDest.FieldByName('LCB_INTERVALO').AsInteger := 100;
              vlQryDest.FieldByName('LCB_SUFIXOLEITOR').AsString := '#13';
              vlQryDest.FieldByName('LCB_EXCLUIRSUFIXO').AsBoolean := FALSE;
              vlQryDest.FieldByName('LCB_PREFIXOAEXCLUIR').AsString := '';
              vlQryDest.FieldByName('LCB_SUFIXOINCLUIR').AsString := '';
              vlQryDest.FieldByName('LCB_DISPOSITIVO').AsString := '';
              vlQryDest.FieldByName('LCB_TECLADO').AsBoolean := TRUE;
              vlQryDest.FieldByName('LCB_DEVICE').AsString := '';
              vlQryDest.FieldByName('RFD_GERARRFD').AsBoolean := FALSE;
              vlQryDest.FieldByName('RFD_DIRRFD').AsString := '';
              vlQryDest.FieldByName('RFD_IGNORAECF_MFD').AsBoolean := TRUE;
              vlQryDest.FieldByName('BAL_MODELO').AsInteger := 0;
              vlQryDest.FieldByName('BAL_PORTA').AsString := '';
              vlQryDest.FieldByName('BAL_INTERVALO').AsInteger := 200;
              vlQryDest.FieldByName('BAL_ARQLOG').AsString := '';
              vlQryDest.FieldByName('BAL_DEVICE').AsString := '';
              vlQryDest.FieldByName('ETQ_MODELO').AsInteger := 0;
              vlQryDest.FieldByName('ETQ_PORTA').AsString := '';
              vlQryDest.FieldByName('ETQ_DPI').AsInteger := 0;
              vlQryDest.FieldByName('ETQ_LIMPARMEMORIA').AsBoolean := TRUE;
              vlQryDest.FieldByName('ETQ_TEMPERATURA').AsInteger := 10;
              vlQryDest.FieldByName('ETQ_VELOCIDADE').AsInteger := -1;
              vlQryDest.FieldByName('ETQ_BACKFEED').AsInteger := -1;
              vlQryDest.FieldByName('ETQ_MARGEMESQUERDA').AsInteger := 10;
              vlQryDest.FieldByName('ETQ_ORIGEM').AsInteger := -1;
              vlQryDest.FieldByName('ETQ_UNIDADE').AsInteger := -1;
              vlQryDest.FieldByName('ETQ_COPIAS').AsInteger := 1;
              vlQryDest.FieldByName('ETQ_AVANCO').AsInteger := 0;
              vlQryDest.FieldByName('CEP_WEBSERVICE').AsInteger := 10;
              vlQryDest.FieldByName('CEP_WEBSERVICE_CHAVE').AsString := '';
              vlQryDest.FieldByName('CEP_WEBSERVICE_SENHA').AsString := '';
              vlQryDest.FieldByName('CEP_PROXY_HOST').AsString := '';
              vlQryDest.FieldByName('CEP_PROXY_PORT').AsString := '';
              vlQryDest.FieldByName('CEP_PROXY_USER').AsString := '';
              vlQryDest.FieldByName('CEP_PROXY_PASS').AsString := '';
              vlQryDest.FieldByName('CEP_IBGEACENTOS').AsBoolean := FALSE;
              vlQryDest.FieldByName('CEP_IBGEUTF8').AsBoolean := FALSE;
              vlQryDest.FieldByName('TC_MODELO').AsInteger := 0;
              vlQryDest.FieldByName('TC_TCP_PORTA').AsInteger := 6500;
              vlQryDest.FieldByName('TC_ARQ_PRECOS').AsString := 'PRICETAB.TXT';
              vlQryDest.FieldByName('TC_NAO_ECONTRADO').AsString := 'PRODUTO|NAOENCONTRADO';
              vlQryDest.FieldByName('SEDEX_CONTRATO').AsString := '';
              vlQryDest.FieldByName('SEDEX_SENHASEDEX').AsString := '';
              vlQryDest.FieldByName('NCM_DIRNCMSALVAR').AsString := '';
              vlQryDest.FieldByName('EMAIL_NOMEEXIBICAO').AsString := '';
              vlQryDest.FieldByName('EMAIL_ENDERECO').AsString := '';
              vlQryDest.FieldByName('EMAIL_EMAIL').AsString := '';
              vlQryDest.FieldByName('EMAIL_USUARIO').AsString := '';
              vlQryDest.FieldByName('EMAIL_SENHA').AsString := '';
              vlQryDest.FieldByName('EMAIL_PORTA').AsInteger := 0;
              vlQryDest.FieldByName('EMAIL_EXIGESSL').AsBoolean := FALSE;
              vlQryDest.FieldByName('EMAIL_EXIGETLS').AsBoolean := FALSE;
              vlQryDest.FieldByName('EMAIL_CONFIRMACAO').AsBoolean := FALSE;
              vlQryDest.FieldByName('EMAIL_SEGUNDOPLANO').AsBoolean := FALSE;
              vlQryDest.FieldByName('EMAIL_CODIFICACAO').AsString := '';
              vlQryDest.FieldByName('DFE_IGNORARCOMANDOMODOEMISSAO').AsBoolean := FALSE;
              vlQryDest.FieldByName('DFE_MODOXML').AsBoolean := FALSE;
              vlQryDest.FieldByName('DFE_RETIRARACENTOS').AsBoolean := TRUE;
              vlQryDest.FieldByName('DFE_GRAVAR_LOG_COMP').AsBoolean := FALSE;
              vlQryDest.FieldByName('DFE_ARQUIVO_LOG_COMP').AsString := 'LOG_COMP.TXT';
              vlQryDest.FieldByName('DFE_LINHAS_LOG_COMP').AsInteger := 0;
              vlQryDest.FieldByName('DFE_ARQUIVOWEBSERVICES').AsString := VariableSystem.GetIniPathDFESERVICES+'ACBRNFESERVICOS.INI';
              vlQryDest.FieldByName('DFE_ARQUIVOWEBSERVICESCTE').AsString := VariableSystem.GetIniPathDFESERVICES+'ACBRCTESERVICOS.INI';
              vlQryDest.FieldByName('DFE_ARQUIVOWEBSERVICESMDFE').AsString := VariableSystem.GetIniPathDFESERVICES+'ACBRMDFESERVICOS.INI';
              vlQryDest.FieldByName('DFE_ARQUIVOWEBSERVICESGNRE').AsString := VariableSystem.GetIniPathDFESERVICES+'ACBRGNRESERVICOS.INI';
              vlQryDest.FieldByName('DFE_ARQUIVOWEBSERVICESESOCIAL').AsString := VariableSystem.GetIniPathDFESERVICES+'ACBRESOCIALSERVICOS.INI';
              vlQryDest.FieldByName('DFE_ARQUIVOWEBSERVICESREINF').AsString := VariableSystem.GetIniPathDFESERVICES+'ACBRREINFSERVICOS.INI';
              vlQryDest.FieldByName('DFE_VALIDARDIGEST').AsBoolean := TRUE;
              vlQryDest.FieldByName('DFE_TIMEOUTWEBSERVICE').AsInteger := 15;
              vlQryDest.FieldByName('DFE_CERTIFICADO_SSLLIB').AsInteger := 4;
              vlQryDest.FieldByName('DFE_CERTIFICADO_CRYPTLIB').AsInteger := 3;
              vlQryDest.FieldByName('DFE_CERTIFICADO_HTTPLIB').AsInteger := 2;
              vlQryDest.FieldByName('DFE_CERTIFICADO_XMLSIGNLIB').AsInteger := 4;
              vlQryDest.FieldByName('DFE_CERTIFICADO_SSLTYPE').AsInteger := 0;
              vlQryDest.FieldByName('DFE_CERTIFICADO_ARQUIVOPFX').AsString := '';
              vlQryDest.FieldByName('DFE_CERTIFICADO_NUMEROSERIE').AsString := '';
              vlQryDest.FieldByName('DFE_CERTIFICADO_SENHA').AsString := '';
              vlQryDest.FieldByName('DFE_CERTIFICADO_EXIBERAZAOSOCIALCERTIFICADO').AsBoolean := FALSE;
              vlQryDest.FieldByName('DFE_CERTIFICADO_VERIFICARVALIDADE').AsBoolean := FALSE;
              vlQryDest.FieldByName('DFE_IMPRESSAO_GERALDANFE').AsInteger := 0;
              vlQryDest.FieldByName('DFE_IMPRESSAO_GERALFORMAEMISSAO').AsInteger := 0;
              vlQryDest.FieldByName('DFE_IMPRESSAO_GERAL_LOGO_EMPRESA').AsString := '';
              vlQryDest.FieldByName('DFE_IMPRESSAO_GERAL_LOGO_PREFEITURA').AsString := '';
              vlQryDest.FieldByName('DFE_IMPRESSAO_GERALLOGOMARCANFCESAT').AsString := '';
              vlQryDest.FieldByName('DFE_IMPRESSAO_GERALSALVAR').AsBoolean := TRUE;
              vlQryDest.FieldByName('DFE_IMPRESSAO_GERALPATHSALVAR').AsString := VariableSystem.GetSystemPathLOG;
              vlQryDest.FieldByName('DFE_IMPRESSAO_GERALIMPRESSORA').AsString := '0';
              vlQryDest.FieldByName('DFE_WEBSERVICE_VERSAO').AsString := '3';
              vlQryDest.FieldByName('DFE_WEBSERVICE_SSLTYPE').AsInteger := 5;
              vlQryDest.FieldByName('DFE_WEBSERVICE_VERSAOCTE').AsString := '3.00';
              vlQryDest.FieldByName('DFE_WEBSERVICE_VERSAOMDFE').AsString := '3.00';
              vlQryDest.FieldByName('DFE_WEBSERVICE_VERSAOESOCIAL').AsString := '02_04_02';
              vlQryDest.FieldByName('DFE_WEBSERVICE_VERSAOREINF').AsString := '1_03_02';
              vlQryDest.FieldByName('DFE_WEBSERVICE_VERSAOQRCODE').AsString := '0';
              vlQryDest.FieldByName('DFE_WEBSERVICE_MODELODF').AsInteger := 0;
              vlQryDest.FieldByName('DFE_WEBSERVICE_FORMAEMISSAONFE').AsInteger := 0;
              vlQryDest.FieldByName('DFE_WEBSERVICE_FORMAEMISSAOCTE').AsInteger := 0;
              vlQryDest.FieldByName('DFE_WEBSERVICE_FORMAEMISSAOGNRE').AsInteger := 0;
              vlQryDest.FieldByName('DFE_WEBSERVICE_FORMAEMISSAOMDFE').AsInteger := 0;
              vlQryDest.FieldByName('DFE_WEBSERVICE_AMBIENTE').AsInteger := 1;
              vlQryDest.FieldByName('DFE_WEBSERVICE_UF').AsString := vlUFPessoa;
              vlQryDest.FieldByName('DFE_WEBSERVICE_VISUALIZAR_MSN').AsBoolean := FALSE;
              vlQryDest.FieldByName('DFE_WEBSERVICE_AJUSTARAUT').AsBoolean := FALSE;
              vlQryDest.FieldByName('DFE_WEBSERVICE_AGUARDAR').AsString := '0';
              vlQryDest.FieldByName('DFE_WEBSERVICE_TENTATIVAS').AsString := '5';
              vlQryDest.FieldByName('DFE_WEBSERVICE_INTERVALO').AsString := '0';
              vlQryDest.FieldByName('DFE_WEBSERVICE_TIMEZONEMODE').AsInteger := 0;
              vlQryDest.FieldByName('DFE_WEBSERVICE_TIMEZONESTR').AsString := '';
              vlQryDest.FieldByName('DFE_WEBSERVICE_CAMPOSFATOBRIG').AsBoolean := TRUE;
              vlQryDest.FieldByName('DFE_WEBSERVICE_PROXY_HOST').AsString := '';
              vlQryDest.FieldByName('DFE_WEBSERVICE_PROXY_PORTA').AsString := '';
              vlQryDest.FieldByName('DFE_WEBSERVICE_PROXY_USER').AsString := '';
              vlQryDest.FieldByName('DFE_WEBSERVICE_PROXY_PASS').AsString := '';
              vlQryDest.FieldByName('DFE_WEBSERVICE_NFCE_IDTOKEN').AsString := '';
              vlQryDest.FieldByName('DFE_WEBSERVICE_NFCE_TOKEN').AsString := '';
              vlQryDest.FieldByName('DFE_WEBSERVICE_NFCE_TAGQRCODE').AsBoolean := TRUE;
              vlQryDest.FieldByName('DFE_WEBSERVICE_NFCE_USARINTEGRADOR').AsBoolean := FALSE;
              vlQryDest.FieldByName('DFE_EMAIL_MENSAGEMNFE').Clear;
              vlQryDest.FieldByName('DFE_EMAIL_ASSUNTONFE').Clear;
              vlQryDest.FieldByName('DFE_EMAIL_MENSAGEMCTE').Clear;
              vlQryDest.FieldByName('DFE_EMAIL_ASSUNTOCTE').Clear;
              vlQryDest.FieldByName('DFE_EMAIL_MENSAGEMMDFE').Clear;
              vlQryDest.FieldByName('DFE_EMAIL_ASSUNTOMDFE').Clear;
              vlQryDest.FieldByName('DFE_WEBSERVICE_NFE_CNPJCONTADOR').AsString := '';
              vlQryDest.FieldByName('DFE_IMPRESSAO_NFCE_EMISSAO_MODELO').AsInteger := 4;
              vlQryDest.FieldByName('DFE_IMPRESSAO_NFCE_EMISSAO_MODOIMPRESSAOEVENTO').AsInteger := 0;
              vlQryDest.FieldByName('DFE_IMPRESSAO_NFCE_EMISSAO_IMPRIMIRITEM1LINHA').AsBoolean := TRUE;
              vlQryDest.FieldByName('DFE_IMPRESSAO_NFCE_EMISSAO_IMPRIMIRDESCACRESITEM').AsBoolean := TRUE;
              vlQryDest.FieldByName('DFE_IMPRESSAO_NFCE_EMISSAO_IMPRESSORAPADRAO').AsString := '0';
              vlQryDest.FieldByName('DFE_IMPRESSAO_NFCE_EMISSAO_QRCODELATERAL').AsBoolean := TRUE;
              vlQryDest.FieldByName('DFE_IMPRESSAO_NFCE_EMISSAO_USACODIGOEANIMPRESSAO').AsBoolean := FALSE;
              vlQryDest.FieldByName('DFE_IMPRESSAO_NFCE_EMISSAO_IMPRIMENOMEFANTASIA').AsBoolean := FALSE;
              vlQryDest.FieldByName('DFE_IMPRESSAO_NFCE_EMISSAO_DANFCE_MARGEMINF').AsFloat := 0.8;
              vlQryDest.FieldByName('DFE_IMPRESSAO_NFCE_EMISSAO_DANFCE_MARGEMSUP').AsFloat := 0.8;
              vlQryDest.FieldByName('DFE_IMPRESSAO_NFCE_EMISSAO_DANFCE_MARGEMDIR').AsFloat := 0.51;
              vlQryDest.FieldByName('DFE_IMPRESSAO_NFCE_EMISSAO_DANFCE_MARGEMESQ').AsFloat := 0.6;
              vlQryDest.FieldByName('DFE_IMPRESSAO_NFCE_EMISSAO_DANFCE_LARGURABOBINA').AsInteger := 302;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_MODELO').AsInteger := 0;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_TAMANHOPAPEL').AsInteger := 0;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_SITE').AsString := '';
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_EMAIL').AsString := '';
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_FAX').AsString := '';
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_IMPDESCPORC').AsBoolean := TRUE;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_MOSTRARPREVIEW').AsBoolean := FALSE;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_COPIAS').AsInteger := 1;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_LARGURACODIGOPRODUTO').AsInteger := 40;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_ESPESSURABORDA').AsInteger := 1;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_FONTERAZAO').AsInteger := 12;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_FONTEENDERECO').AsInteger := 10;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_FONTECAMPOS').AsInteger := 10;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_ALTURACAMPOS').AsInteger := 30;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_MARGEM').AsFloat := 0.8;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_MARGEMSUP').AsFloat := 0.8;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_MARGEMDIR').AsFloat := 0.51;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_MARGEMESQ').AsFloat := 0.6;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_PATHPDF').AsString := VariableSystem.GetSystemPathPDF;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_DECIMAISQTD').AsInteger := 2;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_DECIMAISVALOR').AsInteger := 2;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_EXIBERESUMO').AsBoolean := FALSE;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_IMPRIMIRTRIBUTOSITEM').AsBoolean := FALSE;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_IMPRIMIRVALLIQ').AsBoolean := FALSE;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_UNCOMERCIALETRIBUTAVEL').AsInteger := 0;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_PREIMPRESSO').AsBoolean := FALSE;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_MOSTRARSTATUS').AsBoolean := FALSE;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_EXIBIREAN').AsBoolean := FALSE;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_EXIBIRCAMPOFATURA').AsBoolean := TRUE;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_EXPANDIRLOGO').AsBoolean := FALSE;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_FONTE').AsInteger := 0;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_LOCALCANHOTO').AsInteger := 0;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_QUEBRARLINHASDETALHEITENS').AsBoolean := FALSE;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_IMPRIMIRDETALHAMENTOESPECIFICO').AsBoolean := TRUE;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_IMPRIMIRDADOSDOCREFERENCIADOS').AsBoolean := TRUE;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_EXIBIRBANDINFORADICPRODUTO').AsInteger := 0;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DANFE_LOGOEMCIMA').AsBoolean := FALSE;
              vlQryDest.FieldByName('DFE_IMPRESSAO_DACTE_TAMANHOPAPEL').AsInteger := 0;
              vlQryDest.FieldByName('DFE_DIRETORIOS_FLG_SALVAR').AsBoolean := TRUE;
              vlQryDest.FieldByName('DFE_DIRETORIOS_FLG_PASTAMENSAL').AsBoolean := TRUE;
              vlQryDest.FieldByName('DFE_DIRETORIOS_FLG_ADDLITERAL').AsBoolean := TRUE;
              vlQryDest.FieldByName('DFE_DIRETORIOS_FLG_EMISSAOPATH').AsBoolean := TRUE;
              vlQryDest.FieldByName('DFE_DIRETORIOS_FLG_SALVARCCECANPATHEVENTO').AsBoolean := TRUE;
              vlQryDest.FieldByName('DFE_DIRETORIOS_FLG_SEPARARPORCNPJ').AsBoolean := TRUE;
              vlQryDest.FieldByName('DFE_DIRETORIOS_FLG_SEPARARPORMODELO').AsBoolean := TRUE;
              vlQryDest.FieldByName('DFE_DIRETORIOS_FLG_SALVARAPENASNFESAUTORIZADAS').AsBoolean := FALSE;
              vlQryDest.FieldByName('DFE_DIRETORIOS_FLG_ATUALIZARXMLCANCELADO').AsBoolean := TRUE;
              vlQryDest.FieldByName('DFE_DIRETORIOS_FLG_NORMATIZARMUNICIPIOS').AsBoolean := TRUE;
              vlQryDest.FieldByName('DFE_DIRETORIOS_FLG_USARSEPARADORPATHPDF').AsBoolean := TRUE;
              vlQryDest.FieldByName('DFE_DIRETORIOS_PATHNFE').AsString := VariableSystem.GetXmlPathDFE;
              vlQryDest.FieldByName('DFE_DIRETORIOS_PATHINU').AsString := VariableSystem.GetXmlPathDFE;
              vlQryDest.FieldByName('DFE_DIRETORIOS_PATHDPEC').AsString := VariableSystem.GetXmlPathDFE;
              vlQryDest.FieldByName('DFE_DIRETORIOS_PATHEVENTO').AsString := VariableSystem.GetXmlPathDFE;
              vlQryDest.FieldByName('DFE_DIRETORIOS_PATHCCE').AsString := VariableSystem.GetXmlPathDFE;
              vlQryDest.FieldByName('DFE_DIRETORIOS_PATHARQTXT').AsString := VariableSystem.GetXmlPathDFE+'TXT';
              vlQryDest.FieldByName('DFE_ESOCIAL_IDEMPREGADOR').AsString := '';
              vlQryDest.FieldByName('DFE_ESOCIAL_IDTRANSMISSOR').AsString := '';
              vlQryDest.FieldByName('DFE_ESOCIAL_TIPOEMPREGADOR').AsString := 'TEPESSOAJURIDICA';
              vlQryDest.FieldByName('DFE_REINF_IDCONTRIBUINTE').AsString := '';
              vlQryDest.FieldByName('DFE_REINF_IDTRANSMISSOR').AsString := '';
              vlQryDest.FieldByName('DFE_REINF_TIPOCONTRIBUINTE').AsString := 'TCPESSOAJURIDICA';
              vlQryDest.FieldByName('SAT_MODELO').AsInteger := 0;
              vlQryDest.FieldByName('SAT_ARQLOG').AsString := 'ACBRSAT.LOG';
              vlQryDest.FieldByName('SAT_NOMEDLL').AsString := VariableSystem.GetSystemPathBIN+'SAT\EMULADOR\SAT.DLL';
              vlQryDest.FieldByName('SAT_CODIGOATIVACAO').AsString := '123456';
              vlQryDest.FieldByName('SAT_CODIGOUF').AsString := '35';
              vlQryDest.FieldByName('SAT_NUMEROCAIXA').AsInteger := 1;
              vlQryDest.FieldByName('SAT_AMBIENTE').AsInteger := 1;
              vlQryDest.FieldByName('SAT_PAGINADECODIGO').AsInteger := 0;
              vlQryDest.FieldByName('SAT_VERSAODADOSENT').AsFloat := 0.07;
              vlQryDest.FieldByName('SAT_FORMATARXML').AsBoolean := TRUE;
              vlQryDest.FieldByName('SAT_PATHCFE').AsString := VariableSystem.GetXmlPathCFE+PATHDELIM+'SAT';
              vlQryDest.FieldByName('SAT_SALVARCFE').AsBoolean := TRUE;
              vlQryDest.FieldByName('SAT_SALVARCFECANC').AsBoolean := TRUE;
              vlQryDest.FieldByName('SAT_SALVARENVIO').AsBoolean := TRUE;
              vlQryDest.FieldByName('SAT_SEPARARPORCNPJ').AsBoolean := TRUE;
              vlQryDest.FieldByName('SAT_SEPARARPORMES').AsBoolean := TRUE;
              vlQryDest.FieldByName('SAT_SATIMPRESSAO_SATEXTRATO_PARAMSSTRING').AsString := '';
              vlQryDest.FieldByName('SAT_SATIMPRESSAO_SATEXTRATO_IMPRIMEDESCACRESCITEM').AsBoolean := TRUE;
              vlQryDest.FieldByName('SAT_SATIMPRESSAO_SATEXTRATO_IMPRIMEEMUMALINHA').AsBoolean := FALSE;
              vlQryDest.FieldByName('SAT_SATIMPRESSAO_SATEXTRATO_IMPRIMECHAVEEMUMALINHA').AsInteger := 0;
              vlQryDest.FieldByName('SAT_SATIMPRESSAO_SATEXTRATO_USACODIGOEANIMPRESSAO').AsBoolean := FALSE;
              vlQryDest.FieldByName('SAT_SATIMPRESSAO_SATEXTRATO_IMPRIMEQRCODELATERAL').AsBoolean := TRUE;
              vlQryDest.FieldByName('SAT_SATIMPRESSAO_SATEXTRATO_IMPRIMELOGOLATERAL').AsBoolean := TRUE;
              vlQryDest.FieldByName('SAT_SATIMPRESSAO_SATEMIT_CNPJ').AsString := '';
              vlQryDest.FieldByName('SAT_SATIMPRESSAO_SATEMIT_IE').AsString := '';
              vlQryDest.FieldByName('SAT_SATIMPRESSAO_SATEMIT_IM').AsString := '';
              vlQryDest.FieldByName('SAT_SATIMPRESSAO_SATEMIT_REGTRIBUTARIO').AsInteger := 0;
              vlQryDest.FieldByName('SAT_SATIMPRESSAO_SATEMIT_REGTRIBISSQN').AsInteger := 0;
              vlQryDest.FieldByName('SAT_SATIMPRESSAO_SATEMIT_INDRATISSQN').AsInteger := 0;
              vlQryDest.FieldByName('SAT_SATIMPRESSAO_SATFORTES_USARFORTES').AsBoolean := TRUE;
              vlQryDest.FieldByName('SAT_SATIMPRESSAO_SATFORTES_LARGURA').AsInteger := 302;
              vlQryDest.FieldByName('SAT_SATIMPRESSAO_SATFORTES_MARGEMTOPO').AsInteger := 2;
              vlQryDest.FieldByName('SAT_SATIMPRESSAO_SATFORTES_MARGEMFUNDO').AsInteger := 4;
              vlQryDest.FieldByName('SAT_SATIMPRESSAO_SATFORTES_MARGEMESQUERDA').AsInteger := 2;
              vlQryDest.FieldByName('SAT_SATIMPRESSAO_SATFORTES_MARGEMDIREITA').AsInteger := 2;
              vlQryDest.FieldByName('SAT_SATIMPRESSAO_SATFORTES_PREVIEW').AsBoolean := TRUE;
              vlQryDest.FieldByName('SAT_SATIMPRESSAO_SATPRINTER_NAME').AsString := '';
              vlQryDest.FieldByName('SAT_SATREDE_TIPOINTER').AsInteger := 0;
              vlQryDest.FieldByName('SAT_SATREDE_TIPOLAN').AsInteger := 0;
              vlQryDest.FieldByName('SAT_SATREDE_SSID').AsString := '';
              vlQryDest.FieldByName('SAT_SATREDE_SEG').AsInteger := 0;
              vlQryDest.FieldByName('SAT_SATREDE_CODIGO').AsString := '';
              vlQryDest.FieldByName('SAT_SATREDE_LANIP').AsString := '';
              vlQryDest.FieldByName('SAT_SATREDE_LANMASK').AsString := '';
              vlQryDest.FieldByName('SAT_SATREDE_LANGW').AsString := '';
              vlQryDest.FieldByName('SAT_SATREDE_LANDNS1').AsString := '';
              vlQryDest.FieldByName('SAT_SATREDE_LANDNS2').AsString := '';
              vlQryDest.FieldByName('SAT_SATREDE_USUARIO').AsString := '';
              vlQryDest.FieldByName('SAT_SATREDE_SENHA').AsString := '';
              vlQryDest.FieldByName('SAT_SATREDE_PROXY').AsInteger := 0;
              vlQryDest.FieldByName('SAT_SATREDE_PROXY_IP').AsString := '';
              vlQryDest.FieldByName('SAT_SATREDE_PROXY_PORTA').AsInteger := 0;
              vlQryDest.FieldByName('SAT_SATREDE_PROXY_USER').AsString := '';
              vlQryDest.FieldByName('SAT_SATREDE_PROXY_SENHA').AsString := '';
              vlQryDest.FieldByName('SAT_SATSWH_CNPJ').AsString := '';
              vlQryDest.FieldByName('SAT_SATSWH_ASSINATURA').AsString := '';
              vlQryDest.FieldByName('INTEGRADORFISCAL_INPUT').AsString := VariableSystem.GetSystemPathINT+'INPUT\';
              vlQryDest.FieldByName('INTEGRADORFISCAL_OUTPUT').AsString := VariableSystem.GetSystemPathINT+'OUTPUT\';
              vlQryDest.FieldByName('INTEGRADORFISCAL_TIMEOUT').AsInteger := 30;
              vlQryDest.FieldByName('POSPRINTER_MODELO').AsInteger := 0;
              vlQryDest.FieldByName('POSPRINTER_PORTA').AsString := '';
              vlQryDest.FieldByName('POSPRINTER_COLUNAS').AsInteger := 48;
              vlQryDest.FieldByName('POSPRINTER_ESPACOENTRELINHAS').AsInteger := 0;
              vlQryDest.FieldByName('POSPRINTER_LINHASBUFFER').AsInteger := 0;
              vlQryDest.FieldByName('POSPRINTER_LINHASPULAR').AsInteger := 4;
              vlQryDest.FieldByName('POSPRINTER_PAGINADECODIGO').AsInteger := 0;
              vlQryDest.FieldByName('POSPRINTER_CONTROLEPORTA').AsBoolean := FALSE;
              vlQryDest.FieldByName('POSPRINTER_CORTARPAPEL').AsBoolean := TRUE;
              vlQryDest.FieldByName('POSPRINTER_TRADUZIRTAGS').AsBoolean := TRUE;
              vlQryDest.FieldByName('POSPRINTER_IGNORARTAGS').AsBoolean := FALSE;
              vlQryDest.FieldByName('POSPRINTER_ARQLOG').AsString := '';
              vlQryDest.FieldByName('POSPRINTER_SERIALPARAMS').AsString := '';
              vlQryDest.FieldByName('POSPRINTER_CODIGOBARRAS_LARGURA').AsInteger := 0;
              vlQryDest.FieldByName('POSPRINTER_CODIGOBARRAS_ALTURA').AsInteger := 0;
              vlQryDest.FieldByName('POSPRINTER_CODIGOBARRAS_HRI').AsBoolean := FALSE;
              vlQryDest.FieldByName('POSPRINTER_QRCODE_TIPO').AsInteger := 2;
              vlQryDest.FieldByName('POSPRINTER_QRCODE_LARGURAMODULO').AsInteger := 4;
              vlQryDest.FieldByName('POSPRINTER_QRCODE_ERRORLEVEL').AsInteger := 0;
              vlQryDest.FieldByName('POSPRINTER_LOGO_IMPRIMIR').AsBoolean := FALSE;
              vlQryDest.FieldByName('POSPRINTER_LOGO_KC1').AsInteger := 48;
              vlQryDest.FieldByName('POSPRINTER_LOGO_KC2').AsInteger := 48;
              vlQryDest.FieldByName('POSPRINTER_LOGO_FATORX').AsInteger := 2;
              vlQryDest.FieldByName('POSPRINTER_LOGO_FATORY').AsInteger := 2;
              vlQryDest.FieldByName('POSPRINTER_GAVETA_TEMPOON').AsInteger := 50;
              vlQryDest.FieldByName('POSPRINTER_GAVETA_TEMPOOFF').AsInteger := 200;
              vlQryDest.FieldByName('POSPRINTER_GAVETA_SINALINVERTIDO').AsBoolean := FALSE;
              vlQryDest.FieldByName('BOLETO_NOME').AsString := '';
              vlQryDest.FieldByName('BOLETO_CNPJCPF').AsString := '';
              vlQryDest.FieldByName('BOLETO_LOGRADOURO').AsString := '';
              vlQryDest.FieldByName('BOLETO_NUMERO').AsString := '';
              vlQryDest.FieldByName('BOLETO_BAIRRO').AsString := '';
              vlQryDest.FieldByName('BOLETO_CIDADE').AsString := '';
              vlQryDest.FieldByName('BOLETO_CEP').AsString := '';
              vlQryDest.FieldByName('BOLETO_COMPLEMENTO').AsString := '';
              vlQryDest.FieldByName('BOLETO_UF').AsString := '';
              vlQryDest.FieldByName('BOLETO_CONTA_RESPEMIS').AsInteger := -1;
              vlQryDest.FieldByName('BOLETO_CONTA_PESSOA').AsInteger := -1;
              vlQryDest.FieldByName('BOLETO_CONTA_MODALIDADE').AsString := '';
              vlQryDest.FieldByName('BOLETO_CONTA_CONVENIO').AsString := '';
              vlQryDest.FieldByName('BOLETO_CONTA_BANCO').AsInteger := 1;
              vlQryDest.FieldByName('BOLETO_CONTA_CONTA').AsString := '';
              vlQryDest.FieldByName('BOLETO_CONTA_DIGITOCONTA').AsString := '';
              vlQryDest.FieldByName('BOLETO_CONTA_AGENCIA').AsString := '';
              vlQryDest.FieldByName('BOLETO_CONTA_DIGITOAGENCIA').AsString := '';
              vlQryDest.FieldByName('BOLETO_CONTA_CODCEDENTE').AsString := '';
              vlQryDest.FieldByName('BOLETO_CONTA_LOCALPAGAMENTO').AsString := '';
              vlQryDest.FieldByName('BOLETO_LAYOUT_DIRLOGOS').AsString := VariableSystem.GetSystemPathIMG+'BOL\LOGOS';
              vlQryDest.FieldByName('BOLETO_LAYOUT_COPIAS').AsInteger := 1;
              vlQryDest.FieldByName('BOLETO_LAYOUT_PREVIEW').AsBoolean := TRUE;
              vlQryDest.FieldByName('BOLETO_LAYOUT_PROGRESSO').AsBoolean := TRUE;
              vlQryDest.FieldByName('BOLETO_LAYOUT_SETUP').AsBoolean := TRUE;
              vlQryDest.FieldByName('BOLETO_LAYOUT_LAYOUT').AsInteger := 0;
              vlQryDest.FieldByName('BOLETO_LAYOUT_FILTRO').AsInteger := 0;
              vlQryDest.FieldByName('BOLETO_LAYOUT_DIRARQUIVOBOLETO').AsString := '';
              vlQryDest.FieldByName('BOLETO_LAYOUT_NOMEARQUIVOBOLETO').AsString := '';
              vlQryDest.FieldByName('BOLETO_LAYOUT_IMPRESSORA').AsString := '';
              vlQryDest.FieldByName('BOLETO_REMESSARETORNO_DIRARQUIVOREMESSA').AsString := '';
              vlQryDest.FieldByName('BOLETO_REMESSARETORNO_DIRARQUIVORETORNO').AsString := '';
              vlQryDest.FieldByName('BOLETO_REMESSARETORNO_CNAB').AsInteger := 0;
              vlQryDest.FieldByName('BOLETO_REMESSARETORNO_LERCEDENTERETORNO').AsBoolean := FALSE;
              vlQryDest.FieldByName('BOLETO_REMESSARETORNO_CODTRANSMISSAO').AsString := '';
              vlQryDest.FieldByName('BOLETO_REMESSARETORNO_REMOVEACENTOS').AsBoolean := FALSE;
              vlQryDest.FieldByName('BOLETO_RELATORIO_MOSTRAPREVIEWRELRETORNO').AsBoolean := TRUE;
              vlQryDest.FieldByName('BOLETO_RELATORIO_LOGOEMPRESA').AsString := '';
              vlQryDest.FieldByName('BOLETO_EMAIL_EMAILASSUNTOBOLETO').AsString := '';
              vlQryDest.FieldByName('BOLETO_EMAIL_EMAILMENSAGEMBOLETO').Clear;
              vlQryDest.FieldByName('GERAL_ARQ_BACKUP').AsString := VariableSystem.GetSystemPathBKP;
              vlQryDest.FieldByName('GERAL_ARQ_BACKUP_SECOND').AsString := '';
              vlQryDest.FieldByName('GERAL_ARQ_BACKUP_XML').AsString := VariableSystem.GetSystemPathBKP;

              vlQryDest.Post;
            End;
          except
            Result := False;
          end;
        end
        else
        begin
          Result := True;
        end;
      end;
    except
       Result := False;
    end;
  finally
    FreeAndNil(VariableSystem);
    FreeAndNil(vlQryDest);
  end;

end;

function TUtilities.SetEnvVarValue(const VarName,
  VarValue: string): Integer;
begin
  // Simply call API function
  if SetEnvironmentVariable(PChar(VarName),
    PChar(VarValue)) then
    Result := 0
  else
    Result := GetLastError;
end;

function TUtilities.SetFileNameBackup: string;
var vlFileName : string;
begin
  vlFileName := 'DB'
end;

function TUtilities.ShowMessageEx(vfTitle, vfMessage: string;
  vfIcomImage: pcn_messageicom; vfWindowType:pcn_window_type = wtAlert):Boolean;
begin
  try
    Result := False;
    FrmShowMessageEx := TFrmShowMessageEx.Create(Application);
    with FrmShowMessageEx do
    begin
      vgTitle     := vfTitle;
      vgMessage   := vfMessage;

      case vfIcomImage of
        msHelp     : vgIconImage := 0;
        msNote     : vgIconImage := 1;
        msAtention : vgIconImage := 2;
        msStop     : vgIconImage := 3;
      end;

      if vfWindowType <> wtAlert then
      Begin
        BtnOK.Caption := 'SIM';
        BtnExit.Caption := 'NÃO';
        vgCondiction := True;
      End;

    end;
    FrmShowMessageEx.ShowModal;
  finally
    Result := FrmShowMessageEx.vgConfirmation;
    FreeAndNil(FrmShowMessageEx);
  end;
end;

procedure TUtilities.ShowMessagePanel(msn: string; action_window: pcn_form_show);
begin
  if (action_window = sfShow) or (action_window = sfModal)then
  begin
    if (frmStatusMsm = nil) then
      frmStatusMsm := TfrmStatusMsm.Create(Application);
    frmStatusMsm.lblStatus.Caption := msn;
    if action_window = sfShow then
      frmStatusMsm.Show
    else
      frmStatusMsm.ShowModal;
    frmStatusMsm.BringToFront;
    frmStatusMsm.Refresh;
    frmStatusMsm.Repaint;
  end
  else
  begin
    if (frmStatusMsm <> nil) then
    begin
      frmStatusMsm.Hide;
      frmStatusMsm.Close;
      Freeandnil(frmStatusMsm);
    end;
  end;
end;

function TUtilities.SQLPrepareArrayString(vfArrayString: TArray<String>): string;
var I : Integer;
    vlStr : string;
begin
  vlStr := '';
  for I := 0 to Length(vfArrayString)-1 do
  begin
    vlStr := vlStr + QuotedStr(vfArrayString[I]) + IfThen( I < Length(vfArrayString)-1,',','');
  end;
  Result := vlStr;
end;

function TUtilities.SyncDW_EquipamentoWS(vfDBConnL, vfDBConnW: TUniConnection;
  vfCONTRATOID: integer): Boolean;
var
  vlQryOrig, vlQryDest : TUniQuery;
  I : Integer;
  vlINSVALUESQL, vlDUPKEYVALUESQL : string;
begin
  try
    Result := True;
    vlINSVALUESQL := '';
    vlDUPKEYVALUESQL := '';
    if vfDBConnW.Connected then vfDBConnW.Close;

    vlQryOrig  := TUniQuery.Create(nil);
    vlQryOrig.Connection :=  vfDBConnW;
    vlQryOrig.AutoCalcFields := True;
    vlQryOrig.CachedUpdates := True;

    vlQryDest  := TUniQuery.Create(nil);
    vlQryDest.Connection :=  vfDBConnL;

    vlQryOrig.SQL.Add(SQLGETEQUIPAMENTO+' WHERE `licence_equipamento`.`CONTRATO_ID` = :VCP00 ');
    vlQryOrig.ParamByName('VCP00').AsInteger :=  vfCONTRATOID;

    if not vlQryOrig.Prepared then vlQryOrig.Prepare;
    vlQryOrig.Execute;

    if vlQryOrig.IsEmpty then
    Begin
      Result := False;
      Abort;
    End;

    vlQryOrig.First;

    for I := 0 to vlQryOrig.RecordCount-1 do
    begin
      vlINSVALUESQL := vlINSVALUESQL +
                       '('+vlQryOrig.FieldByName('CONTRATO_ID').AsString+','+
                       QuotedStr(vlQryOrig.FieldByName('MAC_ADRESS').AsString)+','+
                       QuotedStr(vlQryOrig.FieldByName('IP_ADRESS').AsString)+','+
                       QuotedStr(vlQryOrig.FieldByName('MAQUINA').AsString)+','+
                       QuotedStr(vlQryOrig.FieldByName('OS').AsString)+','+
                       QuotedStr(vlQryOrig.FieldByName('VER_SYS').AsString)+','+
                       QuotedStr(vlQryOrig.FieldByName('VER_ARQ').AsString)+','+
                       QuotedStr(formatdatetime('YYYY/mm/dd',vlQryOrig.FieldByName('LAST_ACCESS_LICENCE').AsDateTime))+','+
                       QuotedStr(vlQryOrig.FieldByName('KEYMACHINE').AsString) + IfThen(I < vlQryOrig.RecordCount-1,'),',') ');
      vlQryOrig.Next;
    end;


    vlDUPKEYVALUESQL := 'MAC_ADRESS =  VALUES (MAC_ADRESS),'+
                        'IP_ADRESS =  VALUES (IP_ADRESS),'+
                        'MAQUINA =  VALUES (MAQUINA),'+
                        'OS =  VALUES (OS),'+
                        'VER_SYS =  VALUES (VER_SYS),'+
                        'VER_ARQ =  VALUES (VER_ARQ),'+
                        'LAST_ACCESS_LICENCE =  VALUES (LAST_ACCESS_LICENCE);';

    vlQryDest.SQL.Add(SQLPUTEQUIPAMENTO+vlINSVALUESQL+' ON DUPLICATE KEY UPDATE '+vlDUPKEYVALUESQL);

    if not vlQryDest.Prepared then vlQryDest.Prepare;

    if Self.ServerIsOnline(vfDBConnL) then
    begin
       try
         vlQryDest.Execute;
         Result := True;
       except
         Result := False;
       end;
    end;
  finally
    if vlQryDest.Active then vlQryDest.Close;
    if vlQryOrig.Active then vlQryOrig.Close;
    if vfDBConnW.Connected then vfDBConnW.Close;
    vlQryDest.Free;
    vlQryOrig.Free;
  end;

end;

function TUtilities.SyncDW_LicenceWS(vfDBConnL, vfDBConnW: TUniConnection;
  fvIDLIC:Integer; vfCPFCNPJ, SERIAL: string): Boolean;
var
  vlQryOrig, vlQryDest : TUniQuery;
begin
  try
    Result := True;
    if vfDBConnW.Connected then vfDBConnW.Close;

    vlQryOrig  := TUniQuery.Create(nil);
    vlQryOrig.Connection :=  vfDBConnW;
    vlQryOrig.AutoCalcFields := True;
    vlQryOrig.CachedUpdates := True;

    vlQryDest  := TUniQuery.Create(nil);
    vlQryDest.Connection :=  vfDBConnL;

    vlQryOrig.SQL.Add(SQLGETLICENCE+' WHERE  `licence`.`CPFCNPJ` = :VCP00 AND `licence`.`KEY18` = :VCP01 ');
    vlQryOrig.ParamByName('VCP00').AsString :=  vfCPFCNPJ;
    vlQryOrig.ParamByName('VCP01').AsString :=  SERIAL;
    if not vlQryOrig.Prepared then vlQryOrig.Prepare;
    vlQryOrig.Execute;

    if vlQryOrig.IsEmpty then
    Begin
      Result := False;
      Abort;
    End;

    vlQryDest.SQL.Add(SQL_UDP_DWLICENCEWS);

    if vlQryOrig.FieldByName('KEY11').IsNull or (vlQryOrig.FieldByName('KEY11').AsString =  '30/12/1899') then
       vlQryDest.ParamByName('KEY11').Clear
    else
        vlQryDest.ParamByName('KEY11').AsDateTime   := vlQryOrig.FieldByName('KEY11').AsDateTime;

    vlQryDest.ParamByName('KEY12').AsInteger   := vlQryOrig.FieldByName('KEY12').AsInteger;
    vlQryDest.ParamByName('KEY16').AsString   := vlQryOrig.FieldByName('KEY16').AsString;
    vlQryDest.ParamByName('KEY17').AsString   := vlQryOrig.FieldByName('KEY17').AsString;
    vlQryDest.ParamByName('KEY19').AsString   := vlQryOrig.FieldByName('KEY19').AsString;
    vlQryDest.ParamByName('KEY21').AsInteger  := vlQryOrig.FieldByName('KEY21').AsInteger;
    vlQryDest.ParamByName('KEY22').AsInteger  := vlQryOrig.FieldByName('KEY22').AsInteger;
    vlQryDest.ParamByName('KEY23').AsInteger  := vlQryOrig.FieldByName('KEY23').AsInteger;
    vlQryDest.ParamByName('KEY24').AsInteger := vlQryOrig.FieldByName('KEY24').AsInteger;
    vlQryDest.ParamByName('KEY25').AsInteger := vlQryOrig.FieldByName('KEY25').AsInteger;
    vlQryDest.ParamByName('KEY26').AsInteger := vlQryOrig.FieldByName('KEY26').AsInteger;
    vlQryDest.ParamByName('KEY27').AsInteger := vlQryOrig.FieldByName('KEY27').AsInteger;
    vlQryDest.ParamByName('KEY28').AsInteger := vlQryOrig.FieldByName('KEY28').AsInteger;
    vlQryDest.ParamByName('KEY29').AsInteger := vlQryOrig.FieldByName('KEY29').AsInteger;
    vlQryDest.ParamByName('KEY30').AsInteger := vlQryOrig.FieldByName('KEY30').AsInteger;
    vlQryDest.ParamByName('KEY31').AsInteger := vlQryOrig.FieldByName('KEY31').AsInteger;
    vlQryDest.ParamByName('KEY32').AsInteger := vlQryOrig.FieldByName('KEY32').AsInteger;
    vlQryDest.ParamByName('KEY33').AsInteger := vlQryOrig.FieldByName('KEY33').AsInteger;
    vlQryDest.ParamByName('KEY35').AsInteger := vlQryOrig.FieldByName('KEY35').AsInteger;

    vlQryDest.ParamByName('VCP00').AsInteger  := fvIDLIC;

    if not vlQryDest.Prepared then vlQryDest.Prepare;

    if Self.ServerIsOnline(vfDBConnL) then
    begin
       try
         vlQryDest.Execute;
         Result := True;
       except
         Result := False;
       end;
    end;
  finally
    if vlQryDest.Active then vlQryDest.Close;
    if vlQryOrig.Active then vlQryOrig.Close;
    if vfDBConnW.Connected then vfDBConnW.Close;
    vlQryDest.Free;
    vlQryOrig.Free;
  end;

end;

function TUtilities.SyncPessoaWS(vfDBConnL, vfDBConnW: TUniConnection;
  vfCPFCNPJ: string): Boolean;
var
  vlQryOrig, vlQryDest : TUniQuery;
begin

end;

function TUtilities.SyncUP_LicenceWS(vfDBConnL, vfDBConnW: TUniConnection;
  fvIDLIC:Integer; vfCPFCNPJ, vfSERIALSYS: string): Boolean;
var
  vlQryOrig, vlQryDest : TUniQuery;
begin
  try
    Result := True;
    if vfDBConnW.Connected then vfDBConnW.Close;

    vlQryOrig  := TUniQuery.Create(nil);
    vlQryOrig.Connection :=  vfDBConnL;

    vlQryDest  := TUniQuery.Create(nil);
    vlQryDest.Connection :=  vfDBConnW;
    vlQryDest.AutoCalcFields := True;
    vlQryDest.CachedUpdates := True;

    vlQryOrig.SQL.Add(SQLGETLICENCE+' WHERE `licence`.`ID` = :VCP00');
    vlQryOrig.ParamByName('VCP00').AsInteger :=  fvIDLIC;
    if not vlQryOrig.Prepared then vlQryOrig.Prepare;
    vlQryOrig.Execute;

    if vlQryOrig.IsEmpty then
    Begin
      Result := False;
      Abort;
    End;

    vlQryDest.SQL.Add(SQL_UDP_UPLICENCEWS);
    vlQryDest.ParamByName('KEY1').AsInteger   := vlQryOrig.FieldByName('KEY1').AsInteger;
    vlQryDest.ParamByName('KEY2').AsInteger   := vlQryOrig.FieldByName('KEY2').AsInteger;

    if vlQryOrig.FieldByName('KEY3').IsNull or (vlQryOrig.FieldByName('KEY3').AsString =  '30/12/1899') then
       vlQryDest.ParamByName('KEY3').Clear
    else
        vlQryDest.ParamByName('KEY3').AsDateTime   := vlQryOrig.FieldByName('KEY3').AsDateTime;


    if vlQryOrig.FieldByName('KEY4').IsNull or (vlQryOrig.FieldByName('KEY4').AsString =  '30/12/1899') then
       vlQryDest.ParamByName('KEY4').Clear
    else
        vlQryDest.ParamByName('KEY4').AsDateTime   := vlQryOrig.FieldByName('KEY4').AsDateTime;

    vlQryDest.ParamByName('KEY5').AsInteger   := vlQryOrig.FieldByName('KEY5').AsInteger;
    vlQryDest.ParamByName('KEY6').AsInteger   := vlQryOrig.FieldByName('KEY6').AsInteger;
    vlQryDest.ParamByName('KEY7').AsInteger   := vlQryOrig.FieldByName('KEY7').AsInteger;
    vlQryDest.ParamByName('KEY8').AsInteger   := vlQryOrig.FieldByName('KEY8').AsInteger;
    vlQryDest.ParamByName('KEY13').AsInteger  := vlQryOrig.FieldByName('KEY13').AsInteger;
    vlQryDest.ParamByName('KEY14').AsInteger  := vlQryOrig.FieldByName('KEY14').AsInteger;

    if vlQryOrig.FieldByName('KEY15').IsNull or (vlQryOrig.FieldByName('KEY15').AsString =  '30/12/1899') then
       vlQryDest.ParamByName('KEY15').Clear
    else
        vlQryDest.ParamByName('KEY15').AsDateTime   := vlQryOrig.FieldByName('KEY15').AsDateTime;

    vlQryDest.ParamByName('KEY20').AsInteger := vlQryOrig.FieldByName('KEY20').AsInteger;
    vlQryDest.ParamByName('KEY34').AsInteger := vlQryOrig.FieldByName('KEY34').AsInteger;
    vlQryDest.ParamByName('KEY35').AsInteger := vlQryOrig.FieldByName('KEY35').AsInteger;
    vlQryDest.ParamByName('KEY36').AsInteger := vlQryOrig.FieldByName('KEY36').AsInteger;
    vlQryDest.ParamByName('KEY37').AsInteger := vlQryOrig.FieldByName('KEY37').AsInteger;
    vlQryDest.ParamByName('KEY38').AsInteger := vlQryOrig.FieldByName('KEY38').AsInteger;
    vlQryDest.ParamByName('KEY39').AsInteger := vlQryOrig.FieldByName('KEY39').AsInteger;
    vlQryDest.ParamByName('KEY40').AsInteger := vlQryOrig.FieldByName('KEY40').AsInteger;
    vlQryDest.ParamByName('KEY41').AsInteger := vlQryOrig.FieldByName('KEY41').AsInteger;
    vlQryDest.ParamByName('KEY42').AsInteger := vlQryOrig.FieldByName('KEY42').AsInteger;
    vlQryDest.ParamByName('KEY43').AsInteger := vlQryOrig.FieldByName('KEY43').AsInteger;
    vlQryDest.ParamByName('KEY44').AsInteger := vlQryOrig.FieldByName('KEY44').AsInteger;
    vlQryDest.ParamByName('KEY45').AsInteger := vlQryOrig.FieldByName('KEY45').AsInteger;
    vlQryDest.ParamByName('KEY46').AsInteger := vlQryOrig.FieldByName('KEY46').AsInteger;
    vlQryDest.ParamByName('KEY47').AsInteger := vlQryOrig.FieldByName('KEY47').AsInteger;
    vlQryDest.ParamByName('KEY48').AsInteger := vlQryOrig.FieldByName('KEY48').AsInteger;
    vlQryDest.ParamByName('KEY49').AsInteger := vlQryOrig.FieldByName('KEY49').AsInteger;
    vlQryDest.ParamByName('KEY50').AsInteger := vlQryOrig.FieldByName('KEY50').AsInteger;
    vlQryDest.ParamByName('KEY51').AsInteger := vlQryOrig.FieldByName('KEY51').AsInteger;
    vlQryDest.ParamByName('KEY52').AsInteger := vlQryOrig.FieldByName('KEY52').AsInteger;
    vlQryDest.ParamByName('KEY53').AsInteger := vlQryOrig.FieldByName('KEY53').AsInteger;
    vlQryDest.ParamByName('KEY54').AsInteger := vlQryOrig.FieldByName('KEY54').AsInteger;
    vlQryDest.ParamByName('KEY55').AsInteger := vlQryOrig.FieldByName('KEY55').AsInteger;
    vlQryDest.ParamByName('KEY56').AsInteger := vlQryOrig.FieldByName('KEY56').AsInteger;
    vlQryDest.ParamByName('KEY57').AsInteger := vlQryOrig.FieldByName('KEY57').AsInteger;
    vlQryDest.ParamByName('KEY58').AsInteger := vlQryOrig.FieldByName('KEY58').AsInteger;
    vlQryDest.ParamByName('KEY59').AsInteger := vlQryOrig.FieldByName('KEY59').AsInteger;
    vlQryDest.ParamByName('KEY60').AsInteger := vlQryOrig.FieldByName('KEY60').AsInteger;
    vlQryDest.ParamByName('KEY61').AsInteger := vlQryOrig.FieldByName('KEY61').AsInteger;
    vlQryDest.ParamByName('KEY62').AsInteger := vlQryOrig.FieldByName('KEY62').AsInteger;
    vlQryDest.ParamByName('KEY63').AsInteger := vlQryOrig.FieldByName('KEY63').AsInteger;
    vlQryDest.ParamByName('KEY64').AsInteger := vlQryOrig.FieldByName('KEY64').AsInteger;
    vlQryDest.ParamByName('KEY65').AsInteger := vlQryOrig.FieldByName('KEY65').AsInteger;
    vlQryDest.ParamByName('KEY66').AsInteger := vlQryOrig.FieldByName('KEY66').AsInteger;
    vlQryDest.ParamByName('KEY67').AsInteger := vlQryOrig.FieldByName('KEY67').AsInteger;
    vlQryDest.ParamByName('KEY68').AsInteger := vlQryOrig.FieldByName('KEY68').AsInteger;
    vlQryDest.ParamByName('KEY69').AsInteger := vlQryOrig.FieldByName('KEY69').AsInteger;
    vlQryDest.ParamByName('KEY70').AsInteger := vlQryOrig.FieldByName('KEY70').AsInteger;
    vlQryDest.ParamByName('KEY71').AsInteger := vlQryOrig.FieldByName('KEY71').AsInteger;
    vlQryDest.ParamByName('KEY72').AsInteger := vlQryOrig.FieldByName('KEY72').AsInteger;
    vlQryDest.ParamByName('CONTRATO_NUMERO').AsInteger := vlQryOrig.FieldByName('CONTRATO_NUMERO').AsInteger;
    vlQryDest.ParamByName('VCP00').AsString := vfCPFCNPJ;
    vlQryDest.ParamByName('VCP01').AsString := vfSERIALSYS;

    if not vlQryDest.Prepared then vlQryDest.Prepare;

    if Self.ServerIsOnline(vfDBConnW) then
    begin
       try
         vlQryDest.Execute;
         Result := True;
       except
         Result := False;
       end;
    end;
  finally
    if vlQryDest.Active then vlQryDest.Close;
    if vlQryOrig.Active then vlQryOrig.Close;
    if vfDBConnW.Connected then vfDBConnW.Close;
    vlQryDest.Free;
    vlQryOrig.Free;
  end;

end;

function TUtilities.ShowFormSearch(vf_dbconnection : TUniConnection;
                                   vf_id_grid, vf_title_form, vf_script_sql:string;
                                   vf_title_columns: array of string;
                                   vf_sgdb_sorce : string = 'LOCAL'): rc_search;
var
  vl_rc_searc : rc_search;
  vl_i: Integer;
begin

  if (vf_title_form <> '') and (vf_script_sql <> '') then
  begin
    try
      try
        Application.CreateForm(TFrmSearch, FrmSearch);
        with FrmSearch do
        begin
          if vf_sgdb_sorce <> 'LOCAL' then
          begin
            //
          end;

          UQrySearch.Connection :=  vf_dbconnection;

          SetLength(vg_title_columns, length(vf_title_columns));

          for vl_i := low(vf_title_columns) to high(vf_title_columns) do
          begin
            vg_title_columns[vl_i] := vf_title_columns[vl_i];
          end;
          vg_id_grid := vf_id_grid;
          lbl_titleform.Caption := vf_title_form;
          if UQrySearch.Active then UQrySearch.Close;
          UQrySearch.SQL.Clear;
          UQrySearch.SQL.Text := vf_script_sql;
          //WindowState := wsMaximized;
          //FormStyle := fsStayOnTop;
          FormStyle := fsStayOnTop;

          ShowModal;
        end;
      except
        on e: Exception do
          ShowMessage('Não foi possivel abrir o formulário : ' + e.message);
      end;
    finally

      with vl_rc_searc do
      begin
        array_field_value := FrmSearch.vg_result.array_field_value;
      end;

      Result := vl_rc_searc;

      if FrmSearch <> nil then
      Begin
        Freeandnil(FrmSearch);
        FrmSearch := nil;
      End;
    end;
  end;
end;

// With CreateProcess:
//*****************************************************

{1}

function TUtilities.WinExecAndWait32(FileName: string; Visibility: Integer): Longword;
var { by Pat Ritchey }
  zAppName: array[0..512] of Char;
  zCurDir: array[0..255] of Char;
  WorkDir: string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  StrPCopy(zAppName, FileName);
  GetDir(0, WorkDir);
  StrPCopy(zCurDir, WorkDir);
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.cb          := SizeOf(StartupInfo);
  StartupInfo.dwFlags     := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := Visibility;
  if not CreateProcess(nil,
    zAppName, // pointer to command line string
    nil, // pointer to process security attributes
    nil, // pointer to thread security attributes
    False, // handle inheritance flag
    CREATE_NEW_CONSOLE or // creation flags
    NORMAL_PRIORITY_CLASS,
    nil, //pointer to new environment block
    nil, // pointer to current directory name
    StartupInfo, // pointer to STARTUPINFO
    ProcessInfo) // pointer to PROCESS_INF
    then Result := WAIT_FAILED
  else
  begin
    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
    GetExitCodeProcess(ProcessInfo.hProcess, Result);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end;
  {Exemplo de uso
    procedure TForm1.Button1Click(Sender: TObject);
    begin
      WinExecAndWait32('notepad.exe', False, True);
    end;}
end; { WinExecAndWait32 }




{*******************************}

// {2} "Anti-Freezing":

function TUtilities.EspelharRegistro(vfDBConn: TUniConnection;
                                     TabelaMaster:string;
                                     IdTabelaMaster:Integer;
                                     TabelaDetail:array of string;
                                     FiledNameRelDetail:array of string;
                                     ImputMasterField: array of string;
                                     ImputMasterFieldTitle: array of string;
                                     ImputMasterFieldDefault: array of string;
                                     ImputMasterValuesDefault: array of const) : Boolean;
var
  RegistroOrigemMaster, RegistroDestinoMaster,
  RegistroOrigemDetail, RegistroDestinoDetail : TUniQuery;
  SQLDestinoMaster : string;
  SQLDestinoDetail : array of string;
  ImputMasterValues: TArrayofString;
  I,X : Integer;
begin
  try
    try
      Result := True;

      RegistroOrigemMaster  := TUniQuery.Create(nil);
      RegistroDestinoMaster := TUniQuery.Create(nil);
      RegistroOrigemDetail  := TUniQuery.Create(nil);
      RegistroDestinoDetail := TUniQuery.Create(nil);

      RegistroOrigemMaster.Connection := vfDBConn;
      RegistroOrigemMaster.AutoCalcFields := True;
      RegistroOrigemMaster.Options.AutoPrepare := True;

      RegistroDestinoMaster.Assign(RegistroOrigemMaster);
      RegistroOrigemDetail.Assign(RegistroOrigemMaster);
      RegistroDestinoDetail.Assign(RegistroOrigemMaster);

      RegistroOrigemMaster.SQL.Add('select * from '+TabelaMaster+' where ID = '+IntToStr(IdTabelaMaster));
      if not RegistroOrigemMaster.Prepared then RegistroOrigemMaster.Prepare;
      RegistroOrigemMaster.Open;

      SetLength(SQLDestinoDetail,Length(TabelaDetail));

      for X := Low(TabelaDetail) to High(TabelaDetail) do
      begin

        if RegistroOrigemDetail.Active then RegistroOrigemDetail.Close;
        RegistroOrigemDetail.SQL.Clear;

        RegistroOrigemDetail.SQL.Add('select * from '+TabelaDetail[X]+' where '+FiledNameRelDetail[X]+' = '+IntToStr(IdTabelaMaster));
        if not RegistroOrigemDetail.Prepared then RegistroOrigemDetail.Prepare;
        RegistroOrigemDetail.Open;

        if not RegistroOrigemDetail.IsEmpty then
        begin
          SQLDestinoDetail[X] :=  GerarSQLSimples(RegistroOrigemDetail);
        end;
      end;

      if not RegistroOrigemMaster.IsEmpty then
      begin
        SQLDestinoMaster :=  GerarSQLSimples(RegistroOrigemMaster);


        if ImputMasterField[0] <> '' then
        begin
          SetLength(ImputMasterValues,Length(ImputMasterField));

          if InputQuery('Favor preencher os seguintes campos',ImputMasterFieldTitle,ImputMasterValues) then
          begin
            for I := Low(ImputMasterValues) to High(ImputMasterValues) do
            begin
              if VarToStr(ImputMasterValues[I]) = '' then
              Begin
                ShowMessage(ImputMasterFieldTitle[I]);
                Abort;
              end;
            end;
          end;

        end;

      end
      else
      begin
        ShowMessage('Não foi possível localizar o registro para o espelhamento.');
        Result := False;
      end;

    except on E: EMySqlException do
        begin
          ShowMessage('Houve um erro ao espelhar o registro.'+#13#10+'Error: '+E.Message);
          Result := False;
        end;
    end;
  finally
    FreeAndNil(RegistroOrigemMaster);
    FreeAndNil(RegistroDestinoMaster);
    FreeAndNil(RegistroOrigemDetail);
    FreeAndNil(RegistroDestinoDetail);
  end;
end;

function TUtilities.ExecAndWait(const FileName: string; const CmdShow: Integer): Longword;
var { by Pat Ritchey }
  zAppName: array[0..512] of Char;
  zCurDir: array[0..255] of Char;
  WorkDir: string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  AppIsRunning: DWORD;
begin
  StrPCopy(zAppName, FileName);
  GetDir(0, WorkDir);
  StrPCopy(zCurDir, WorkDir);
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.cb          := SizeOf(StartupInfo);
  StartupInfo.dwFlags     := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := CmdShow;
  if not CreateProcess(nil,
    zAppName, // pointer to command line string
    nil, // pointer to process security attributes
    nil, // pointer to thread security attributes
    False, // handle inheritance flag
    CREATE_NEW_CONSOLE or // creation flags
    NORMAL_PRIORITY_CLASS,
    nil, //pointer to new environment block
    nil, // pointer to current directory name
    StartupInfo, // pointer to STARTUPINFO
    ProcessInfo) // pointer to PROCESS_INF
    then Result := WAIT_FAILED
  else
  begin
    while WaitForSingleObject(ProcessInfo.hProcess, 0) = WAIT_TIMEOUT do
    begin
      Application.ProcessMessages;
      Sleep(50);
    end;
    {
    // or:
    repeat
      AppIsRunning := WaitForSingleObject(ProcessInfo.hProcess, 100);
      Application.ProcessMessages;
      Sleep(50);
    until (AppIsRunning <> WAIT_TIMEOUT);
    }

    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
    GetExitCodeProcess(ProcessInfo.hProcess, Result);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end;
  {Exemplo de Uso
   procedure TForm1.Button1Click(Sender: TObject);
    begin
      ExecAndWait('C:\Programme\WinZip\WINZIP32.EXE', SW_SHOW);
    end;
  }
end;

function TUtilities.ExecuteSQLSimples(vfDBConn: TUniConnection;
  SQL: string): Boolean;
  var uQuerySQL : TUniQuery;
begin
  try
    Result := True;
    try
      uQuerySQL := TUniQuery.Create(nil);
      uQuerySQL.Connection := vfDBConn;
      uQuerySQL.SQL.Add(SQL);
      if not uQuerySQL.Prepared then uQuerySQL.Prepare;
      uQuerySQL.Execute;
    except
      Result := False;
    end;
  finally
   FreeAndNil(uQuerySQL);
  end;
end;

function TUtilities.ExistDB(vfDBConn: TUniConnection; vfDB: string): Boolean;
var uQuerySQL : TUniQuery;
begin
  try
    try
      uQuerySQL := TUniQuery.Create(nil);
      uQuerySQL.Connection := vfDBConn;
      uQuerySQL.SQL.Add('SELECT table_name FROM information_schema.tables ');
      uQuerySQL.SQL.Add('WHERE table_schema = '+QuotedStr(vfDB));
      if not uQuerySQL.Prepared then uQuerySQL.Prepare;
      uQuerySQL.Execute;
      Result := not uQuerySQL.IsEmpty;
    except
      Result := False;
    end;
  finally
   FreeAndNil(uQuerySQL);
  end;
end;

{ WinExecAndWait32 }

{3}

{--WinExecAndWait32V2 ------------------------------------------------}
{: Executes a program and waits for it to terminate
@Param FileName contains executable + any parameters
@Param Visibility is one of the ShowWindow options, e.g. SW_SHOWNORMAL
@Returns -1 in case of error, otherwise the programs exit code
@Desc In case of error SysErrorMessage( GetlastError ) will return an
  error message. The routine will process paint messages and messages
  send from other threads while it waits.
}{ Created 27.10.2000 by P. Below
-----------------------------------------------------------------------}

function TUtilities.WinExecAndWait32V2(FileName: string; Visibility: Integer): DWORD;
  procedure WaitFor(processHandle: THandle);
  var
    Msg: TMsg;
    ret: DWORD;
  begin
    repeat
      ret := MsgWaitForMultipleObjects(1, { 1 handle to wait on }
        processHandle, { the handle }
        False, { wake on any event }
        INFINITE, { wait without timeout }
        QS_PAINT or { wake on paint messages }
        QS_SENDMESSAGE { or messages from other threads }
        );
      if ret = WAIT_FAILED then Exit; { can do little here }
      if ret = (WAIT_OBJECT_0 + 1) then
      begin
          { Woke on a message, process paint messages only. Calling
            PeekMessage gets messages send from other threads processed. }
        while PeekMessage(Msg, 0, WM_PAINT, WM_PAINT, PM_REMOVE) do
          DispatchMessage(Msg);
      end;
    until ret = WAIT_OBJECT_0;
  end; { Waitfor }
var { V1 by Pat Ritchey, V2 by P.Below }
  zAppName: array[0..512] of char;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin { WinExecAndWait32V2 }
  StrPCopy(zAppName, FileName);
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.cb          := SizeOf(StartupInfo);
  StartupInfo.dwFlags     := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := Visibility;
  if not CreateProcess(nil,
    zAppName, { pointer to command line string }
    nil, { pointer to process security attributes }
    nil, { pointer to thread security attributes }
    False, { handle inheritance flag }
    CREATE_NEW_CONSOLE or { creation flags }
    NORMAL_PRIORITY_CLASS,
    nil, { pointer to new environment block }
    nil, { pointer to current directory name }
    StartupInfo, { pointer to STARTUPINFO }
    ProcessInfo) { pointer to PROCESS_INF } then
    Result := DWORD(-1) { failed, GetLastError has error code }
  else
  begin
    Waitfor(ProcessInfo.hProcess);
    GetExitCodeProcess(ProcessInfo.hProcess, Result);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end; { Else }
  { Exemplo de uso
    procedure TForm1.Button1Click(Sender: TObject);
    begin
      WinExecAndWait32V2('notepad.exe', SW_SHOWNORMAL);
    end;
  }
end; { WinExecAndWait32V2 }


// With ShellExecuteEx:
//*****************************************************


procedure TUtilities.ShellExecute_AndWait2(FileName: string; Params: string);
var
  exInfo: TShellExecuteInfo;
  Ph: DWORD;
begin
  FillChar(exInfo, SizeOf(exInfo), 0);
  with exInfo do
  begin
    cbSize := SizeOf(exInfo);
    fMask := SEE_MASK_NOCLOSEPROCESS or SEE_MASK_FLAG_DDEWAIT;
    Wnd := GetActiveWindow();
    ExInfo.lpVerb := 'open';
    ExInfo.lpParameters := PChar(Params);
    lpFile := PChar(FileName);
    nShow := SW_SHOWNORMAL;
  end;
  if ShellExecuteEx(@exInfo) then
    Ph := exInfo.HProcess
  else
  begin
    ShowMessage(SysErrorMessage(GetLastError));
    Exit;
  end;
  while WaitForSingleObject(ExInfo.hProcess, 50) <> WAIT_OBJECT_0 do
    Application.ProcessMessages;
  CloseHandle(Ph);
  {Exemplo de uso
  procedure TForm1.Button1Click(Sender: TObject);
  begin
    ShellExecute_AndWait('FileName', 'Parameter');
  end;
  }
end;

function TUtilities.ShellExecute_AndWait(Operation, FileName, Parameter, Directory: string;
  Show: Word; bWait: Boolean): Longint;
var
  bOK: Boolean;
  Info: TShellExecuteInfo;
{
  ****** Parameters ******
  Operation:

  edit  Launches an editor and opens the document for editing.
  explore Explores the folder specified by lpFile.
  find Initiates a search starting from the specified directory.
  open Opens the file, folder specified by the lpFile parameter.
  print Prints the document file specified by lpFile.
  properties Displays the file or folder's properties.

  FileName:

  Specifies the name of the file or object on which
  ShellExecuteEx will perform the action specified by the lpVerb parameter.

  Parameter:

  String that contains the application parameters.
  The parameters must be separated by spaces.

  Directory:

  specifies the name of the working directory.
  If this member is not specified, the current directory is used as the working directory.

  Show:

  Flags that specify how an application is to be shown when it is opened.
  It can be one of the SW_ values

  bWait:

  If true, the function waits for the process to terminate
}
begin
  FillChar(Info, SizeOf(Info), Chr(0));
  Info.cbSize := SizeOf(Info);
  Info.fMask := SEE_MASK_NOCLOSEPROCESS;
  Info.lpVerb := PChar(Operation);
  Info.lpFile := PChar(FileName);
  Info.lpParameters := PChar(Parameter);
  Info.lpDirectory := PChar(Directory);
  Info.nShow := Show;
  bOK := Boolean(ShellExecuteEx(@Info));
  if bOK then
  begin
    if bWait then
    begin
      while
        WaitForSingleObject(Info.hProcess, 100) = WAIT_TIMEOUT
        do Application.ProcessMessages;
      bOK := GetExitCodeProcess(Info.hProcess, DWORD(Result));
    end
    else
      Result := 0;
  end;
  if not bOK then Result := -1;
end;

function TUtilities.FormatarFone(const AValue : String; DDDPadrao: String = '') : String ;
var
  FoneNum, Mascara : string;
  ComecaComZero: Boolean;
  LenFoneNum: Integer;
begin
  Result := '';
  FoneNum := OnlyNumber(AValue);
  ComecaComZero := (LeftStr(FoneNum,1) = '0');
  FoneNum := RemoveZerosEsquerda(FoneNum);

  LenFoneNum := length(FoneNum);
  if (LenFoneNum = 0) or (FoneNum = '0') then
    exit;

  if (LenFoneNum <= 9) and NaoEstaVazio(DDDPadrao) then
  begin
     FoneNum := LeftStr(DDDPadrao,2) + FoneNum;
     LenFoneNum := LenFoneNum + 2;
  end;

  if LenFoneNum > 12 then
  begin
    FoneNum := LeftStr(FoneNum,2) + RemoveZerosEsquerda(copy(FoneNum,3,Length(FoneNum)));
    LenFoneNum := length(FoneNum);
  end;

  case LenFoneNum of
    9: Mascara := '*****-****';
    10:
      begin
        if ComecaComZero and (copy(FoneNum,2,2) = '00') then  // 0300,0500,0800,0900
          Mascara := '****-***-****'
        else
          Mascara := '(**)****-****';
      end;
    11: Mascara := '(**)*****-****';
    12: Mascara := '+**(**)****-****';
  else
    if LenFoneNum > 12 then
      Mascara := '+**(**)*****-****'
    else
      Mascara := '****-****';
  end;

  Result := FormatarMascaraNumerica( FoneNum, Mascara );
end;

function TUtilities.GetSpecialFolder( aFolder: Integer; var Location: String ): LongWord;
// Retorna o nome do diretorio de alguns diretorios padrões do Windows
// Incluir ShlObj na clausula Uses
// aFolder pode ser
//const
// Pastas : Array[0..15] of Integer = (CSIDL_BITBUCKET, CSIDL_CONTROLS,
// CSIDL_DESKTOP, CSIDL_DESKTOPDIRECTORY, CSIDL_DRIVES, CSIDL_FONTS,
// CSIDL_NETHOOD, CSIDL_NETWORK, CSIDL_PERSONAL, CSIDL_PRINTERS,
// CSIDL_PROGRAMS, CSIDL_RECENT, CSIDL_SENDTO, CSIDL_STARTMENU,
// CSIDL_STARTUP, CSIDL_TEMPLATES);
// Descs : Array[0..15] of String = (´Lixeira´, ´Painel de controle´,
// ´Área de trabalho´, ´Arquivos da área de trabalho´, ´Meu Computador´,
// ´Fontes´, ´Ambiente de rede´, ´Hierarquia de rede´, ´Documentos pessoais´,
// ´Impressoras´, ´Programas do usuário´, ´Documentos´, ´Enviar Para´,
// ´Menu Iniciar´, ´Grupo Iniciar´, ´Modelos´);
var
pidl: PItemIDList;
hRes: HRESULT;
RealPath: Array[0..MAX_PATH] of Char;
Success: Boolean;
begin
  Result := 0;
  hRes := SHGetSpecialFolderLocation( Application.Handle, aFolder, pidl );
  if hRes = NO_ERROR then
  begin
    Success := SHGetPathFromIDList( pidl, RealPath );
    if Success then
    Location := String( RealPath ) + '\'
    else
    Result := LongWord( E_UNEXPECTED );
  end else
  Result := hRes;
end;

function TUtilities.VarRecToStr(AVarRec: TVarRec): string;
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

function TUtilities.GetReturnValue(vfDBConn: TUniConnection;
                                   vfTable: string;
                                   vfFieldsReturn: string;
                                   vfFieldsParam: array of string;
                                   vfFieldsParamValour: array of const;
                                   vfFormatReturn: TFieldType = ftUnknown): Variant;
var
  uQuerySQL: TUniQuery;
  vl_i, vl_x, vl_numfields : integer;
  vl_condsearch : string;
begin

  try
    uQuerySQL := TUniQuery.Create(nil);

    with uQuerySQL do
    begin
      AutoCalcFields := True;
      Options.AutoPrepare := True;
      vl_numfields := Length(vfFieldsParam);
      Connection := vfDBConn;
      Close;
      SQL.Clear;
      SQL.Add('SELECT '+Trim(vfFieldsReturn)+' as VALUE FROM '+Trim(vfTable)+' WHERE ');
      for vl_i := 0 to vl_numfields - 1 do
      begin
        if vl_i = 0 then
        begin
            SQL.Add('(' + Trim(vfFieldsParam[vl_i]) + '=' + Trim(VarRecToStr(vfFieldsParamValour[vl_i]) + ')'))
        end
        else
        begin
          SQL.Add(' AND (' + Trim(vfFieldsParam[vl_i]) + '=' + Trim(VarRecToStr(vfFieldsParamValour[vl_i]) + ')'));
        end
      end;


             // Trim(vfFieldsParam)+' = '+Trim(VarRecToStr(vfFieldsParamValour[0])));

      if not Prepared then Prepare;

      SQL.SaveToFile('sql.log');

      Execute;
     { if Fieldbyname('VALUE').IsNull then
        Result := null
      else}
      if vfFormatReturn = ftUnknown then
         Result := Fieldbyname('VALUE').AsVariant
      else
      if vfFormatReturn = ftInteger then
         Result := Fieldbyname('VALUE').AsInteger
      else
      if vfFormatReturn = ftBoolean then
         Result := Fieldbyname('VALUE').AsBoolean
      else
      if vfFormatReturn = ftString then
         Result := Fieldbyname('VALUE').AsString
      else
      if vfFormatReturn = ftDateTime then
         Result := Fieldbyname('VALUE').AsDateTime
      else
      if vfFormatReturn = ftFloat then
         Result := Fieldbyname('VALUE').AsFloat
      else
      if vfFormatReturn = ftCurrency then
         Result := Fieldbyname('VALUE').AsCurrency;

    end;
  finally
    uQuerySQL.Destroy;
    uQuerySQL := nil;
  end;
end;

function TUtilities.GetReturnArrayValue(vfDBConn: TUniConnection;
                                   vfTable: string;
                                   vfFieldsSelects: array of string;
                                   vfFieldsParam: array of string;
                                   vfFieldsParamValour: array of const
                                   ):TArrayofVariant;
var
  uQuerySQL: TUniQuery;
  vl_i, vl_x,Z, vl_numfieldsParam, vl_numfieldsReturn : integer;
  vl_condsearch, vlFieldsReturn : string;
  vlVarReturn: TArrayofVariant;
begin

  try

    uQuerySQL := TUniQuery.Create(nil);

    with uQuerySQL do
    begin
      AutoCalcFields := True;
      Options.AutoPrepare := True;
      vl_numfieldsParam  := Length(vfFieldsParam);
      vl_numfieldsReturn := Length(vfFieldsSelects);
      SetLength(vlVarReturn,vl_numfieldsReturn);
      Connection := vfDBConn;
      Close;
      SQL.Clear;
      vlFieldsReturn := '';

      for Z := 0 to vl_numfieldsReturn-1 do
      begin
        vlFieldsReturn := vlFieldsReturn + vfFieldsSelects[Z]+' as VALUE'+IntToStr(Z+1)+ifthen(Z <> vl_numfieldsReturn-1,',','');
      end;

      SQL.Add('SELECT '+Trim(vlFieldsReturn)+' FROM '+Trim(vfTable)+' WHERE ');

      for vl_i := 0 to vl_numfieldsParam - 1 do
      begin
        if vl_i = 0 then
        begin
            SQL.Add('(' + Trim(vfFieldsParam[vl_i]) + '=' + Trim(VarRecToStr(vfFieldsParamValour[vl_i]) + ')'))
        end
        else
        begin
          SQL.Add(' AND (' + Trim(vfFieldsParam[vl_i]) + '=' + Trim(VarRecToStr(vfFieldsParamValour[vl_i]) + ')'));
        end
      end;


             // Trim(vfFieldsParam)+' = '+Trim(VarRecToStr(vfFieldsParamValour[0])));

      if not Prepared then Prepare;

      SQL.SaveToFile('sql.log');

      Execute;

      for vl_x := 0 to vl_numfieldsReturn-1 do
      begin
        if vl_x = 0 then First;
        vlVarReturn[vl_x] :=  FieldByName('VALUE'+IntToStr(vl_x+1)).AsVariant;
        Next;
      end;
      Result := vlVarReturn;
    end;
  finally
    uQuerySQL.Destroy;
    uQuerySQL := nil;
    Initialize(vlVarReturn); // remove referências dos campos dinâmicos(string, array).
    FillChar(vlVarReturn, SizeOf(vlVarReturn), 0); // limpa as variáveis ordinais
  end;
end;

function TUtilities.GetExistValue(vfDBConn: TUniConnection;
                                   vfTable: string;
                                   vfFields: array of string;
                                   vfValours: array of const;
                                   vfFilter : array of String): Boolean;
var
  uQuerySQL: TUniQuery;
  vl_i, vl_x, vl_numfields : integer;
  vl_condsearch : string;
begin
  uQuerySQL := TUniQuery.Create(nil);
  vl_numfields := Length(vfFields);
  try
    with uQuerySQL do
    begin

      Connection := vfDBConn;
      Close;
      SQL.Clear;
      SQL.Add('SELECT ');

      for vl_x := 0 to vl_numfields - 1 do
      begin
        if vl_x = 0 then
        begin
          if Trim(vfFields[vl_x]) <> '' then
            SQL.Add(Trim(vfFields[vl_x]));
        end
        else
        begin
          if Trim(vfFields[vl_x]) <> '' then
            SQL.Add(', ' + Trim(vfFields[vl_x]));
        end;
      end;

      SQL.Add('FROM ' + Trim(vfTable));
      SQL.Add('WHERE ');

      //vl_condsearch := IfThen(vfFilter = '','=',' LIKE ');
      //if vl_condsearch :=  then


      for vl_i := 0 to Length(vfFilter)- 1 do
      begin
        if vl_i = 0 then
        begin
            SQL.Add('(' + Trim(vfFields[vl_i]) + IfThen(vfFilter[vl_i] = '',' = ',vfFilter[vl_i]) + Trim(VarRecToStr(vfValours[vl_i]) + ')'))
        end
        else
        begin
          SQL.Add(' AND (' + Trim(vfFields[vl_i]) + IfThen(vfFilter[vl_i] = '',' = ',vfFilter[vl_i]) + Trim(VarRecToStr(vfValours[vl_i]) + ')'));
        end
      end;

      SQL.SaveToFile('sql.log');

      Open;

      if IsEmpty then
        Result := False
      else
        Result := True;
    end;
  finally
    uQuerySQL.Destroy;
    uQuerySQL := nil;
  end;
end;

function TUtilities.SyncSend_EquipamentoWS(vfDBConnL, vfDBConnW: TUniConnection;
  vfCONTRATOID: integer): Boolean;
var
  vlQryOrig, vlQryDest : TUniQuery;
  I : Integer;
  vlINSVALUESQL, vlDUPKEYVALUESQL : string;
begin
  try
    Result := True;
    vlINSVALUESQL := '';
    vlDUPKEYVALUESQL := '';
    if vfDBConnW.Connected then vfDBConnW.Close;

    vlQryOrig  := TUniQuery.Create(nil);
    vlQryOrig.Connection :=  vfDBConnW;
    vlQryOrig.AutoCalcFields := True;
    vlQryOrig.CachedUpdates := True;

    vlQryDest  := TUniQuery.Create(nil);
    vlQryDest.Connection :=  vfDBConnL;

    vlQryOrig.SQL.Add(SQLGETEQUIPAMENTO+' WHERE `licence_equipamento`.`CONTRATO_ID` = :VCP00 ');
    vlQryOrig.ParamByName('VCP00').AsInteger :=  vfCONTRATOID;

    if not vlQryOrig.Prepared then vlQryOrig.Prepare;
    vlQryOrig.Execute;

    if vlQryOrig.IsEmpty then
    Begin
      Result := False;
      Abort;
    End;

    vlQryOrig.First;

    for I := 0 to vlQryOrig.RecordCount-1 do
    begin
      vlINSVALUESQL := vlINSVALUESQL +
                       '('+vlQryOrig.FieldByName('CONTRATO_ID').AsString+','+
                       QuotedStr(vlQryOrig.FieldByName('MAC_ADRESS').AsString)+','+
                       QuotedStr(vlQryOrig.FieldByName('IP_ADRESS').AsString)+','+
                       QuotedStr(vlQryOrig.FieldByName('MAQUINA').AsString)+','+
                       QuotedStr(vlQryOrig.FieldByName('OS').AsString)+','+
                       QuotedStr(vlQryOrig.FieldByName('VER_SYS').AsString)+','+
                       QuotedStr(vlQryOrig.FieldByName('VER_ARQ').AsString)+','+
                       QuotedStr(formatdatetime('YYYY/mm/dd',vlQryOrig.FieldByName('LAST_ACCESS_LICENCE').AsDateTime))+','+
                       QuotedStr(vlQryOrig.FieldByName('KEYMACHINE').AsString) + IfThen(I < vlQryOrig.RecordCount-1,'),',') ');
      vlQryOrig.Next;
    end;


    vlDUPKEYVALUESQL := 'MAC_ADRESS =  VALUES (MAC_ADRESS),'+
                        'IP_ADRESS =  VALUES (IP_ADRESS),'+
                        'MAQUINA =  VALUES (MAQUINA),'+
                        'OS =  VALUES (OS),'+
                        'VER_SYS =  VALUES (VER_SYS),'+
                        'VER_ARQ =  VALUES (VER_ARQ),'+
                        'LAST_ACCESS_LICENCE =  VALUES (LAST_ACCESS_LICENCE);';

    vlQryDest.SQL.Add(SQLPUTEQUIPAMENTO+vlINSVALUESQL+' ON DUPLICATE KEY UPDATE '+vlDUPKEYVALUESQL);

    if not vlQryDest.Prepared then vlQryDest.Prepare;

    if Self.ServerIsOnline(vfDBConnL) then
    begin
       try
         vlQryDest.Execute;
         Result := True;
       except
         Result := False;
       end;
    end;
  finally
    if vlQryDest.Active then vlQryDest.Close;
    if vlQryOrig.Active then vlQryOrig.Close;
    if vfDBConnW.Connected then vfDBConnW.Close;
    vlQryDest.Free;
    vlQryOrig.Free;
  end;

end;

function TUtilities.RunAsAdmin(const Handle: Hwnd; const Path, Params: string): Boolean;
var
  sei: TShellExecuteInfoA;
begin
 { FillChar(sei, SizeOf(sei), 0);
  sei.cbSize := SizeOf(sei);
  sei.Wnd := Handle;
  sei.fMask := SEEMASKFLAGDDEWAIT or SEEMASKFLAGNOUI;
  sei.lpVerb := 'runas';
  sei.lpFile := PAnsiChar(Path);
  sei.lpParameters := PAnsiChar(Params);
  sei.nShow := SWSHOWNORMAL;
  Result := ShellExecuteExA(@sei);  }
end;

function TUtilities.GetVersionSystem(vf_type_user: pcn_type_user_sys): string;
type
  PFFI = ^vs_FixedFileInfo;
var
  F: PFFI;
  Handle: Dword;
  Len: Longint;
  Data: Pchar;
  Buffer: Pointer;
  Tamanho: Dword;
  Parquivo: Pchar;
  Arquivo: string;
begin
  Arquivo := Application.ExeName;
  Parquivo := StrAlloc(Length(Arquivo) + 1);
  StrPcopy(Parquivo, Arquivo);
  Len := GetFileVersionInfoSize(Parquivo, Handle);
  Result := '';
  if Len > 0 then
  begin
    Data := StrAlloc(Len + 1);
    if GetFileVersionInfo(Parquivo, Handle, Len, Data) then
    begin
      VerQueryValue(Data, '', Buffer, Tamanho);
      F := PFFI(Buffer);
      if vf_type_user = tuRoot then
      begin
        Result := Format('%d.%d.%d.%d',
                         [HiWord(F^.dwFileVersionMs),
                          LoWord(F^.dwFileVersionMs),
                          HiWord(F^.dwFileVersionLs),
                          Loword(F^.dwFileVersionLs)
                         ]);
      end
      else
      begin
        Result := Formatfloat('0', HiWord(F^.dwFileVersionMs)) + '.' + Formatfloat('00', LoWord(F^.dwFileVersionMs));

      end;
    end;
    StrDispose(Data);
  end;
  StrDispose(Parquivo);
end;

procedure TUtilities.ClearDir(StDelDir: boolean; FullPath: string);
begin
  if System.IOUtils.TDirectory.Exists(FullPath) then
    System.IOUtils.TDirectory.Delete(FullPath,StDelDir);

  if not System.IOUtils.TDirectory.Exists(FullPath) then
    System.IOUtils.TDirectory.CreateDirectory(FullPath);
end;

function TUtilities.ContaPalavras(Texto: String): Integer;
var
  Lista :TStringList;
begin
  with TStringList.Create do
  begin
    Delimiter := ' ';
    DelimitedText := Texto;
    Result := Count;
    Free;
  end;
end;

function TUtilities.GetFileSize(FileName: String; FormatSize: pcn_Byte_Format = bsfDefault;WtihFormatSize : Boolean = True): string;
var Bytes: UInt64;

function FileSize64(fileName : wideString) : Int64;
var
  sr : TSearchRec;
begin
  if FindFirst(fileName, faAnyFile, sr ) = 0 then
     result := Int64(sr.FindData.nFileSizeHigh) shl Int64(32) + Int64(sr.FindData.nFileSizeLow)
  else
     result := -1;
  FindClose(sr);
end;

begin
  if FileExists(FileName) then
  Begin
    Bytes := FileSize64(FileName);

    if Bytes > 0 then
    Begin
      if FormatSize = bsfDefault then
      begin
        if Bytes < OneKB then begin
          FormatSize := bsfBytes;
        end
        else if Bytes < OneMB then begin
          FormatSize := bsfKB;
        end
        else if Bytes < OneGB then begin
          FormatSize := bsfMB;
        end
        else if Bytes < OneTB then begin
          FormatSize := bsfGB;
        end
        else begin
          FormatSize := bsfTB;
        end;
      end;

      case FormatSize of
        bsfBytes:
          Result := Format('%d bytes', [Bytes]);
        bsfKB:
          Result := Format('%.1n KB', [Bytes / OneKB]);
        bsfMB:
          Result := Format('%.1n MB', [Bytes / OneMB]);
        bsfGB:
          Result := Format('%.1n GB', [Bytes / OneGB]);
        bsfTB:
          Result := Format('%.1n TB', [Bytes / OneTB]);
      end;
    end
    else
    begin
       Result := 'FILE_SIZE_INVALID';
    end;
  End
  else
  begin
    Result := 'FILE_NOT_FOUND';
  end;

  if not WtihFormatSize then
  begin
    case FormatSize of
        bsfBytes:
          Result := StringReplace(Result, ' bytes', '', []);
        bsfKB:
          Result := StringReplace(Result, ' KB', '', []);
        bsfMB:
          Result := StringReplace(Result, ' MB', '', []);
        bsfGB:
          Result := StringReplace(Result, ' GB', '', []);
        bsfTB:
          Result := StringReplace(Result, ' TB', '', []);
      end;
  end;

end;

function TUtilities.GetIpInternet: string;
var vlidHttp1 : Tidhttp;
begin
  try
    vlidHttp1 := Tidhttp.Create(nil);
    result   := vlidHttp1.Get('http://www.samdi.com.br/satup/mantis/iprevelation.php');
  finally
    FreeAndNil(vlidHttp1);
  end;
end;

function TUtilities.StringToStream(const AString: string):TStream;
begin
 Result := TStringStream.Create(AString);
end;

Function TUtilities.AbbreviateName(vfNome: String;vfAbreviar:Boolean;vfMaxAbreviacao,vfMaxCaracer:integer): String;
var
    Nomes: array of string;
    i, TotalNomes: Integer;
begin
  Result := Trim(vfNome);
  if vfAbreviar then
  begin
    if Length(vfNome) >  vfMaxCaracer then
    Begin
      {Insere um espaço para garantir que todas as letras sejam testadas}
        vfNome := Trim(vfNome) + #32;
      {Pega a posição do primeiro espaço}
      //i := Pos(#32, vfNome);
      i := Self.ContaPalavras(vfNome);

      SetLength(Nomes,i);

      if i > 0 then
      begin
        TotalNomes := 0;

        {Separa todos os nomes}
        while i > 0 do
        begin
          Nomes[TotalNomes] := Copy(vfNome, 1, i - 1);
          Delete(vfNome, 1, i);
          i := Pos(#32, vfNome);
          Inc(TotalNomes);
        end;

        if TotalNomes > 0 then
        begin
          if (Nomes[TotalNomes] = 'FILHO')
              or (Nomes[TotalNomes] = 'NETO')
              or (Nomes[TotalNomes] = 'LTDA')
              or (Nomes[TotalNomes] = 'LTDA.')
              or (Nomes[TotalNomes] = 'ME')
              or (Nomes[TotalNomes] = 'ME.')
              or (Nomes[TotalNomes] = 'SA')
              or (Nomes[TotalNomes] = 'SA.')
              or (Nomes[TotalNomes] = 'S/A')
              or (Nomes[TotalNomes] = 'S/A.')
              or (Nomes[TotalNomes] = 'JUNIOR')
              or (Nomes[TotalNomes] = 'JÚNIOR')
          then Dec(TotalNomes);

         {Abreviar a partir do primeiro nome, exceto o último.}
          for i := 1 to TotalNomes - 1 do
          begin

             if Length(Nomes[i]) > 3 then
                {Pega apenas a abreviação maxima de caracter e coloca um ponto após.}
                //Nomes[i] := Nomes[i][1] + '.'
                //Nomes[i] := Nomes[i][vfMaxAbreviacao] + '.'
                Nomes[i] := Copy(Nomes[i],0,vfMaxAbreviacao) + '.'
             else
                {Apaga a variável quando for de, da, dos, das, etc}
                Delete(Nomes[i],1,i);
          end;

          if (Nomes[TotalNomes + 1] = 'FILHO')
              or (Nomes[TotalNomes + 1] = 'NETO')
              or (Nomes[TotalNomes + 1] = 'LTDA')
              or (Nomes[TotalNomes + 1] = 'LTDA.')
              or (Nomes[TotalNomes + 1] = 'ME')
              or (Nomes[TotalNomes + 1] = 'ME.')
              or (Nomes[TotalNomes + 1] = 'SA')
              or (Nomes[TotalNomes + 1] = 'SA.')
              or (Nomes[TotalNomes + 1] = 'S/A')
              or (Nomes[TotalNomes + 1] = 'S/A.')
              or (Nomes[TotalNomes + 1] = 'JUNIOR')
              or (Nomes[TotalNomes + 1] = 'JÚNIOR')
          then  Inc(TotalNomes);

          Result := '';

          for i := 1 to TotalNomes do
             if (Nomes[i] = 'FILHO')
             or (Nomes[i] = 'NETO')
             or (Nomes[i] = 'LTDA')
             or (Nomes[i] = 'LTDA.')
             or (Nomes[i] = 'ME')
             or (Nomes[i] = 'ME.')
             or (Nomes[i] = 'SA')
             or (Nomes[i] = 'SA.')
             or (Nomes[i] = 'S/A')
             or (Nomes[i] = 'S/A.')
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
  end;
end;

procedure TUtilities.UniDumpBackupProgress(Sender: TObject; ObjectName: string;
  ObjectNum, ObjectCount, Percent: Integer);
begin
  frmStatusExtract.lblFilePkg.Caption := 'Gerando o backup da data base';
  frmStatusExtract.gOverall.Position := 100;
  frmStatusExtract.lbFile.Caption := 'Tabela '+IntToStr(ObjectNum)+' de '+IntToStr(ObjectCount)+', '+ObjectName+'...';
  frmStatusExtract.gFile.Position := Percent;
  Application.ProcessMessages;
end;

function TUtilities.UpLoadFtp(HostName: String;
                            UserName: String;
                            Password: String;
                            UploadFileName: String;
                            ServerFileName: String;
                            ToHostDir : String ):Boolean;
var
  FTP: TFtpClient;
begin
  try
    Result := True;
    FTP := TFtpClient.Create(nil);
    frmStatusExtract := TfrmStatusExtract.Create(nil);
    FTP.OnProgress64 := FtpClientProgress64;
    FTP.HostName := HostName;
    FTP.Passive := True;
    FTP.Binary := True;
    FTP.Username := UserName;
    FTP.Password := Password;
    FTP.Port := '21';
    FTP.HostDirName := ToHostDir;
    FTP.LocalFileName := UploadFileName;
    FTP.HostFileName := ServerFileName;
    frmStatusExtract.Show;
    Application.ProcessMessages;
    try
      FTP.Open;
      FTP.User;
      FTP.Pass;
      FTP.TypeBinary;
      FTP.Cwd;
      Result :=  FTP.Put;
    except on E: Exception do
      Begin
        Result := False;
        ShowMessage(E.ClassName+' Ocorreu o seguinte erro : '+E.Message);
      End;
    end;
  finally
    frmStatusExtract.Close;
    FreeAndNil(frmStatusExtract);
    FTP.Quit;
    FTP.Free;
  end;
end;

procedure TUtilities.FtpClientProgress64(Sender: TObject; Count: Int64; var Abort: Boolean);
begin
  frmStatusExtract.lblFilePkg.Caption := 'Enviando o backup para o CloudSAMDI...';
  frmStatusExtract.gOverall.Position := 100;
  frmStatusExtract.lbFile.Caption := 'Progresso... ';
  frmStatusExtract.gFile.Position := Count;
  Application.ProcessMessages;
end;


function TUtilities.CheckCompanySync(vfDBConnL, vfDBConnW: TUniConnection;
  vfCPFCNPJ: string): Boolean;
var  vlQryOrig, vlQryDest : TUniQuery;
begin
  try
    try
      Result := True;

      if vfDBConnW.Connected then vfDBConnW.Close;

      vlQryOrig  := TUniQuery.Create(nil);
      vlQryOrig.Connection :=  vfDBConnW;
      vlQryOrig.AutoCalcFields := True;
      vlQryOrig.CachedUpdates := True;

      vlQryDest  := TUniQuery.Create(nil);
      vlQryDest.Connection :=  vfDBConnL;
      if vlQryDest.Active then vlQryDest.Close;
      vlQryDest.SQL.Clear;
      vlQryDest.SQL.Add(SQLGETUSERLICENCED);
      vlQryDest.ParamByName('VCP00').AsString := OnlyNumber(vfCPFCNPJ);
      if not vlQryDest.Prepared then vlQryDest.Prepare;

      vlQryDest.Execute;

      if vlQryDest.IsEmpty then
      begin
        vlQryOrig.SQL.Add(SQLGETUSERLICENCED);
        vlQryOrig.ParamByName('VCP00').AsString := OnlyNumber(vfCPFCNPJ);
        if not vlQryOrig.Prepared then vlQryOrig.Prepare;
        vlQryOrig.Execute;

        if not vlQryOrig.IsEmpty then
        begin
          vlQryDest.Insert;
          vlQryDest.FieldByName('TIPO_PESSOA').AsInteger := vlQryOrig.FieldByName('TIPO_PESSOA').AsInteger ;
          vlQryDest.FieldByName('TIPO_PESSOA_ENTIDADE1').AsInteger := 1;
          vlQryDest.FieldByName('TIPO_PESSOA_ENTIDADE2').Clear;
          vlQryDest.FieldByName('CFGSYS_EMPRESA_ID').Clear;
          vlQryDest.FieldByName('IDENT_RAZAOSOCIAL').AsString := vlQryOrig.FieldByName('IDENT_RAZAOSOCIAL').AsString;
          vlQryDest.FieldByName('IDENT_NOMEFANTASIA').AsString := vlQryOrig.FieldByName('IDENT_NOMEFANTASIA').AsString;
          vlQryDest.FieldByName('IDENT_CNPJCPF').AsString := vlQryOrig.FieldByName('IDENT_CNPJCPF').AsString;
          vlQryDest.FieldByName('IDENT_IE').AsString := vlQryOrig.FieldByName('IDENT_IE').AsString;
          vlQryDest.FieldByName('IDENT_RESPONSAVELLEGAL').AsString := vlQryOrig.FieldByName('IDENT_RESPONSAVELLEGAL').AsString;
          vlQryDest.FieldByName('IDENT_CNAEPRIMARIO').AsString := vlQryOrig.FieldByName('IDENT_CNAEPRIMARIO').AsString;
          vlQryDest.FieldByName('IDENT_CNAESECUNDARIO').AsString := vlQryOrig.FieldByName('IDENT_CNAESECUNDARIO').AsString;
          vlQryDest.FieldByName('IDENT_DATACADASTRO').AsDateTime := vlQryOrig.FieldByName('IDENT_DATACADASTRO').AsDateTime;
          vlQryDest.FieldByName('IDENT_DATANASCIMENTOABERTURA').AsDateTime := vlQryOrig.FieldByName('IDENT_DATANASCIMENTOABERTURA').AsDateTime;
          vlQryDest.FieldByName('IDENT_CARTEIRAIDENTIDADE').AsString := vlQryOrig.FieldByName('IDENT_CARTEIRAIDENTIDADE').AsString;
          vlQryDest.FieldByName('IDENT_STATUSCADASTRO').AsInteger := vlQryOrig.FieldByName('IDENT_STATUSCADASTRO').AsInteger;
          vlQryDest.FieldByName('END_LOGRADOURO').AsString := vlQryOrig.FieldByName('END_LOGRADOURO').AsString;
          vlQryDest.FieldByName('END_NUMERO').AsString := vlQryOrig.FieldByName('END_NUMERO').AsString;
          vlQryDest.FieldByName('END_BAIRRO').AsString := vlQryOrig.FieldByName('END_BAIRRO').AsString;
          vlQryDest.FieldByName('END_CEP').AsString := vlQryOrig.FieldByName('END_CEP').AsString;
          vlQryDest.FieldByName('END_UF').AsString := vlQryOrig.FieldByName('END_UF').AsString;
          vlQryDest.FieldByName('END_MUNICIPIO_ID').AsInteger := Self.GetReturnValue
                                                                (
                                                                  vfDBConnL,
                                                                  'al_municipio',
                                                                  'ID',
                                                                  ['COD_MUNICIPIO'],
                                                                  [vlQryOrig.FieldByName('END_MUNICIPIO_ID').AsInteger]
                                                                );
          vlQryDest.FieldByName('END_COMPLEMENTO').AsString := vlQryOrig.FieldByName('END_COMPLEMENTO').AsString;
          vlQryDest.FieldByName('CONTATO_EMAIL').AsString := vlQryOrig.FieldByName('CONTATO_EMAIL').AsString;
          vlQryDest.FieldByName('CONTATO_WEB').AsString := vlQryOrig.FieldByName('CONTATO_WEB').AsString;
          vlQryDest.FieldByName('IMG').AsString := vlQryOrig.FieldByName('IMG').AsString;
          vlQryDest.FieldByName('CONTATO_TELEFONE1').AsString := vlQryOrig.FieldByName('CONTATO_TELEFONE1').AsString;
          vlQryDest.FieldByName('CONTATO_TELEFONE1RAMAL').AsString := vlQryOrig.FieldByName('CONTATO_TELEFONE1RAMAL').AsString;
          vlQryDest.FieldByName('CONTATO_TELEFONE2').AsString := vlQryOrig.FieldByName('CONTATO_TELEFONE2').AsString;
          vlQryDest.FieldByName('CONTATO_TELEFONE2RAMAL').AsString := vlQryOrig.FieldByName('CONTATO_TELEFONE2RAMAL').AsString;
          vlQryDest.FieldByName('CONTATO_FAX').AsString := vlQryOrig.FieldByName('CONTATO_FAX').AsString;
          vlQryDest.FieldByName('CONTATO_CELULAR1').AsString := vlQryOrig.FieldByName('CONTATO_CELULAR1').AsString;
          vlQryDest.FieldByName('CONTATO_CELULAR2').AsString := vlQryOrig.FieldByName('CONTATO_CELULAR2').AsString;
          vlQryDest.FieldByName('CONTATO_WHATAPP1').AsString := vlQryOrig.FieldByName('CONTATO_WHATAPP1').AsString;
          vlQryDest.FieldByName('CONTATO_WHATAPP2').AsString := vlQryOrig.FieldByName('CONTATO_WHATAPP2').AsString;
          vlQryDest.FieldByName('CONTATO_TELELEFONESAC').AsString := vlQryOrig.FieldByName('CONTATO_TELELEFONESAC').AsString;
          vlQryDest.FieldByName('CONTATO_TELEFONESACRAMAL').AsString := vlQryOrig.FieldByName('CONTATO_TELEFONESACRAMAL').AsString;
          vlQryDest.FieldByName('PERFIL_FISCAL_RAMO').AsInteger := vlQryOrig.FieldByName('PERFIL_FISCAL_RAMO').AsInteger;
          vlQryDest.FieldByName('PERFIL_FISCAL_TIPOATIVIDADE').AsInteger := vlQryOrig.FieldByName('PERFIL_FISCAL_TIPOATIVIDADE').AsInteger;
          vlQryDest.FieldByName('PERFIL_FISCAL_ISFILIAL').AsBoolean := vlQryOrig.FieldByName('PERFIL_FISCAL_ISFILIAL').AsBoolean;
          vlQryDest.FieldByName('PERFIL_FISCAL_ISCONTRIBUINTEST').AsBoolean := vlQryOrig.FieldByName('PERFIL_FISCAL_ISCONTRIBUINTEST').AsBoolean;
          vlQryDest.FieldByName('PERFIL_FISCAL_TIPOREGIME').AsInteger := vlQryOrig.FieldByName('PERFIL_FISCAL_TIPOREGIME').AsInteger;
          vlQryDest.FieldByName('PERFIL_FISCAL_SUFRAMA').AsString := vlQryOrig.FieldByName('PERFIL_FISCAL_SUFRAMA').AsString;
          vlQryDest.FieldByName('PERFIL_FISCAL_ISEXIGEISS').AsBoolean := vlQryOrig.FieldByName('PERFIL_FISCAL_ISEXIGEISS').AsBoolean;
          vlQryDest.FieldByName('PERFIL_FISCAL_ISREGIMEESPECIALTRIBUTACAO').AsBoolean := vlQryOrig.FieldByName('PERFIL_FISCAL_ISREGIMEESPECIALTRIBUTACAO').AsBoolean;
          vlQryDest.FieldByName('PERFIL_FISCAL_ISINCENTIVADORCULTURAL').AsBoolean := vlQryOrig.FieldByName('PERFIL_FISCAL_ISINCENTIVADORCULTURAL').AsBoolean;
          vlQryDest.FieldByName('PERFIL_FISCAL_ISCONSUMIDORFINAL').AsBoolean := vlQryOrig.FieldByName('PERFIL_FISCAL_ISCONSUMIDORFINAL').AsBoolean;
          vlQryDest.Post;
        end
        else Result := False;
      end;
    except
       Result := False;
    end;
  finally
    FreeAndNil(vlQryOrig);
    FreeAndNil(vlQryDest);
  end;

end;

function TUtilities.GetPrintActivityWindow(vfCodContrato:string) : string;
var vl_imgbmp : TBitmap;
    vl_imgjpg : TJPEGImage;
    vl_full_path, vl_sufix, vl_dirroot :string;
    sc, ds : TRect;
    dc : THandle;
    cn : TCanvas;
    VariableSystem : TVariableSystem;
    Utilities : TUtilities;
begin
  try
    VariableSystem := TVariableSystem.Create;

    vl_imgbmp := TBitmap.Create;
    vl_sufix := FormatDateTime('yymmddhhnnss',Now());
    vl_dirroot := ExtractFileDir(application.ExeName);
    vl_full_path := LowerCase(VariableSystem.GetSystemPathTMP+vfCodContrato+vl_sufix+'.jpg');
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
    Result := vl_full_path;
  finally
    vl_imgjpg.Free;
    vl_imgbmp.Free;
    cn.free;
    FreeAndNil(VariableSystem);
  end;
end;

function TUtilities.CreateCallHelpDesk: Boolean;
var VariableSystem : TVariableSystem;
begin
  try
    VariableSystem := TVariableSystem.Create;
    //Self.ClearDir(True,VariableSystem.GetPathTMP);
    //Self.LoadPath(VariableSystem.vgDIRWORK,['\TMP']);

    Application.CreateForm(TFrmCallHelpDesk, FrmCallHelpDesk);
    FrmCallHelpDesk.vgLocalFileJPG :=  GetPrintActivityWindow('tmp');
    FrmCallHelpDesk.Image1.Picture.LoadFromFile(FrmCallHelpDesk.vgLocalFileJPG);
    FrmCallHelpDesk.ShowModal;
  finally
    FreeAndNil(VariableSystem);
    FreeAndNil(FrmCallHelpDesk);
  end;
end;

function TUtilities.TimeStampUnix(vfConvertion:pcn_datetimestampunix;vfValue:string): string;

    function GetDataBase0 : Integer;
    begin
      if FDataBase0 = 0 then //pra não fazer o calc td hora
        FDataBase0 := Trunc(EncodeDate(1970, 1, 1));

      Result := FDataBase0;
    end;

    function TimeIntegerToDateTime(I : Integer) : TDateTime;
    begin
      Result := I / cSegundosPorDia + GetDataBase0;
    end;

    function DateTimeToTimeInteger(D : TDateTime) : Integer;
    begin
      Result := Trunc((D - GetDataBase0) * cSegundosPorDia);
    end;

var vlContainerInt : Integer;
    vlContainerDataTime : TDateTime;
begin
  vlContainerInt := 0;
  vlContainerDataTime := 0;

  if vfValue = 'NULL' then
  Begin
    Result := '0';
    Exit
  end;

  if vfConvertion = tsIntToDateTime then
  begin
    vlContainerInt := StrToInt(vfValue);
    Result := DateTimeToStr(TimeIntegerToDateTime(vlContainerInt - 7206));
  end
  else
  begin
    vlContainerDataTime := StrToDateTime(vfValue);
    Result := IntToStr(DateTimeToTimeInteger(vlContainerDataTime)+7206);
  end;
end;

function TUtilities.FileToHex(vfFileName:string): string;
    function StreamToHex(Stream: TStream; var Hex: string): Boolean;
    var
      Buffer: Byte;
    begin
      Hex := EmptyStr;
      Stream.Seek(0, soFromBeginning);
      while Stream.Read(Buffer, 1) = 1
        do Hex := Hex + IntToHex(Buffer, 2);
      Result := not SameText(Hex, EmptyStr)
    end;
var
  Stream: TMemoryStream;
  FHex : string;
begin
  Stream := TMemoryStream.Create;
  try
    Stream.LoadFromFile(vfFileName);
    if StreamToHex(Stream, FHex) then
    begin
      //Label1.Caption := IntToStr(Stream.Size);
      Result := FHex;
    end;
  finally
    Stream.Free;
  end;
end;

function TUtilities.InternetConnectionKind: rc_connection_info;

function pingIp(Host: String): string;
var
  IdICMPClient: TIdICMPClient;
begin
  try
    try
      IdICMPClient := TIdICMPClient.Create(Nil);
      IdICMPClient.Host := Host;
      IdICMPClient.ReceiveTimeout := 500;
      IdICMPClient.Ping;
      if (IdICMPClient.ReplyStatus.BytesReceived > 0) then
      begin
        Result := 'Comunicação realizada com os servidores SAMDI.';
      end
      else
      begin
        Result := 'No momento não foi possível Comunicar com os servidores SAMDI.';
      end;

    except on E: Exception do
      Result := 'Houve um erro ao tentar se comunicar com os servidores SAMDI, ERROR : '+E.Message ;
    end;
  finally
    IdICMPClient.Free;
  end;
end;


var
  flags: dword;
  vlMessage, vlHost : string;
begin
  try
    vlHost := 'www.samdi.com.br';
    result.IsConnected := internetgetconnectedstate(@flags, 0);
    if result.IsConnected then
    begin
        if (flags and internet_connection_modem) = internet_connection_modem then
           vlMessage := vlMessage + pingIp(vlHost)+#13#10+'Conecção do tipo : Modem';

        if (flags and internet_connection_lan) = internet_connection_lan then
           vlMessage := vlMessage + pingIp(vlHost)+#13#10+'Conecção do tipo : Lan';

        if (flags and internet_connection_proxy) = internet_connection_proxy then
           vlMessage := vlMessage + pingIp(vlHost)+#13#10+'Conecção do tipo : Proxy';

        if (flags and internet_connection_modem_busy) = internet_connection_modem_busy then
           vlMessage := vlMessage + pingIp(vlHost)+#13#10+'Conecção do tipo : Modem Busy'+#13#10+
                                    'A parentemente o seu modem se encontra ocupado ou ele não '+#13#10+
                                    'consegue definir os parâmetros de acesso, reinicie ele e'+#13#10+
                                    'tente novamente, caso o problema persiste, chame um técnico.';
    end
    else
    begin
        vlMessage := vlMessage + pingIp(vlHost)+', favor verificar cabos de rede,'+#13#10+
                                        'modens, wireless, bluetooth e proxy do seu pc e'+#13#10+
                                         'tente novamente, caso o problema persiste, chame um técnico.';
    end;
  finally
    result.status_message := vlMessage;
    Result := Result;
  end;
end;

function TUtilities.SetSelectADirectory(Title : string;DirAtual:WideString='') : string;
var
  Pasta : String;
begin
  Pasta := '';
  SelectDirectory(Title, DirAtual, Pasta);
  if (Trim(Pasta) <> '') then
  begin
    if (Pasta[Length(Pasta)] <> '\') then
      //Pasta := Copy(Pasta,0,Length(Pasta)-1);
      Pasta := Pasta+'\';
  end;

  Result := Pasta;
end;

function TUtilities.InsertContrato(vfDBConnL: TUniConnection;vfCLIENTEID, vfCONTRATOID:Integer): Boolean;
var uQuerySQL: TUniQuery;
begin
  Try
    Result := True;
    uQuerySQL := TUniQuery.Create(nil);
    uQuerySQL.Connection := vfDBConnL;
    if uQuerySQL.Active then uQuerySQL.Close;
    uQuerySQL.SQL.Clear;
    uQuerySQL.SQL.Add(SQLGETCONTRATO);

    if not uQuerySQL.Prepared then uQuerySQL.Prepare;
    try
      if not uQuerySQL.Active then uQuerySQL.Open;
      uQuerySQL.Open;
      uQuerySQL.Insert;
      uQuerySQL.FieldByName('CONTRATO_MODEL_ID').AsInteger	        := 0;
      uQuerySQL.FieldByName('CONTRATO_PREFIXO').AsString	        := 'SATUP';
      uQuerySQL.FieldByName('CONTRATO_NUMERO').AsInteger	        := vfCONTRATOID;
      uQuerySQL.FieldByName('DATA_GERACAO').AsDateTime	          := Now();
      uQuerySQL.FieldByName('DATA_ENCERRAMENTO').Clear;
      uQuerySQL.FieldByName('DATA_ULT_FATURAMENTO').Clear;
      uQuerySQL.FieldByName('CLIENTE_ID').AsInteger	              := vfCLIENTEID;
      uQuerySQL.FieldByName('DATA_INICIO').AsDateTime	            := Now();
      uQuerySQL.FieldByName('DESCRICAO').AsString	                := 'LICENCIAMENTO DO SISTEMA SATUP';
      uQuerySQL.FieldByName('DATA_FIM').Clear;
      uQuerySQL.FieldByName('CONVENIO_ID').Clear;
      uQuerySQL.FieldByName('CONTRATO_PERIODICIDADE_ID').AsInteger	:= 7;
      uQuerySQL.FieldByName('FATURAMENTO_PERIODICIDADE_ID').AsInteger := 3;
      uQuerySQL.FieldByName('DIA_VENCIMENTO').AsInteger	          := 10;
      uQuerySQL.FieldByName('VALOR_CONTRATO').AsInteger	          := 0;
      uQuerySQL.FieldByName('OBS_REAJUSTE').Clear;
      uQuerySQL.FieldByName('OBS').Clear;
      uQuerySQL.FieldByName('FLG_GET_TOTAL_ITENS').AsBoolean := False;
      uQuerySQL.FieldByName('FLG_AUTO_RENOVAR').AsBoolean := False;
      uQuerySQL.Post;
    except
      on E: EMySqlException do
        begin
          case E.ErrorCode of
            2013 : Self.ShowMessageEx('Importante...',
                                                           'Falha na comunicação com o servidor, '+
                                                           'Favor Tentar Novamente.',
                                                           msStop);
          else
              Self.ShowMessageEx('Importante...',
                                                      'ErroCode: '+
                                                      IntToStr(E.ErrorCode)+#13#10+
                                                      E.Message,
                                                      msStop);
          end;
          Result := False;
        end;
    end;
  Finally
    FreeAndNil(uQuerySQL);
  End;
end;

function TUtilities.InsertLicenca(vfDBConnL: TUniConnection;vfCLIENTEID, vfCONTRATOID, vfVERSAOID:Integer;vfLICENCE:string): Boolean;
var uQuerySQL: TUniQuery;
    vlCNPJCPF: string;
    Cryption: TCryption;
    vlACTIVEMOD : Integer;
begin
  Try
    Cryption            := TCryption.Create;


    vlCNPJCPF := Onlynumber( Self.GetReturnValue(vfDBConnL,
                                                  'pessoa',
                                                  'IDENT_CNPJCPF',
                                                  ['ID'],
                                                  [vfCLIENTEID]));

    vlACTIVEMOD := ifthen(Cryption.GetStringHashMD5F(OnlyNumber(vlCNPJCPF)) = SAMDICNPJ,1,0);
    Result := True;
    uQuerySQL := TUniQuery.Create(nil);
    uQuerySQL.Connection := vfDBConnL;
    if uQuerySQL.Active then uQuerySQL.Close;
    uQuerySQL.SQL.Clear;
    uQuerySQL.SQL.Add(SQLGETLICENCE);

    if not uQuerySQL.Prepared then uQuerySQL.Prepare;
    try
      if not uQuerySQL.Active then uQuerySQL.Open;
      uQuerySQL.Open;
      uQuerySQL.Insert;
      uQuerySQL.FieldByName('CONTRATO_NUMERO').AsInteger := vfCONTRATOID;
      uQuerySQL.FieldByName('CPFCNPJ').AsString          := vlCNPJCPF;
      uQuerySQL.FieldByName('KEY1').AsInteger            := vfCLIENTEID;
      uQuerySQL.FieldByName('KEY2').AsInteger            := 1;
      uQuerySQL.FieldByName('KEY3').AsDateTime  := Now();
      uQuerySQL.FieldByName('KEY4').Clear;
      uQuerySQL.FieldByName('KEY5').AsInteger   := 0;
      uQuerySQL.FieldByName('KEY6').AsInteger   := vfVERSAOID;
      uQuerySQL.FieldByName('KEY7').AsInteger   := 0;
      uQuerySQL.FieldByName('KEY8').AsInteger   := 0;
      uQuerySQL.FieldByName('KEY9').AsInteger   := IfThen(vlACTIVEMOD=1,2,0);
      uQuerySQL.FieldByName('KEY10').AsInteger  := 0;
      uQuerySQL.FieldByName('KEY11').Clear;
      uQuerySQL.FieldByName('KEY12').AsInteger  := 0;
      uQuerySQL.FieldByName('KEY13').AsInteger  := 20;
      uQuerySQL.FieldByName('KEY14').AsInteger  := 30;
      uQuerySQL.FieldByName('KEY15').Clear;
      uQuerySQL.FieldByName('KEY16').AsString   := '';
      uQuerySQL.FieldByName('KEY17').AsString   := '';
      uQuerySQL.FieldByName('KEY18').AsString   := vfLICENCE;
      uQuerySQL.FieldByName('KEY19').AsString   := '';
      uQuerySQL.FieldByName('KEY20').AsInteger  := 0;
      uQuerySQL.FieldByName('KEY21').AsInteger  := 0;
      uQuerySQL.FieldByName('KEY22').AsInteger  := 0;
      uQuerySQL.FieldByName('KEY23').AsInteger  := 0;
      uQuerySQL.FieldByName('KEY24').AsInteger  := 0;
      uQuerySQL.FieldByName('KEY25').AsInteger  := 0;
      uQuerySQL.FieldByName('KEY26').AsInteger  := 0;
      uQuerySQL.FieldByName('KEY27').AsInteger  := 0;
      uQuerySQL.FieldByName('KEY28').AsInteger  := 0;
      uQuerySQL.FieldByName('KEY29').AsInteger  := 0;
      uQuerySQL.FieldByName('KEY30').AsInteger  := 0;
      uQuerySQL.FieldByName('KEY31').AsInteger  := 0;
      uQuerySQL.FieldByName('KEY32').AsInteger  := 0;
      uQuerySQL.FieldByName('KEY33').AsInteger  := 0;
      uQuerySQL.FieldByName('KEY34').AsInteger  := IfThen(vlACTIVEMOD=1,999,0);
      uQuerySQL.FieldByName('KEY35').AsInteger  := IfThen(vlACTIVEMOD=1,999,0);
      uQuerySQL.FieldByName('KEY36').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY37').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY38').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY39').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY40').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY41').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY42').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY43').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY44').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY45').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY46').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY47').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY48').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY49').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY50').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY51').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY52').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY53').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY54').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY55').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY56').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY57').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY58').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY59').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY60').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY61').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY62').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY63').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY64').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY65').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY66').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY67').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY68').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY69').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY70').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY71').AsInteger  := vlACTIVEMOD;
      uQuerySQL.FieldByName('KEY72').AsInteger  := vlACTIVEMOD;

      uQuerySQL.Post;

    except
      on E: EMySqlException do
        begin
          case E.ErrorCode of
            2013 : Self.ShowMessageEx('Importante...',
                                                           'Falha na comunicação com o servidor, '+
                                                           'Favor Tentar Novamente.',
                                                           msStop);
          else
              Self.ShowMessageEx('Importante...',
                                                      'ErroCode: '+
                                                      IntToStr(E.ErrorCode)+#13#10+
                                                      E.Message,
                                                      msStop);
          end;
          Result := False;
        end;
    end;
  Finally
    FreeAndNil(uQuerySQL);
    FreeAndNil(Cryption);
  End;
end;


Function TUtilities.Sat_valida_regras_tributo_saida(vf_force_check,
                                              vf_show_log,
                                              vf_save_log :Boolean;
                                              vf_cst_cson_cfop,
                                              vf_cst_ipi,
                                              vf_cst_pis,
                                              vf_cst_cofins : Integer;
                                              vf_perc_redbc_icms,
                                              vf_perc_diff,
                                              vf_perc_icms,
                                              vf_perc_icmssn,
                                              vf_perc_mva,
                                              vf_perc_ipi,
                                              vf_perc_pis,
                                              vf_perc_cofins : Currency;
                                              vf_flg_icms,
                                              vf_flg_ipi,
                                              vf_flg_pis,
                                              vf_flg_cofins,
                                              vf_flg_st:Boolean
                                              ):rc_acceppt_pf;


  procedure save_log_file(txt_log_file, log_text:String);
  var
  file_log: TStringList;
  begin
    file_log := TStringList.Create;
    try
      if FileExists(txt_log_file) then file_log.LoadFromFile(txt_log_file);
      file_log.Add(log_text);
      file_log.SaveToFile(txt_log_file);
    finally
      file_log.Free;
    end;
  end;

var
  vl_i, vl_x, vl_z, vl_container_cst_piscofins : Integer;
  vl_container_aliquota_piscofins, vl_container_perc_piscofins : Currency;
  vl_log, vl_log_filename, vl_dir_log, vl_complemento_sn  : string;
const
  vl_nometributo            : array[0..3] of string = ('icms','ipi','pis','cofins');

    vl_msn_validacao : array[0..12] of string =
  (
    #13#10+'* - Em operações com a cst/cosn utilizada, não se destaca a aliquota do ',    // id 0
    #13#10+'* - Em operações com a cst/cosn utilizada, é obrigatorio informar a aliquota do ', // id 1
    #13#10+'* - Em operações com a cst/cosn utilizada, é obrigatorio informar a aliquota do imposto zero (0) no lançamento do ', // id 2
    #13#10+'* - Cst/cosn incompátivel com o CFOP selecionado para o ', // id 3
    #13#10+'* - Em operações com a cst/cosn utilizada, mesmo que seja (IMUNE,ISENTO OU NÃO TRIBUTADA) é obrigatorio informar a aliquota do ', // id 4
    #13#10+'* - Em operações com a cst/cosn utilizada, não se informa a redução da BC do ', // id 5
    #13#10+'* - Em operações com a cst/cosn utilizada, não se informa o diferimento da aliquota do ', // id 6
    #13#10+'* - Em operações com a cst/cosn utilizada, se destaca a aliquota de redução do ',    // id 7
    #13#10+'* - Em operações com a cst/cosn utilizada, se destaca a aliquota de diferimento do ',    // id 8
    #13#10+'* - Em operações com a cst/cosn utilizada, se destaca a aliquota de MVA do ',    // id 9
    #13#10+'* - Em operações com a cst/cosn utilizada, não se informa  a Substituíção Tributária e a aliquota de MVA do ',    // id 10
    #13#10+'* - Em operações com a cst/cosn utilizada, incompátivel pois destina a Substituíção Tributária do ',    // id 11
    #13#10+'* - Em operações com a cst/cosn utilizada, o CFOP usado não é compativel com a Substituíção Tributária' // id 12
 );

begin
  Try

    vl_complemento_sn := '- Simples Nacional';

    vl_log_filename    := 'REGCSTCSON'+formatdatetime('YYYYMM', NOW)+'LOG.txt';
    vl_dir_log := ExtractFileDir(application.ExeName)+ '\LOG\';
    if not DirectoryExists(vl_dir_log) then  ForceDirectories(vl_dir_log);

    vl_log := '';



    if VarIsNull(vf_cst_cson_cfop) or
       VarIsNull(vf_cst_ipi)  or
       VarIsNull(vf_cst_pis)  or
       VarIsNull(vf_cst_cofins) then
    begin
      vl_log := 'Favor informar os campos de cst dos impostos.';
    end;


    if VarIsNull(vf_force_check)  then  vf_force_check := True;
    if VarIsNull(vf_show_log)     then  vf_show_log    := True;
    if VarIsNull(vf_save_log)     then  vf_save_log    := False;

    for vl_i := 0 to 4 do    // 0 - icms; 1 - icmsst; 2 - ipi; 3 - pis ; 4 cofins
    begin

      if vl_i = 0 then // icms
      Begin
        // ----------------------------------------- SIMPLES NACIONAL ----------------------------------------- \\
        case vf_cst_cson_cfop of


          101           : Begin
                            //TRIBUTADA PELO SIMPLES NACIONAL COM PERMISSÃO DE CRÉDITO
                            // Se vf_perc_icmssn = 0 Rejeita
                            // Se vf_perc_icms <> 0 Rejeita
                            // Se vf_flg_st for verdadeiro Rejeita
                            // Se vf_perc_diff <> 0 Rejeita Rejeita
                            // Permite Crédito = Sim
                            vl_log := vl_log + IfThen(vf_perc_icmssn  = 0,vl_msn_validacao[1]+vl_nometributo[vl_i],'');
                            vl_log := vl_log + IfThen(vf_perc_icms    <> 0,vl_msn_validacao[0]+vl_nometributo[vl_i],'');
                            vl_log := vl_log + IfThen(vf_flg_st,vl_msn_validacao[10]+vl_nometributo[vl_i]+vl_complemento_sn+
                                                                vl_msn_validacao[12]+vl_nometributo[vl_i]+vl_complemento_sn,'');
                            vl_log := vl_log + IfThen(vf_perc_diff <> 0,vl_msn_validacao[6]+vl_nometributo[vl_i]+vl_complemento_sn,'');
                            Result.IsCredICMS := True;
                          End;

          102           : Begin
                            //TRIBUTADA PELO SIMPLES NACIONAL SEM PERMISSÃO DE CRÉDITO
                            // Se vf_perc_icmssn = 0 Rejeita
                            // Se vf_perc_icms <> 0 Rejeita
                            // Se vf_flg_st for verdadeiro Rejeita
                            // Se vf_perc_diff <> 0 Rejeita Rejeita
                            // Permite Crédito = False
                            vl_log := vl_log + IfThen(vf_perc_icmssn  = 0,vl_msn_validacao[1]+vl_nometributo[vl_i],'');
                            vl_log := vl_log + IfThen(vf_perc_icms    <> 0,vl_msn_validacao[0]+vl_nometributo[vl_i],'');
                            vl_log := vl_log + IfThen(vf_flg_st,vl_msn_validacao[10]+vl_nometributo[vl_i]+vl_complemento_sn+
                                                                vl_msn_validacao[12]+vl_nometributo[vl_i]+vl_complemento_sn,'');
                            vl_log := vl_log + IfThen(vf_perc_diff <> 0,vl_msn_validacao[6]+vl_nometributo[vl_i]+vl_complemento_sn,'');
                            Result.IsCredICMS := False;
                          End;

          103           : Begin
                            //ISENÇÃO DO ICMS NO SIMPLES NACIONAL PARA FAIXA DE RECEITA BRUTA
                            // Se vf_perc_icmssn = 0 Rejeita
                            // Se vf_perc_icms <> 0 Rejeita
                            // Se vf_flg_st for verdadeiro Rejeita
                            // Se vf_perc_diff <> 0 Rejeita Rejeita
                            // Permite Crédito = False
                            vl_log := vl_log + IfThen(vf_perc_icmssn  = 0,vl_msn_validacao[4]+vl_nometributo[vl_i],'');
                            vl_log := vl_log + IfThen(vf_perc_icms    <> 0,vl_msn_validacao[0]+vl_nometributo[vl_i],'');
                            vl_log := vl_log + IfThen(vf_flg_st,vl_msn_validacao[10]+vl_nometributo[vl_i]+vl_complemento_sn+
                                                                vl_msn_validacao[12]+vl_nometributo[vl_i]+vl_complemento_sn,'');
                            vl_log := vl_log + IfThen(vf_perc_diff <> 0,vl_msn_validacao[6]+vl_nometributo[vl_i]+vl_complemento_sn,'');
                            Result.IsCredICMS := False;
                          End;

          201           : Begin
                            //TRIBUTADA PELO SIMPLES NACIONAL COM PERMISSÃO DE CRÉDITO E COM COBRANÇA DO ICMS POR SUBSTITUIÇÃO TRIBUTÁRIA
                            // Se vf_perc_icmssn = 0 Rejeita
                            // Se vf_perc_icms <> 0 Rejeita
                            // Se vf_flg_st for False Rejeita
                            // Se vf_perc_diff <> 0 Rejeita Rejeita
                            // Permite Crédito = True
                            vl_log := vl_log + IfThen(vf_perc_icmssn  = 0,vl_msn_validacao[1]+vl_nometributo[vl_i],'');
                            vl_log := vl_log + IfThen(vf_perc_icms    <> 0,vl_msn_validacao[0]+vl_nometributo[vl_i],'');
                            vl_log := vl_log + IfThen(vf_flg_st = False,vl_msn_validacao[9]+vl_nometributo[vl_i]+vl_complemento_sn,'');
                            vl_log := vl_log + IfThen(vf_perc_diff <> 0,vl_msn_validacao[6]+vl_nometributo[vl_i]+vl_complemento_sn,'');
                            Result.IsCredICMS := True;
                          End;

          202           : Begin
                            //TRIBUTADA PELO SIMPLES NACIONAL SEM PERMISSÃO DE CRÉDITO E COM COBRANÇA DO ICMS POR SUBSTITUIÇÃO TRIBUTÁRIA
                            // Se vf_perc_icmssn = 0 Rejeita
                            // Se vf_perc_icms <> 0 Rejeita
                            // Se vf_flg_st for False Rejeita
                            // Se vf_perc_diff <> 0 Rejeita Rejeita
                            // Permite Crédito = False
                            vl_log := vl_log + IfThen(vf_perc_icmssn  = 0,vl_msn_validacao[1]+vl_nometributo[vl_i],'');
                            vl_log := vl_log + IfThen(vf_perc_icms    <> 0,vl_msn_validacao[0]+vl_nometributo[vl_i],'');
                            vl_log := vl_log + IfThen(vf_flg_st = False,vl_msn_validacao[9]+vl_nometributo[vl_i]+vl_complemento_sn,'');
                            vl_log := vl_log + IfThen(vf_perc_diff <> 0,vl_msn_validacao[6]+vl_nometributo[vl_i]+vl_complemento_sn,'');
                            Result.IsCredICMS := False;
                          End;

          203           : Begin
                            //ISENÇÃO DO ICMS NO SIMPLES NACIONAL PARA FAIXA DE RECEITA BRUTA E COM COBRANÇA DO ICMS POR SUBSTITUIÇÃO TRIBUTÁRIA
                            // Se vf_perc_icmssn = 0 Rejeita
                            // Se vf_perc_icms <> 0 Rejeita
                            // Se vf_flg_st for False Rejeita
                            // Se vf_perc_diff <> 0 Rejeita Rejeita
                            // Permite Crédito = False
                            vl_log := vl_log + IfThen(vf_perc_icmssn  = 0,vl_msn_validacao[4]+vl_nometributo[vl_i],'');
                            vl_log := vl_log + IfThen(vf_perc_icms    <> 0,vl_msn_validacao[0]+vl_nometributo[vl_i],'');
                            vl_log := vl_log + IfThen(vf_flg_st = False,vl_msn_validacao[9]+vl_nometributo[vl_i]+vl_complemento_sn,'');
                            vl_log := vl_log + IfThen(vf_perc_diff <> 0,vl_msn_validacao[6]+vl_nometributo[vl_i]+vl_complemento_sn,'');
                            Result.IsCredICMS := False;
                          End;

          300,
          400            :Begin
                            // 300 - IMUNE
                            // 400 - NÃO TRIBUTADA PELO SIMPLES NACIONAL
                            vl_log := vl_log + IfThen(vf_perc_icmssn  = 0,vl_msn_validacao[4]+vl_nometributo[vl_i],'');
                            vl_log := vl_log + IfThen(vf_perc_icms    <> 0,vl_msn_validacao[0]+vl_nometributo[vl_i],'');
                            vl_log := vl_log + IfThen(vf_flg_st,vl_msn_validacao[10]+vl_nometributo[vl_i]+vl_complemento_sn+
                                                                vl_msn_validacao[12]+vl_nometributo[vl_i]+vl_complemento_sn,'');
                            vl_log := vl_log + IfThen(vf_perc_diff <> 0,vl_msn_validacao[6]+vl_nometributo[vl_i]+vl_complemento_sn,'');
                            Result.IsCredICMS := False;
                          End;

          500            :Begin
                            // ICMS COBRADO ANTERIORMENTE POR SUBSTITUIÇÃO TRIBUTÁRIA (SUBSTITUÍDO) OU POR ANTECIPAÇÃO
                            vl_log := vl_log + IfThen(vf_perc_icmssn  = 0,vl_msn_validacao[1]+vl_nometributo[vl_i],'');
                            vl_log := vl_log + IfThen(vf_perc_icms    <> 0,vl_msn_validacao[0]+vl_nometributo[vl_i],'');
                            vl_log := vl_log + IfThen(vf_flg_st,vl_msn_validacao[10]+vl_nometributo[vl_i]+vl_complemento_sn,'');
                            vl_log := vl_log + IfThen(vf_perc_diff <> 0,vl_msn_validacao[6]+vl_nometributo[vl_i]+vl_complemento_sn,'');
                            Result.IsCredICMS := False;
                          End;

          900            : Begin
                            // A aliquota e/ou valor do icms/icmsst não são validadas
                          End;
          // ----------------------------------------- SIMPLES NACIONAL ----------------------------------------- \\


          // ----------------------------------------- DÉBITO É CRÉDITO ----------------------------------------- \\
          // - Tributado somente pelo icms

          00       : Begin
                        // TRIBUTADA INTEGRALMENTE
                        // Se vf_perc_icmssn <> 0 Rejeita
                        // Se vf_perc_icms = 0 Rejeita
                        // Se vf_flg_st for verdadeiro Rejeita
                        // Se vf_perc_diff <> 0 Rejeita Rejeita
                        // Permite Crédito = Não
                        vl_log := vl_log + IfThen(vf_perc_icms    = 0,vl_msn_validacao[1]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen(vf_flg_st,vl_msn_validacao[3]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen(vf_perc_redbc_icms <> 0,vl_msn_validacao[5]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen(vf_perc_diff <> 0,vl_msn_validacao[6]+vl_nometributo[vl_i],'');
                        Result.IsCredICMS := False;
                     End;

          10       : Begin
                        // TRIBUTADA E COM COBRANÇA DO ICMS POR SUBSTITUIÇÃO TRIBUTÁRIA
                        // Se vf_perc_icmssn <> 0 Rejeita
                        // Se vf_perc_icms = 0 Rejeita
                        // Se vf_flg_st for Falso Rejeita
                        // Se vf_perc_diff <> 0 Rejeita Rejeita
                        // Permite Crédito = Não
                        vl_log := vl_log + IfThen(vf_perc_icms    = 0,vl_msn_validacao[1]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen((vf_flg_st = false) or (vf_perc_mva = 0),vl_msn_validacao[9]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen(vf_perc_redbc_icms <> 0,vl_msn_validacao[5]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen(vf_perc_diff <> 0,vl_msn_validacao[6]+vl_nometributo[vl_i],'');
                        Result.IsCredICMS := False;
                     End;

          20       : Begin
                        // COM REDUÇÃO DE BASE DE CÁLCULO
                        // Se vf_perc_icmssn <> 0 Rejeita
                        // Se vf_perc_icms = 0 Rejeita
                        // Se vf_flg_st for Verdadeiro Rejeita
                        // Se vf_perc_diff <> 0 Rejeita Rejeita
                        // Permite Crédito = Não
                        vl_log := vl_log + IfThen(vf_perc_icms    = 0,vl_msn_validacao[1]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen(vf_flg_st,vl_msn_validacao[3]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen(vf_perc_redbc_icms = 0,vl_msn_validacao[7]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen(vf_perc_diff <> 0,vl_msn_validacao[6]+vl_nometributo[vl_i],'');
                        Result.IsCredICMS := False;
                     End;

          51       : Begin
                        // DIFERIMENTO
                        // Se vf_perc_icmssn <> 0 Rejeita
                        // Se vf_perc_icms = 0 Rejeita
                        // Se vf_flg_st for Verdaddeiro Rejeita
                        // Se vf_perc_diff = 0 Rejeita Rejeita
                        // Permite Crédito = Não
                        vl_log := vl_log + IfThen(vf_perc_icms    = 0,vl_msn_validacao[1]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen(vf_flg_st,vl_msn_validacao[3]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen(vf_perc_redbc_icms <> 0,vl_msn_validacao[5]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen(vf_perc_diff = 0,vl_msn_validacao[8]+vl_nometributo[vl_i],'');
                        Result.IsCredICMS := False;
                     End;


          30       : Begin
                        // ISENTA OU NÃO TRIBUTADA E COM COBRANÇA DO ICMS POR SUBSTITUIÇÃO TRIBUTÁRIA
                        // Se vf_perc_icmssn <> 0 Rejeita
                        // Se vf_perc_icms = 0 Rejeita
                        // Se vf_flg_st for False Rejeita
                        // Se vf_perc_diff <> 0 Rejeita Rejeita
                        // Permite Crédito = Não
                        vl_log := vl_log + IfThen(vf_perc_icms    = 0,vl_msn_validacao[4]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen((vf_flg_st = false) or (vf_perc_mva = 0),vl_msn_validacao[9]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen(vf_perc_redbc_icms <> 0,vl_msn_validacao[5]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen(vf_perc_diff <> 0,vl_msn_validacao[6]+vl_nometributo[vl_i],'');
                        Result.IsCredICMS := False;
                     End;

          // - Icms St e ICMS foi cobrado da industria antecipadamente.
          60       : Begin
                        // ICMS COBRADO ANTERIORMENTE POR SUBSTITUIÇÃO TRIBUTÁRIA
                        // Se vf_perc_icmssn <> 0 Rejeita
                        // Se vf_perc_icms = 0 Rejeita
                        // Se vf_flg_st for False Rejeita
                        // Se vf_perc_diff <> 0 Rejeita Rejeita
                        // Permite Crédito = Não
                        vl_log := vl_log + IfThen(vf_perc_icms    = 0,vl_msn_validacao[1]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen((vf_flg_st = false) or (vf_perc_mva = 0),vl_msn_validacao[9]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen(vf_perc_redbc_icms <> 0,vl_msn_validacao[5]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen(vf_perc_diff <> 0,vl_msn_validacao[6]+vl_nometributo[vl_i],'');
                        Result.IsCredICMS := False;
                     End;

          // - Tributado somente pelo icms st
          70      : Begin
                        // COM REDUÇÃO DE BASE DE CÁLCULO E COBRANÇA DO ICMS POR SUBSTITUIÇÃO TRIBUTÁRIA
                        // Se vf_perc_icmssn <> 0 Rejeita
                        // Se vf_perc_icms = 0 Rejeita
                        // Se vf_flg_st for False Rejeita
                        // Se vf_perc_diff <> 0 Rejeita Rejeita
                        // Permite Crédito = Não
                        vl_log := vl_log + IfThen(vf_perc_icms    = 0,vl_msn_validacao[1]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen((vf_flg_st = false) or (vf_perc_mva = 0),vl_msn_validacao[9]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen(vf_perc_redbc_icms = 0,vl_msn_validacao[7]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen(vf_perc_diff <> 0,vl_msn_validacao[6]+vl_nometributo[vl_i],'');
                        Result.IsCredICMS := False;
                     End;

          // - Não Tributado Isenta, Não Incidente, suspensão
          40,41,50 : Begin
                        // 40 -  Isento
                        // 41 -  Não Tributado
                        // 50 -  Suspensão
                        // Se vf_perc_icmssn <> 0 Rejeita
                        // Se vf_perc_icms = 0 Rejeita
                        // Se vf_flg_st for Verdaddeiro Rejeita
                        // Se vf_perc_diff <> 0 Rejeita Rejeita
                        // Permite Crédito = Não
                        vl_log := vl_log + IfThen(vf_perc_icms    = 0,vl_msn_validacao[4]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen((vf_flg_st) or (vf_perc_mva <> 0),vl_msn_validacao[10]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen(vf_perc_redbc_icms <> 0,vl_msn_validacao[5]+vl_nometributo[vl_i],'');
                        vl_log := vl_log + IfThen(vf_perc_diff <> 0,vl_msn_validacao[6]+vl_nometributo[vl_i],'');
                        Result.IsCredICMS := False;
                     End;

          // - Outras Operações
          90       : Begin
                         // A aliquota e/ou valor do icms/icmsst não são validadas
                     End;
          // ----------------------------------------- DÉBITO É CRÉDITO ----------------------------------------- \\

        end;
      End;


      if vl_i = 1 then // ipi
      Begin
        case vf_cst_ipi of

          // Entrada e saida Tributada
          00,50 : Begin
                    // Se aliquota e/ou valor do ipi for igual a zero (0) - rejeita
                    vl_log := vl_log + IfThen(vf_perc_ipi = 0 ,vl_msn_validacao[1]+vl_nometributo[vl_i],'');
                    Result.IsCredIPI :=  Boolean( IfThen(vf_cst_ipi = 00,1,0) )
                  End;

          // Entrada e Saída Tributada com Alíquota Zero
          01,51 : Begin
                    // Se aliquota for igual a zero e o valor  do ipi diferente de zero (0) - rejeita
                    vl_log := vl_log + IfThen(vf_perc_ipi = 0 ,vl_msn_validacao[1]+vl_nometributo[vl_i],'');
                    Result.IsCredIPI := False;
                  End;

          // Entrada e Saída Isenta, Não Tributada, Imune, Suspensão
          02,52,03,
          53,04,54,
          05,55     : Begin
                        // Se aliquota e/ou valor do ipi for diferente de zero (0) - rejeita
                        vl_log := vl_log + IfThen(vf_perc_ipi <> 0 ,vl_msn_validacao[2]+vl_nometributo[vl_i],'');
                        Result.IsCredIPI := False;
                      End;

          // Entrada e Saída Outras Entradas
          49,99 : Begin
                    // A aliquota e/ou valor do ipi não são validadas
                    Result.IsCredIPI := False;
                  End;
        end;
      End;

      if vl_i in [2,3] then // pis - cofins
      Begin

          vl_container_cst_piscofins := IfThen(vl_i=3,vf_cst_pis,vf_cst_cofins);
          vl_container_aliquota_piscofins  := IfThen(vl_i=3,vf_perc_pis,vf_perc_pis);
          vl_container_perc_piscofins := IfThen(vl_i=3,vf_perc_pis,vf_perc_cofins);

          case vl_container_cst_piscofins of

            // Pis/Cofins Entrada e saida Tributada
            01,02,03,
            05,50,51,
            52,53,54,
            55,56,60,
            61,62,63,
            64,65,66,
            67,70,75  : Begin
                          // Se aliquota e/ou valor do pis/cofins for igual a zero (0) - rejeita
                          vl_log := vl_log + IfThen((vl_container_aliquota_piscofins = 0) or (vl_container_perc_piscofins = 0) ,
                                                            vl_msn_validacao[1]+vl_nometributo[vl_i],'');
                          Result.IsCredPIS := Boolean( IfThen(vl_container_cst_piscofins in [50,51,52,53,54,55,56,60,61,62,63,64,65,66,67],1,0) );
                          Result.IsCredCOFINS := Boolean( IfThen(vl_container_cst_piscofins in [50,51,52,53,54,55,56,60,61,62,63,64,65,66,67],1,0) );


                        End;

            // Pis/Cofins Entrada e saida Tributada com aliquota zero (0)
            04,06     : Begin
                          // Se aliquota for igual a zero (0) e ou valor do pis/cofins diferente de zero (0) - rejeita
                          vl_log := vl_log + IfThen((vl_container_aliquota_piscofins = 0) or (vl_container_perc_piscofins <> 0) ,
                                                            vl_msn_validacao[2]+vl_nometributo[vl_i],'');
                          Result.IsCredPIS := False;
                          Result.IsCredCOFINS := False;
                        End;

            // Pis/Cofins Entrada e saida Isenta, Não Incidente, suspensão
            07,08,09,
            71,72,73,
            74        : Begin
                          // Se aliquota e/ou valor do pis/cofins for igual a zero (0) - rejeita
                          vl_log := vl_log + IfThen((vl_container_aliquota_piscofins <> 0) or (vl_container_perc_piscofins <> 0) ,
                                                            vl_msn_validacao[0]+vl_nometributo[vl_i],'');
                          Result.IsCredPIS := False;
                          Result.IsCredCOFINS := False;
                        End;

            // Pis/Cofins Entrada e saida Outras Operações
            49,98,99  : Begin
                          Result.IsCredPIS := False;
                          Result.IsCredCOFINS := False;
                        End;
          end;
      End;
    end;

  Finally
      Result.IsValidate := Boolean( IfThen(vl_log <> '',0,1) );
      //Result.IsCredICMS := ;
      //Result.IsCredIPI := ;
      //Result.IsCredPIS := ;
      //Result.IsCredCOFINS := ;
      Result.Mensage := vl_log;
      {if vf_save_log then
      Begin
        save_log_file(vl_dir_log+vl_log_filename,vl_log);
      end;}



  end;
end;

Function TUtilities.Percentual(const pPercentual: Double; const pValor: Currency): Currency;
begin
  Result := 0;

  if pValor > 0 then
    Result := RoundTo((pValor * pPercentual) / 100,-2);
end;

Function TUtilities.RetornaPercentual(const pValorTotal, pValor: Currency): Currency;
begin
  Result := 0;

  if pValorTotal > 0 then
    Result := ((pValor / pValorTotal) * 100);
end;

procedure TUtilities.AssignArrayString(const Aorigem: array of string; out ADestino : TArrayofString);
var
  I,X: Integer;
begin
    X := Length(Aorigem);
    SetLength(ADestino, X);
    for I := Low(Aorigem) to High(Aorigem) do
    begin
      ADestino[I] := Aorigem[i]
    end;
end;

procedure TUtilities.AssignArrayVariant(const Aorigem: array of Variant; out ADestino : TArrayofVariant);
var
  I,X: Integer;
begin
    X := Length(Aorigem);
    SetLength(ADestino, X);
    for I := Low(Aorigem) to High(Aorigem) do
    begin
      ADestino[I] := Aorigem[i]
    end;
end;

function TInputQueryExForm.CloseQuery: Boolean;
begin
  Result := (ModalResult = mrCancel) or (not Assigned(FCloseQueryFunc)) or FCloseQueryFunc();
end;

function TUtilities.GetReturnValueFromSQL(vfDBConn: TUniConnection;
                                          vfSQL: string;
                                          vfFieldsReturn: string;
                                          vfFormatReturn: TFieldType = ftUnknown
                                         ): Variant;
var
  uQuerySQL: TUniQuery;
begin

  try
    uQuerySQL := TUniQuery.Create(nil);

    with uQuerySQL do
    begin
      AutoCalcFields := True;
      Options.AutoPrepare := True;
      Connection := vfDBConn;
      Close;
      SQL.Clear;
      SQL.Add(vfSQL);

      if not Prepared then Prepare;

      Execute;

      if vfFormatReturn = ftUnknown then
         Result := Fieldbyname(vfFieldsReturn).AsVariant
      else
      if vfFormatReturn = ftInteger then
         Result := Fieldbyname(vfFieldsReturn).AsInteger
      else
      if vfFormatReturn = ftBoolean then
         Result := Fieldbyname(vfFieldsReturn).AsBoolean
      else
      if vfFormatReturn = ftString then
         Result := Fieldbyname(vfFieldsReturn).AsString
      else
      if vfFormatReturn = ftDateTime then
         Result := Fieldbyname(vfFieldsReturn).AsDateTime
      else
      if vfFormatReturn = ftFloat then
         Result := Fieldbyname(vfFieldsReturn).AsFloat
      else
      if vfFormatReturn = ftCurrency then
         Result := Fieldbyname(vfFieldsReturn).AsCurrency
      else
         Result := Fieldbyname(vfFieldsReturn).AsVariant;

    end;
  finally
    uQuerySQL.Close;
    uQuerySQL.Destroy;
    uQuerySQL := nil;
  end;
end;

function TUtilities.InputBoxData(ACaption, APrompt : string; ADefault : Tdate): TDate;
var
  Form: TForm;
  Prompt: TLabel;
  Edit : TscDateEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
  Value: Tdate;
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  Result := ADefault;
  Form := TForm.Create(Application);
  with Form do
  try
    Canvas.Font := Font;
    for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
    for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
    GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(DialogUnits));
    DialogUnits.X := DialogUnits.X div 52;
    BorderStyle := bsDialog;
    Caption := ACaption;
    ClientWidth := MulDiv(180, DialogUnits.X, 4);
    ClientHeight := MulDiv(63, DialogUnits.Y, 8);
    Position := poScreenCenter;
    Prompt := TLabel.Create(Form);
    with Prompt do
    begin
      Parent := Form;
      AutoSize := True;
      Left := MulDiv(8, DialogUnits.X, 4);
      Top := MulDiv(8, DialogUnits.Y, 8);
      Caption := APrompt;
    end;

    {Edit := TMaskEdit.Create(Form);
    with Edit do
    begin
      Parent := Form;
      Left := Prompt.Left;
      Top := MulDiv(19, DialogUnits.Y, 8);
      Width := MulDiv(164, DialogUnits.X, 4);
      MaxLength := 255;
      EditMask := '!99/99/0099;1; ';
      SelectAll;
    end;}

    Edit := TscDateEdit.Create(Form);
    with Edit do
    begin
      Parent := Form;
      Left := Prompt.Left;
      Top := MulDiv(19, DialogUnits.Y, 8);
      Width := MulDiv(164, DialogUnits.X, 4);
      MaxLength := 255;
      Date := ADefault;
      SelectAll;
    end;

    ButtonTop := MulDiv(41, DialogUnits.Y, 8);
    ButtonWidth := MulDiv(50, DialogUnits.X, 4);
    ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
    with TButton.Create(Form) do
    begin
      Parent := Form;
      Caption := 'OK';
      ModalResult := mrOk;
      Default := True;
      SetBounds(MulDiv(38, DialogUnits.X, 4),ButtonTop, ButtonWidth,ButtonHeight);
    end;
    with TButton.Create(Form) do
    begin
      Parent := Form;
      Caption := 'Cancel';
      ModalResult := mrCancel;
      Cancel := True;
      SetBounds(MulDiv(92, DialogUnits.X, 4),ButtonTop, ButtonWidth,ButtonHeight);
    end;
    if ShowModal = mrOk then
    begin
      Value := Edit.Date;
      Result := Value;
    end;
  finally
    Form.Free;
    Form:=nil;
  end;
end;

{
function TUtilities.InsertArrayValue(vfDBConn: TUniConnection;
                                     vfTable: string;
                                     vfFieldsInserts: array of string;
                                     vfFieldsParam: array of string;
                                     vfFieldsParamValour: array of const
                                    ):Boolean;
var
  uQuerySQL: TUniQuery;
  vl_i, vl_x,Z, vl_numfieldsParam, vl_numfieldsReturn : integer;
  vl_condsearch, vlFieldsReturn : string;
  vlVarReturn: rc_fields_return;
begin

  try

    uQuerySQL := TUniQuery.Create(nil);

    with uQuerySQL do
    begin
      AutoCalcFields := True;
      Options.AutoPrepare := True;
      vl_numfieldsParam  := Length(vfFieldsParam);
      vl_numfieldsReturn := Length(vfFieldsSelects);
      SetLength(vlVarReturn,vl_numfieldsReturn);
      Connection := vfDBConn;
      Close;
      SQL.Clear;
      vlFieldsReturn := '';

      for Z := 0 to vl_numfieldsReturn-1 do
      begin
        vlFieldsReturn := vlFieldsReturn + vfFieldsSelects[Z]+' as VALUE'+IntToStr(Z+1)+ifthen(Z <> vl_numfieldsReturn-1,',','');
      end;

      SQL.Add('SELECT '+Trim(vlFieldsReturn)+' FROM '+Trim(vfTable)+' WHERE ');

      for vl_i := 0 to vl_numfieldsParam - 1 do
      begin
        if vl_i = 0 then
        begin
            SQL.Add('(' + Trim(vfFieldsParam[vl_i]) + '=' + Trim(VarRecToStr(vfFieldsParamValour[vl_i]) + ')'))
        end
        else
        begin
          SQL.Add(' AND (' + Trim(vfFieldsParam[vl_i]) + '=' + Trim(VarRecToStr(vfFieldsParamValour[vl_i]) + ')'));
        end
      end;


             // Trim(vfFieldsParam)+' = '+Trim(VarRecToStr(vfFieldsParamValour[0])));

      if not Prepared then Prepare;

      SQL.SaveToFile('sql.log');

      Execute;

      for vl_x := 0 to vl_numfieldsReturn-1 do
      begin
        if vl_x = 0 then First;
        vlVarReturn[vl_x] :=  FieldByName('VALUE'+IntToStr(vl_x+1)).AsVariant;
        Next;
      end;
      Result := vlVarReturn;
    end;
  finally
    uQuerySQL.Destroy;
    uQuerySQL := nil;
    Initialize(vlVarReturn); // remove referências dos campos dinâmicos(string, array).
    FillChar(vlVarReturn, SizeOf(vlVarReturn), 0); // limpa as variáveis ordinais
  end;
end;       }


{
implementar aqui o novo recurso
function InputQueryEx(const ACaption: string; const APrompts: array of string; var AValues: array of string; CloseQueryFunc: TInputValidateQueryFunc): Boolean;
var
  I, J: Integer;
  Form: TInputQueryForm;
  Prompt: TLabel;
  Edit: TEdit;
  DialogUnits: TPoint;
  PromptCount, CurPrompt: Integer;
  MaxPromptWidth: Integer;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;

  function GetPromptCaption(const ACaption: string): string;
  begin
    if (Length(ACaption) > 1) and (ACaption[1] < #32) then
      Result := Copy(ACaption, 2, MaxInt)
    else
      Result := ACaption;
  end;

  function GetMaxPromptWidth(Canvas: TCanvas): Integer;
  var
    I: Integer;
    LLabel: TLabel;
  begin
    Result := 0;
    // Use a TLabel rather than an API such as GetTextExtentPoint32 to
    // avoid differences in handling characters such as line breaks.
    LLabel := TLabel.Create(nil);
    try
      for I := 0 to PromptCount - 1 do
      begin
        LLabel.Caption := GetPromptCaption(APrompts[I]);
        Result := Max(Result, LLabel.Width + DialogUnits.X);
      end;
    finally
      LLabel.Free;
    end;
  end;

  function GetPasswordChar(const ACaption: string): Char;
  begin
    if (Length(ACaption) > 1) and (ACaption[1] < #32) then
      Result := '*'
    else
      Result := #0;
  end;

begin
  if Length(AValues) < Length(APrompts) then
    raise EInvalidOperation.CreateRes(@SPromptArrayTooShort);
  PromptCount := Length(APrompts);
  if PromptCount < 1 then
    raise EInvalidOperation.CreateRes(@SPromptArrayEmpty);
  Result := False;
  Form := TInputQueryForm.CreateNew(Application);
  with Form do
    try
      FCloseQueryFunc :=
        function: Boolean
        var
          I, J: Integer;
          LValues: array of string;
          Control: TControl;
        begin
          Result := True;
          if Assigned(CloseQueryFunc) then
          begin
            SetLength(LValues, PromptCount);
            J := 0;
            for I := 0 to Form.ControlCount - 1 do
            begin
              Control := Form.Controls[I];
              if Control is TEdit then
              begin
                LValues[J] := TEdit(Control).Text;
                Inc(J);
              end;
            end;
            Result := CloseQueryFunc(LValues);
          end;
        end;
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      MaxPromptWidth := GetMaxPromptWidth(Canvas);
      BorderStyle := bsDialog;
      Caption := ACaption;
      ClientWidth := MulDiv(180 + MaxPromptWidth, DialogUnits.X, 4);
      PopupMode := pmAuto;
      Position := poScreenCenter;
      CurPrompt := MulDiv(8, DialogUnits.Y, 8);
      Edit := nil;
      for I := 0 to PromptCount - 1 do
      begin
        Prompt := TLabel.Create(Form);
        with Prompt do
        begin
          Parent := Form;
          Caption := GetPromptCaption(APrompts[I]);
          Left := MulDiv(8, DialogUnits.X, 4);
          Top := CurPrompt;
          Constraints.MaxWidth := MaxPromptWidth;
          WordWrap := True;
        end;
        Edit := TEdit.Create(Form);
        with Edit do
        begin
          Parent := Form;
          PasswordChar := GetPasswordChar(APrompts[I]);
          Left := Prompt.Left + MaxPromptWidth;
          Top := Prompt.Top + Prompt.Height - DialogUnits.Y -
            (GetTextBaseline(Edit, Canvas) - GetTextBaseline(Prompt, Canvas));
          Width := Form.ClientWidth - Left - MulDiv(8, DialogUnits.X, 4);
          MaxLength := 255;
          Text := AValues[I];
          SelectAll;
          Prompt.FocusControl := Edit;
        end;
        CurPrompt := Edit.Top + Edit.Height + 5;
      end;
      ButtonTop := Edit.Top + Edit.Height + 15;
      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := SMsgDlgOK;
        ModalResult := mrOk;
        Default := True;
        SetBounds(Form.ClientWidth - (ButtonWidth + MulDiv(8, DialogUnits.X, 4)) * 2, ButtonTop, ButtonWidth, ButtonHeight);
      end;
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := SMsgDlgCancel;
        ModalResult := mrCancel;
        Cancel := True;
        SetBounds(Form.ClientWidth - (ButtonWidth + MulDiv(8, DialogUnits.X, 4)), ButtonTop, ButtonWidth, ButtonHeight);
        Form.ClientHeight := Top + Height + 13;
      end;
      if ShowModal = mrOk then
      begin
        J := 0;
        for I := 0 to ControlCount - 1 do
          if Controls[I] is TEdit then
          begin
            Edit := TEdit(Controls[I]);
            AValues[J] := Edit.Text;
            Inc(J);
          end;
        Result := True;
      end;
    finally
      Form.Free;
    end;
end; }

end.
