unit Model.TypedGeral;

interface

uses
  Data.DB;

type

  TArrTexto = array of string;
  TRecordPosition = (rpNone,rpFirst,rpLast);
  TAcao = (aAdd, aAddAll, aEdit, aDel, aDelAll, aRefresh, aSave, aCancel, aClose);
  TActionWindow = (awShow,awHide,awClose);
  TTypeMessage = (tmSimple,tmConfirmation);
  TForm_Style     = (fswNormal, fswMDIChild, fswMDIForm, fswStayOnTop);
  TForm_State      = (fsNoModal, fsModal);
  TypeDrive     = (tdRemovivel, tdFixo, tdRede, tdCDROM, tdRAMDISK, tdNenhum);



  TMnemonicos    = (mn_ID,
                    mn_COD_TIPO_ENTIDADE,
                    mn_COD_TIPO_PESSOA,
                    mn_NOME,
                    mn_CPF_CNPJ,
                    mn_IDENTIDADE,
                    mn_EMAIL,
                    mn_COD_ENTIDADE_ENDERECO,
                    mn_COD_ENTIDADE,
                    mn_COD_TIPO_ENDERECO,
                    mn_CEP,
                    mn_LOGRADOURO,
                    mn_NUMERO,
                    mn_COMPLEMENTO,
                    mn_BAIRRO,
                    mn_CIDADE,
                    mn_ESTADO,
                    mn_PAIS,
                    mn_DSC_ENDERECO,
                    mn_DSC_ENTIDADE,
                    mn_DSC_PESSOA,
                    mn_NONE);

  TFieldDefs = record
      FieldName: string;
      FieldReName: string;
      FieldWith: Integer;
  end;

  TFieldSource = record
      TitleName: string;
      FieldName: string;
      OriginalName: string;
      DataType: TFieldType;
      IndexField: Integer;
  end;

  TChkConsist = record
      Mensagem : string;
      Aprovado : Boolean;
  end;

  TRefMnemonicos = class
  private
    fMnemonicoName : string;
    fMnemonico : TMnemonicos;
    FFieldName: string;
    FTexto : string;
    FVariaveisTexto : TArrTexto;
    FValoresTexto : TArrTexto;
    procedure SetMnemonico(const Value: TMnemonicos);
    procedure SetFieldName(const Value: string);
  public
    constructor Create;
    destructor  Destroy;
    property FieldName : string read FFieldName write SetFieldName;
    property Mnemonico : TMnemonicos read fMnemonico write SetMnemonico;
    property MnemonicoName : string read fMnemonicoName;
    property Texto : string read FTexto write FTexto;
    property VariaveisTexto : TArrTexto read FVariaveisTexto write FVariaveisTexto;
    property ValoresTexto : TArrTexto read FValoresTexto write FValoresTexto;
  end;

  function IntegerToTypeMessage(ID: Integer): TTypeMessage;
  function TypeMessageToInteger(ID: TTypeMessage):Integer ;
  function MnemonicosToInteger(ID: TMnemonicos):Integer;
  function IntegerToMnemonicos(ID: Integer):TMnemonicos;


implementation

uses TypInfo, Model.ConstantsGerais;

function IntegerToActionWindow(ID: Integer): TActionWindow;
begin
  Case ID of
    0 : result := awShow;
    1 : result := awHide;
    2 : result := awClose;
  end;
end;

function ActionWindowToInteger(ID: TActionWindow):Integer ;
begin
  Case ID of
    awShow  : result := 0;
    awHide  : result := 1;
    awClose : result := 2;
  end;
end;

function IntegerToTypeMessage(ID: Integer): TTypeMessage;
begin
  Case ID of
    0 : result := tmSimple;
    1 : result := tmConfirmation;
  end;
end;

function TypeMessageToInteger(ID: TTypeMessage):Integer ;
begin
  Case ID of
    tmSimple        : result := 0;
    tmConfirmation  : result := 1;
  end;
end;

function MnemonicosToInteger(ID: TMnemonicos):Integer ;
begin
  Result := integer(ID);
 end;

function IntegerToMnemonicos(ID: Integer):TMnemonicos;
begin
  Result := TMnemonicos(ID);
end;



{ TRefMnemonicos }

constructor TRefMnemonicos.Create;
begin
  inherited;
  fMnemonicoName  := '';
  fMnemonico      := mn_NONE;
  FFieldName      := '';
  FTexto          := '';
  FVariaveisTexto := nil;
  FValoresTexto   := nil;
end;

destructor TRefMnemonicos.Destroy;
begin
  inherited;
end;

procedure TRefMnemonicos.SetFieldName(const Value: string);
begin
  FFieldName := Value;
end;

procedure TRefMnemonicos.SetMnemonico(const Value: TMnemonicos);
begin
  fMnemonico := Value;
  fMnemonicoName := MNEMONICOS[MnemonicosToInteger(fMnemonico)];
end;

end.
