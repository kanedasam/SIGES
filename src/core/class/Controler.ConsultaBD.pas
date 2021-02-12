unit Controler.ConsultaBD;
interface

uses Data.DB, System.Variants, System.SysUtils, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Generics.Collections, Controler.ConexaoFD;
type

  TParamsConsultaBDValue = record
    fvalue: variant;
    ftype: TFieldType; // ftString, ftInteger, ftFloat, ftDateTime
  end;

  TParamList = class
  private
    fLista: TObjectDictionary<string, TParamsConsultaBDValue>;
    procedure SetParams(pQuery: TFDQuery);
  public
    constructor Create;
    destructor Destroy; override;
    class function CreateNew: TParamList;
    function Adiciona(pNomPar: string; pType: TFieldType; pValue: variant): TParamList;
    class function VarVoidToNull(Value: Variant): Variant;
    class function VarToInt(Value: Variant): Integer;
    class function VarToString(Value: Variant): String;
    class function VarToFloat(Value: Variant): Double;
    class function VarToDateTime(Value: Variant): TDateTime;
  end;

  TConsultaBD = class
  private
    Query: TFDQuery;
  public
    constructor Create;
    destructor Destroy; override;
    // funcoes extras
    class function GetSQLText(pNomCst: string): string;
    class function GeraProximoCodigo(pFieldName, pTable: String;
      const pWhere: string = ''; const pIncrement: Integer = 1): Integer;
    // funcoes basicas com texto; buscando na base; com e sem parametros
    // devolve se consulta está vazia
    class function QueryIsEmptyByNomCst(pNomCst: String): Boolean; overload;
    class function QueryIsEmptyByNomCst(pNomCst: String;pParam: TParamList): Boolean; overload;
    class function QueryIsEmpty(pSQLText: String): Boolean; overload;
    class function QueryIsEmpty(pSQLText: String; pParam: TParamList): Boolean; overload;
    // devolve o valor da primeira linha, primeira coluna
    class function QueryGetValueFirstFieldByNomCst(pNomCst: String) : variant; overload;
    class function QueryGetValueFirstFieldByNomCst(pNomCst: String; pParam: TParamList): variant; overload;
    class function QueryGetValueFirstField(pSQLText: String): variant; overload;
    class function QueryGetValueFirstField(pSQLText: String; pParam: TParamList): variant; overload;
    // Devolve a query aberta
    class procedure QueryOpenByNomCst(pQuery: TFDQuery;pNomCst: string); overload;
    class procedure QueryOpenByNomCst(pQuery: TFDQuery; pNomCst: string;pParam: TParamList); overload;
    class procedure QueryOpen(pQuery: TFDQuery; pSQLText: string); overload;
    class procedure QueryOpen(pQuery: TFDQuery; pSQLText: string;pParam: TParamList); overload;
    class procedure QueryOpen(pSQLText: string;pParam: TParamList); overload;
    // Executa um comando
    class function QueryExecSQLByNomCst(pNomCst: string): Integer; overload;
    class function QueryExecSQLByNomCst(pNomCst: string; pParam: TParamList): Integer; overload;
    class function QueryExecSQL(pSQLText: string): Integer; overload;
    class function QueryExecSQL(pSQLText: string; pParam: TParamList) : Integer; overload;
    class function GetDataExecSQL(pSQLText: string; pParam: TParamList) : IFDDataSetReference;
    class function GetDataOpenSQL(pSQLText: string; pParam: TParamList) : IFDDataSetReference;
    // Devolve a Memtable preenchida
    class procedure MemTableOpenByNomCst(pMemTable: TFDMemTable; pNomCst: string); overload;
    class procedure MemTableOpenByNomCst(pMemTable: TFDMemTable; pNomCst: string; pParam: TParamList); overload;
    class procedure MemTableOpen(pMemTable: TFDMemTable; pSQLText: string); overload;
    class procedure MemTableOpen(pMemTable: TFDMemTable; pSQLText: string; pParam: TParamList); overload;
  end;

  TCacheConsultaBD = class // unico responsavel por buscar o texsql no banco
  private
    fQueryPadrao: TFDQuery;
    fCacheConsultaSql: TObjectDictionary<string, string>;
    fMaxCache: Integer;
    fdatCacheExpire: TDateTime;
    constructor Create;
    destructor Destroy; override;
    function GetSQLText(pNomCst: string): string;
  end;

implementation

uses Provider, DBClient;

var
  ObjCacheConsultaBD: TCacheConsultaBD;

  { CacheConsultaBD }
function CacheConsultaBD: TCacheConsultaBD;
begin
  if not Assigned(ObjCacheConsultaBD) then
    ObjCacheConsultaBD := TCacheConsultaBD.Create;
  result := ObjCacheConsultaBD;
end;

constructor TCacheConsultaBD.Create;
begin
  fCacheConsultaSql := TObjectDictionary<string, string>.Create;
  fMaxCache := 200;
  // ucnConstanteSistema.ConstSist.Valor['MAX_NumConsultaSQLCache'];
  fdatCacheExpire := now + EncodeTime(0, 30, 0, 0);
  fQueryPadrao := TFDQuery.Create(nil);
  fQueryPadrao.ConnectionName := 'bd_dac';
end;

destructor TCacheConsultaBD.Destroy;
begin
  fCacheConsultaSql.Free;
  fQueryPadrao.Free;
end;

function TCacheConsultaBD.GetSQLText(pNomCst: string): string;
var
  tex_sql: string;
begin
  // limpa o cache
  if Self.fdatCacheExpire < now then
  begin
    fCacheConsultaSql.Clear;
    fdatCacheExpire := now + EncodeTime(0, 3, 0, 0);
  end;
  // busca dados do cache
  if (not fCacheConsultaSql.TryGetValue(pNomCst, tex_sql)) then
  begin
    tex_sql :=
      TParamList.VarToString(
        TConsultaBD.QueryGetValueFirstField
          ('select tex_sql from bdaudit.dbo.consulta_sql where nom_cst = ' + '''' +
          pNomCst + ''''));

    if Trim(tex_sql) = '' then
      raise Exception.Create('Consulta SQL: '+ pNomCst+ ' Não Cadastrada!');

    // se passou do tamanho maximo do cache, para de guardar no cache
    if fCacheConsultaSql.Count <= Self.fMaxCache then
      fCacheConsultaSql.Add(pNomCst, tex_sql);
  end;
  result := tex_sql;
end;

{ TParamList }
class function TParamList.CreateNew: TParamList;
begin
  result := TParamList.Create;
end;

constructor TParamList.Create;
begin
  fLista := TObjectDictionary<string, TParamsConsultaBDValue>.Create;
end;

destructor TParamList.Destroy;
begin
  fLista.Clear;
  fLista.Free;
end;

function TParamList.Adiciona(pNomPar: string; pType: TFieldType;
  pValue: variant): TParamList;
var
  r: TParamsConsultaBDValue;
begin
  r.fvalue := pValue;
  r.ftype := pType;
  fLista.Add(pNomPar, r);
  result := Self;
end;

class function TParamList.VarToDateTime(Value: Variant): TDateTime;
begin
  if (Value = Null) then
     Result := 0
  else Result := Value
end;

class function TParamList.VarToFloat(Value: Variant): Double;
begin
  if (Value = Null) then
     Result := 0
  else Result := Value;
end;

class function TParamList.VarToInt(Value: Variant): Integer;
begin
  if (Value = Null) then
     Result := 0
  else Result := Value;
end;

class function TParamList.VarToString(Value: Variant): String;
begin
  if (Value = Null) then
     Result := ''
  else Result := Value;
end;

class function TParamList.VarVoidToNull(Value: Variant): Variant;
var
  ValueModf : Variant;
  mVarType : Word;
begin
  ValueModf := Value;
  mVarType  := VarType(ValueModf);

  if (mVarType = varString) or (mVarType = varUString) then
  begin
    if (Value = '') then
     ValueModf := null;
  end
  else
  if ((mVarType = varDate) or (mVarType = varInteger)) then
     if (Value = 0) then
        ValueModf := null;

  Result := ValueModf;
end;

{ TConsultaBD }
constructor TConsultaBD.Create;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := Controler.ConexaoFD.Conexao.Connection;
  Query.ConnectionName := 'bd_dac';
end;

destructor TConsultaBD.Destroy;
begin

  Query.Active := False;
  Query.Free;
  Controler.ConexaoFD.Conexao.Connection.Close;
  Controler.ConexaoFD.Conexao.Destroy;
end;

class function TConsultaBD.GeraProximoCodigo(pFieldName, pTable: String;
  const pWhere: string = ''; const pIncrement: Integer = 1): Integer;
var
  sSQL: String;
  sWhere: String;
begin
  sWhere := pWhere;
  // verifica se tem o texto 'where' em pWhere
  if (Trim(sWhere) <> '') and (pos('where', LowerCase(sWhere)) = 0) then
    sWhere := 'Where ' + pWhere;

  sSQL := 'select isnull(max(' + pFieldName + '),0)' + ' from ' + pTable +
    ' ' + sWhere;

  result := QueryGetValueFirstField(sSQL) + pIncrement;
end;

class function TConsultaBD.GetDataExecSQL(pSQLText: string;
  pParam: TParamList): IFDDataSetReference;
var
  q: TFDQuery;
begin
  q := CacheConsultaBD.fQueryPadrao;
  q.ClearDetails;
  q.Sql.Text := pSQLText;
  if Assigned(pParam) then
  begin
    pParam.SetParams(q);
    pParam.Free;
  end;
  q.ExecSQL;
  result := q.Data;
  //q.Active := False;
  //q.ClearDetails;
end;

class function TConsultaBD.GetDataOpenSQL(pSQLText: string;
  pParam: TParamList): IFDDataSetReference;
var
  q: TFDQuery;
begin
  q := CacheConsultaBD.fQueryPadrao;
  q.ClearDetails;
  q.Sql.Text := pSQLText;
  if Assigned(pParam) then
  begin
    pParam.SetParams(q);
    pParam.Free;
  end;
  q.Open;
  result := q.Data;
  //q.Active := False;
  //q.ClearDetails;
end;

class function TConsultaBD.GetSQLText(pNomCst: string): string;
begin
  result := CacheConsultaBD.GetSQLText(pNomCst);
end;

// QueryIsEmpty
class function TConsultaBD.QueryIsEmptyByNomCst(pNomCst: String): Boolean;
begin
  result := TConsultaBD.QueryIsEmptyByNomCst(pNomCst, nil);
end;

class function TConsultaBD.QueryIsEmptyByNomCst(pNomCst: String;
  pParam: TParamList): Boolean;
begin
  result := QueryIsEmpty(CacheConsultaBD.GetSQLText(pNomCst), pParam);
end;

class function TConsultaBD.QueryIsEmpty(pSQLText: String): Boolean;
begin
  result := TConsultaBD.QueryIsEmpty(pSQLText, nil);
end;

class function TConsultaBD.QueryIsEmpty(pSQLText: String;
  pParam: TParamList): Boolean;
var
  q: TFDQuery;
begin
  q := CacheConsultaBD.fQueryPadrao;
  q.Active := False;
  q.ClearDetails;
  q.Sql.Text := pSQLText;
  if Assigned(pParam) then
  begin
    pParam.SetParams(q);
    pParam.Free;
  end;
  q.Active := True;
  result := q.IsEmpty;
  q.Active := False;
  q.ClearDetails;
end;

// QueryGetValueFirstField
class function TConsultaBD.QueryGetValueFirstFieldByNomCst
  (pNomCst: String): variant;
begin
  result := TConsultaBD.QueryGetValueFirstFieldByNomCst(pNomCst, nil);
end;

class function TConsultaBD.QueryGetValueFirstFieldByNomCst(pNomCst: String;
  pParam: TParamList): variant;
begin
  result := TConsultaBD.QueryGetValueFirstField
    (CacheConsultaBD.GetSQLText(pNomCst), pParam);
end;

class function TConsultaBD.QueryGetValueFirstField(pSQLText: String): variant;
begin
  result := TConsultaBD.QueryGetValueFirstField(pSQLText, nil);
end;

class function TConsultaBD.QueryGetValueFirstField(pSQLText: String;
  pParam: TParamList): variant;
var
  q: TFDQuery;
begin
  q := CacheConsultaBD.fQueryPadrao;
  q.Active := False;
  q.ClearDetails;
  q.Sql.Text := pSQLText;
  if Assigned(pParam) then
  begin
    pParam.SetParams(q);
    pParam.Free;
  end;
  q.Active := True;
  result := q.Fields[0].Value;
  q.Active := False;
  q.ClearDetails;
end;

// QueryOpen
class procedure TConsultaBD.QueryOpenByNomCst(pQuery: TFDQuery;
  pNomCst: string);
begin
  TConsultaBD.QueryOpenByNomCst(pQuery, pNomCst, nil);
end;

class procedure TConsultaBD.QueryOpen(pSQLText: string; pParam: TParamList);
var q : TFDQuery;
begin
  q := CacheConsultaBD.fQueryPadrao;
  q.ClearDetails;
  q.ConnectionName := CacheConsultaBD.fQueryPadrao.ConnectionName;
  q.Sql.Text := pSQLText;

  if Assigned(pParam) then
  begin
    pParam.SetParams(q);
    pParam.Free;
  end;
  q.Active := True;
end;

class procedure TConsultaBD.QueryOpenByNomCst(pQuery: TFDQuery; pNomCst: string;
  pParam: TParamList);
begin
  TConsultaBD.QueryOpen(pQuery, CacheConsultaBD.GetSQLText(pNomCst), pParam);
end;

class procedure TConsultaBD.QueryOpen(pQuery: TFDQuery; pSQLText: string);
begin
  TConsultaBD.QueryOpen(pQuery, pSQLText, nil);
end;

class procedure TConsultaBD.QueryOpen(pQuery: TFDQuery; pSQLText: string;
  pParam: TParamList);
begin
  pQuery.Active := False;
  pQuery.ClearDetails;
  pQuery.ConnectionName := CacheConsultaBD.fQueryPadrao.ConnectionName;
  pQuery.Sql.Text := pSQLText;
  if Assigned(pParam) then
  begin
    pParam.SetParams(pQuery);
    pParam.Free;
  end;
  pQuery.Active := True;
end;

// QueryExec
class function TConsultaBD.QueryExecSQLByNomCst(pNomCst: string): Integer;
begin
  result := TConsultaBD.QueryExecSQLByNomCst(pNomCst, nil);
end;

class function TConsultaBD.QueryExecSQLByNomCst(pNomCst: string;
  pParam: TParamList): Integer;
begin
  result := TConsultaBD.QueryExecSQL
    (CacheConsultaBD.GetSQLText(pNomCst), pParam);
end;

class function TConsultaBD.QueryExecSQL(pSQLText: string): Integer;
begin
  result := TConsultaBD.QueryExecSQL(pSQLText, nil);
end;

class function TConsultaBD.QueryExecSQL(pSQLText: string;
  pParam: TParamList): Integer;
var
  q: TFDQuery;
begin
  q := CacheConsultaBD.fQueryPadrao;
  q.ClearDetails;
  q.Sql.Text := pSQLText;
  if Assigned(pParam) then
  begin
    pParam.SetParams(q);
    pParam.Free;
  end;
  q.ExecSQL;
  result := q.RowsAffected;
  q.Active := False;
  q.ClearDetails;
end;

// MemTable
class procedure TConsultaBD.MemTableOpenByNomCst(pMemTable: TFDMemTable;
  pNomCst: string);
begin
  TConsultaBD.MemTableOpenByNomCst(pMemTable, pNomCst, nil);
end;

class procedure TConsultaBD.MemTableOpenByNomCst(pMemTable: TFDMemTable;
  pNomCst: string; pParam: TParamList);
begin
  TConsultaBD.MemTableOpen(pMemTable,
    CacheConsultaBD.GetSQLText(pNomCst), pParam);
end;

class procedure TConsultaBD.MemTableOpen(pMemTable: TFDMemTable;
  pSQLText: string);
begin
  TConsultaBD.MemTableOpen(pMemTable, pSQLText, nil);
end;

class procedure TConsultaBD.MemTableOpen(pMemTable: TFDMemTable;
  pSQLText: string; pParam: TParamList);
var
  q: TFDQuery;
begin
  if pMemTable.Active then
     pMemTable.Close;

  q := CacheConsultaBD.fQueryPadrao;
  q.ClearDetails;
  q.Sql.Text := pSQLText;
  if Assigned(pParam) then
  begin
    pParam.SetParams(q);
    pParam.Free;
  end;
  q.Active := True;
  pMemTable.Data := q.Data;
  q.Active := False;
  q.ClearDetails;
end;

procedure TParamList.SetParams(pQuery: TFDQuery);
var
  Key: string;
begin
  for Key in Self.fLista.Keys do
  begin
    if fLista.Items[Key].fvalue = Null then
    begin
       pQuery.ParamByName(Key).Value := fLista.Items[Key].fvalue;
       pQuery.ParamByName(Key).DataType := fLista.Items[Key].ftype;
       Continue;
    end;

    case fLista.Items[Key].ftype of
      ftString:   pQuery.ParamByName(Key).AsString := fLista.Items[Key].fvalue;
      ftInteger:  pQuery.ParamByName(Key).AsInteger := fLista.Items[Key].fvalue;
      ftFloat:    pQuery.ParamByName(Key).AsFloat := fLista.Items[Key].fvalue;
      ftDateTime: pQuery.ParamByName(Key).AsDateTime := fLista.Items[Key].fvalue;
    else
      pQuery.ParamByName(Key).Value := fLista.Items[Key].fvalue;
    end
  end;
end;

initialization

finalization
CacheConsultaBD.Free;

end.
