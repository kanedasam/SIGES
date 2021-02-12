unit Model.EnumTypedConvertion;

interface

uses System.SysUtils, System.Variants, Model.PcnTyped, ACBrBoleto, ACBrValidador;

type
  TEnumTypedConvertion = class(TObject)
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    function IntegerToTipado(out ok: boolean; const s: Integer; const AIntegering: array of Integer; const ATipados: array of variant): variant;
    function TipadoToInteger(const t: variant; const AIntegering: array of Integer; const ATipados: array of variant): variant;
    function TipadoToString(const t: variant; const AStringing: array of string; const ATipados: array of variant): variant;
    function IntegerToTipoPessoa(s: Integer): pcn_type_pessoa;
    function TipoPessoaToInteger(const t: pcn_type_pessoa): Integer;
    function IntegerToEstiloFormulario(s: Integer): pcn_form_style;
    function EstiloFormularioToInteger(const t: pcn_form_style): Integer;
    function IntegerToEstadoFormulario(s: Integer): pcn_form_show;
    function EstadoFormularioToInteger(const t: pcn_form_show): Integer;
    function IntegerToFormaEnvio(s: Integer): pcn_form_env;
    function FormaEnvioToInteger(const t: pcn_form_env): Integer;
    function IntegerToSimNao(s: Integer): pcn_sn;
    function SimNaoToInteger(const t: pcn_sn): Integer;
    function IntegerToTipoDrive(s: Integer): pcn_type_drive;
    function TipoDriveToInteger(const t: pcn_type_drive): Integer;
    function IntegerToTipoUsuario(s: Integer): pcn_type_user_sys;
    function TipoUsuarioToInteger(const t: pcn_type_user_sys): Integer;
    function IntegerToTipoMovimento(s: Integer): pcn_type_mov;
    function TipoMovimentoToInteger(const t: pcn_type_mov): Integer;
    function IntegerToEnquadramentoFiscal(s: Integer): TEnquadramentoCRT;
    function EnquadramentoFiscalToInteger(const t: TEnquadramentoCRT): Integer;
    function IntegerToDocumentoFiscalOrigem(s: Integer): pcn_type_doc_origem;
    function DocumentoFiscalOrigemToInteger(const t: pcn_type_doc_origem): Integer;
    function IntegerToDirecao(s: Integer): pcn_direcao;
    function DirecaoToInteger(const t: pcn_direcao): Integer;
    function VarianteToStr(AVarRec: TVarRec): string;
    function CodOcorrenciaToTipo(s: Integer): TACBrTipoOcorrencia;
    function TipoToCodOcorrencia(const t: TACBrTipoOcorrencia): Integer;
    function IntegerToTipoDocumento(s: Integer): TACBrValTipoDocto;
    function TipoDocumentoToInteger(const t: TACBrValTipoDocto): Integer;
    function IntegerToPcnIconImage(s: Integer): pcn_messageicom ;
    function PcnIconImageToInteger(const t: pcn_messageicom ): Integer;

    function IntegerToTipoEntidade(s: Integer): pcn_type_entidade ;
    function TipoEntidadeToInteger(const t: pcn_type_entidade ): Integer;

    function IntegerToTipoBancoCaixa(s: Integer): pcn_bancocaixa ;
    function TipoBancoCaixaToInteger(const t: pcn_bancocaixa ): Integer;

    function IntegerToCST(s: Integer): TCST_ICMS ;
    function CSTToInteger(const t: TCST_ICMS ): Integer;

    function IntegerToCSOSN(s: Integer): TCSOSN ;
    function CSOSNToInteger(const t: TCSOSN ): Integer;

    function IntegerToIPI(s: Integer): TCST_IPI ;
    function IPIToInteger(const t: TCST_IPI ): Integer;

    function IntegerToPIS(s: Integer): TCST_PIS ;
    function PISToInteger(const t: TCST_PIS ): Integer;

    function IntegerToCOFINS(s: Integer): TCST_COFINS ;
    function COFINSToInteger(const t: TCST_COFINS ): Integer;

    function CSTToString(const t: TCST_ICMS): String;
    function CSOSNToString(const t: TCSOSN): String;
    function IPIToString(const t: TCST_IPI): String;
    function PISToString(const t: TCST_PIS): String;
    function COFINSToString(const t: TCST_COFINS): String;


    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TEnumTypedConvertion }

constructor TEnumTypedConvertion.Create;
begin

end;

destructor TEnumTypedConvertion.Destroy;
begin

  inherited;
end;

function TEnumTypedConvertion.CodOcorrenciaToTipo(
  s: Integer): TACBrTipoOcorrencia;
var
  ok: Boolean;
begin
  ok := True;
  result := IntegerToTipado(ok, s, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
                                    11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
                                    21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
                                    31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
                                    41
                                   ],
                                   [toRemessaRegistrar,
                                    toRemessaBaixar,
                                    toRemessaDebitarEmConta,
                                    toRemessaConcederAbatimento,
                                    toRemessaCancelarAbatimento,
                                    toRemessaConcederDesconto,
                                    toRemessaCancelarDesconto,
                                    toRemessaAlterarVencimento,
                                    toRemessaAlterarVencimentoSustarProtesto,
                                    toRemessaProtestar,
                                    toRemessaSustarProtesto,
                                    toRemessaCancelarInstrucaoProtestoBaixa,
                                    toRemessaCancelarInstrucaoProtesto,
                                    toRemessaDispensarJuros,
                                    toRemessaAlterarNomeEnderecoSacado,
                                    toRemessaAlterarNumeroControle,
                                    toRemessaOutrasOcorrencias,
                                    toRemessaAlterarControleParticipante,
                                    toRemessaAlterarSeuNumero,
                                    toRemessaTransfCessaoCreditoIDProd10,
                                    toRemessaTransferenciaCarteira,
                                    toRemessaDevTransferenciaCarteira,
                                    toRemessaDesagendarDebitoAutomatico,
                                    toRemessaAcertarRateioCredito,
                                    toRemessaCancelarRateioCredito,
                                    toRemessaAlterarUsoEmpresa,
                                    toRemessaNaoProtestar,
                                    toRemessaProtestoFinsFalimentares,
                                    toRemessaBaixaporPagtoDiretoCedente,
                                    toRemessaCancelarInstrucao,
                                    toRemessaAlterarVencSustarProtesto,
                                    toRemessaCedenteDiscordaSacado,
                                    toRemessaCedenteSolicitaDispensaJuros,
                                    toRemessaOutrasAlteracoes,
                                    toRemessaAlterarModalidade,
                                    toRemessaAlterarExclusivoCliente,
                                    toRemessaNaoCobrarJurosMora,
                                    toRemessaCobrarJurosMora,
                                    toRemessaAlterarValorTitulo,
                                    toRemessaExcluirSacadorAvalista,
                                    toRemessaAlterarNumeroDiasProtesto,
                                    toRemessaAlterarPrazoProtesto,
                                    toRemessaAlterarPrazoDevolucao,
                                    toRemessaAlterarOutrosDados,
                                    toRemessaAlterarDadosEmissaoBloqueto,
                                    toRemessaAlterarProtestoDevolucao,
                                    toRemessaAlterarDevolucaoProtesto,
                                    toRemessaNegativacaoSerasa,
                                    toRemessaExcluirNegativacaoSerasa
                                   ]);
end;

function TEnumTypedConvertion.DirecaoToInteger(
  const t: pcn_direcao): Integer;
begin
  result := TipadoToInteger(t, [0, 1, 2, 3], [diDireita, diEsquerda, diCentro, diEspaco]);
end;

function TEnumTypedConvertion.DocumentoFiscalOrigemToInteger(
  const t: pcn_type_doc_origem): Integer;
begin
  result := TipadoToInteger(t, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], [doNFe, doNFSe, doECFe, doNFCe, doCTe, doDuplicata, doDAV, doPV, doOP, doOC]);
end;

function TEnumTypedConvertion.EnquadramentoFiscalToInteger(
  const t: TEnquadramentoCRT): Integer;
begin
  result := TipadoToInteger(t, [0, 1, 2, 3,0], [t_crtSimplesNacional,t_crtRegimeNormalLucroPresumido,t_crtRegimeNormalLucroReal,t_crtSimplesExcessoReceita,t_crtNone]);
end;

function TEnumTypedConvertion.EstadoFormularioToInteger(
  const t: pcn_form_show): Integer;
begin
  result := TipadoToInteger(t, [0, 1, 2], [sfShow, sfModal, sfClose]);
end;

function TEnumTypedConvertion.EstiloFormularioToInteger(
  const t: pcn_form_style): Integer;
begin
  result := TipadoToInteger(t, [0, 1, 2, 3], [fswNormal, fswMDIChild, fswMDIForm, fswStayOnTop]);
end;

function TEnumTypedConvertion.FormaEnvioToInteger(
  const t: pcn_form_env): Integer;
begin
  result := TipadoToInteger(t, [0, 1], [feUnitario, feLote]);
end;


function TEnumTypedConvertion.IntegerToDirecao(s: Integer): pcn_direcao;
var
  ok: Boolean;
begin
  ok := True;
  result := IntegerToTipado(ok, s, [0, 1, 2, 3], [diDireita, diEsquerda, diCentro, diEspaco]);
end;

function TEnumTypedConvertion.IntegerToDocumentoFiscalOrigem(
  s: Integer): pcn_type_doc_origem;
var
  ok: Boolean;
begin
  ok := True;
  result := IntegerToTipado(ok, s, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], [doNFe, doNFSe, doECFe, doNFCe, doCTe, doDuplicata, doDAV, doPV, doOP, doOC]);
end;

function TEnumTypedConvertion.IntegerToEnquadramentoFiscal(
  s: Integer): TEnquadramentoCRT;
var
  ok: Boolean;
begin
  ok := True;
  result := IntegerToTipado(ok, s, [0, 1, 2, 3,4], [t_crtSimplesNacional,t_crtRegimeNormalLucroPresumido,t_crtRegimeNormalLucroReal,t_crtSimplesExcessoReceita,t_crtNone]);
end;

function TEnumTypedConvertion.IntegerToEstadoFormulario(
  s: Integer): pcn_form_show;
var
  ok: Boolean;
begin
  ok := True;
  result := IntegerToTipado(ok, s, [0, 1, 2], [sfShow, sfModal, sfClose]);
end;

function TEnumTypedConvertion.IntegerToEstiloFormulario(
  s: Integer): pcn_form_style;
var
  ok: Boolean;
begin
  ok := True;
  result := IntegerToTipado(ok, s, [0, 1, 2, 3], [fswNormal, fswMDIChild, fswMDIForm, fswStayOnTop]);
end;

function TEnumTypedConvertion.IntegerToFormaEnvio(
  s: Integer): pcn_form_env;
var
  ok: Boolean;
begin
  ok := True;
  result := IntegerToTipado(ok, s, [0, 1], [feUnitario, feLote]);
end;



function TEnumTypedConvertion.IntegerToPcnIconImage(
  s: Integer): pcn_messageicom;
var
  ok: Boolean;
begin
  ok := True;
  result := IntegerToTipado(ok, s, [0, 1, 2, 3], [msHelp, msNote, msAtention, msStop]);
end;

function TEnumTypedConvertion.IntegerToSimNao(s: Integer): pcn_sn;
var
  ok: Boolean;
begin
  ok := True;
  result := IntegerToTipado(ok, s, [0, 1], [nsSim, nsNao]);
end;

function TEnumTypedConvertion.IntegerToTipado(out ok: boolean;
  const s: Integer; const AIntegering: array of Integer;
  const ATipados: array of variant): variant;
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

function TEnumTypedConvertion.IntegerToTipoBancoCaixa(
  s: Integer): pcn_bancocaixa;
var
  ok: Boolean;
begin
  result := IntegerToTipado(ok, s, [1, 2, 3],
                                   [bcBanco, bcCaixaEmpresa, bcCaixaPessoal]
                           );
end;

function TEnumTypedConvertion.IntegerToTipoDocumento(
  s: Integer): TACBrValTipoDocto;
var
  ok: Boolean;
begin
  ok := True;
  result := IntegerToTipado(ok, s, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
                                   [docCPF, docCNPJ, docUF, docInscEst, docNumCheque, docPIS,
                                    docCEP, docCartaoCredito, docSuframa, docGTIN, docRenavam,
                                    docEmail, docCNH]
                           );
end;

function TEnumTypedConvertion.IntegerToTipoDrive(
  s: Integer): pcn_type_drive;
var
  ok: Boolean;
begin
  ok := True;
  result := IntegerToTipado(ok, s, [0, 1, 2, 3, 4, 5], [tdRemovivel, tdFixo, tdRede, tdCDROM, tdRAMDISK, tdNenhum]);
end;

function TEnumTypedConvertion.IntegerToTipoEntidade(
  s: Integer): pcn_type_entidade;
var
  ok: Boolean;
begin
  ok := True;
  result := IntegerToTipado(ok, s, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
                                   [teIndef,
                                    teEmpresa,
                                    teFilial,
                                    teCliente,
                                    teFornecedor,
                                    teClienteFornecedor,
                                    teTransportadora,
                                    teColaborador,
                                    teContabilidade,
                                    teProspeccao,
                                    tePrestador,
                                    teRepresentante,
                                    teVendedor]);
end;

function TEnumTypedConvertion.IntegerToTipoPessoa(
  s: Integer): pcn_type_pessoa;
var
  ok: Boolean;
begin
  ok := True;
  result := IntegerToTipado(ok, s, [0, 1, 2, 3], [tpIndef, tpFisica, tpJuridica, tpProdRural]);
end;

function TEnumTypedConvertion.IntegerToTipoMovimento(
  s: Integer): pcn_type_mov;
var
  ok: Boolean;
begin
  ok := True;
  result := IntegerToTipado(ok, s, [0, 1], [tmSaida, tmEntrada]);
end;

function TEnumTypedConvertion.IntegerToTipoUsuario(
  s: Integer): pcn_type_user_sys;
var
  ok: Boolean;
begin
  ok := True;
  result := IntegerToTipado(ok, s, [0, 1, 2, 3, 4], [tuRoot, tuAdmin, tuPrev, tuCommon, tuRestrict]);
end;


function TEnumTypedConvertion.PcnIconImageToInteger(
  const t: pcn_messageicom): Integer;
begin
  result := TipadoToInteger(t, [0, 1, 2 , 3], [msHelp, msNote, msAtention, msStop]);
end;

function TEnumTypedConvertion.SimNaoToInteger(const t: pcn_sn): Integer;
begin
  result := TipadoToInteger(t, [0, 1], [nsSim, nsNao]);
end;

function TEnumTypedConvertion.TipadoToInteger(const t: variant;const AIntegering: array of Integer;const ATipados: array of variant): variant;
var
  i: integer;
begin
  result := '';
  for i := Low(ATipados) to High(ATipados) do
    if t = ATipados[i] then
      result := AIntegering[i];
end;

function TEnumTypedConvertion.TipadoToString(const t: variant; const AStringing: array of string; const ATipados: array of variant): variant;
var
  i: integer;
begin
  result := '';
  for i := Low(ATipados) to High(ATipados) do
    if t = ATipados[i] then
      result := AStringing[i];
end;

function TEnumTypedConvertion.TipoBancoCaixaToInteger(
  const t: pcn_bancocaixa): Integer;
begin
  result := TipadoToInteger(t, [1, 2, 3],
                               [bcBanco, bcCaixaEmpresa, bcCaixaPessoal]
                           );
end;

function TEnumTypedConvertion.TipoDocumentoToInteger(
  const t: TACBrValTipoDocto): Integer;
begin
  result := TipadoToInteger(t, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
                               [docCPF, docCNPJ, docUF, docInscEst, docNumCheque, docPIS,
                                docCEP, docCartaoCredito, docSuframa, docGTIN, docRenavam,
                                docEmail, docCNH]
                           );
end;

function TEnumTypedConvertion.TipoDriveToInteger(
  const t: pcn_type_drive): Integer;
begin
  result := TipadoToInteger(t, [0, 1, 2, 3, 4, 5], [tdRemovivel, tdFixo, tdRede, tdCDROM, tdRAMDISK, tdNenhum]);
end;

function TEnumTypedConvertion.TipoEntidadeToInteger(
  const t: pcn_type_entidade): Integer;
begin
  result := TipadoToInteger(t, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
                               [teIndef,
                                teEmpresa,
                                teFilial,
                                teCliente,
                                teFornecedor,
                                teClienteFornecedor,
                                teTransportadora,
                                teColaborador,
                                teContabilidade,
                                teProspeccao,
                                tePrestador,
                                teRepresentante,
                                teVendedor]);
end;

function TEnumTypedConvertion.TipoPessoaToInteger(
  const t: pcn_type_pessoa): Integer;
begin
  result := TipadoToInteger(t, [0, 1, 2, 3], [tpIndef, tpFisica, tpJuridica, tpProdRural]);
end;

function TEnumTypedConvertion.TipoMovimentoToInteger(
  const t: pcn_type_mov): Integer;
begin
  result := TipadoToInteger(t, [0, 1], [tmSaida, tmEntrada]);
end;

function TEnumTypedConvertion.TipoToCodOcorrencia(
  const t: TACBrTipoOcorrencia): Integer;
begin
  result := TipadoToInteger(t, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
                                11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
                                21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
                                31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
                                41
                               ],
                               [toRemessaRegistrar,
                                toRemessaBaixar,
                                toRemessaDebitarEmConta,
                                toRemessaConcederAbatimento,
                                toRemessaCancelarAbatimento,
                                toRemessaConcederDesconto,
                                toRemessaCancelarDesconto,
                                toRemessaAlterarVencimento,
                                toRemessaAlterarVencimentoSustarProtesto,
                                toRemessaProtestar,
                                toRemessaSustarProtesto,
                                toRemessaCancelarInstrucaoProtestoBaixa,
                                toRemessaCancelarInstrucaoProtesto,
                                toRemessaDispensarJuros,
                                toRemessaAlterarNomeEnderecoSacado,
                                toRemessaAlterarNumeroControle,
                                toRemessaOutrasOcorrencias,
                                toRemessaAlterarControleParticipante,
                                toRemessaAlterarSeuNumero,
                                toRemessaTransfCessaoCreditoIDProd10,
                                toRemessaTransferenciaCarteira,
                                toRemessaDevTransferenciaCarteira,
                                toRemessaDesagendarDebitoAutomatico,
                                toRemessaAcertarRateioCredito,
                                toRemessaCancelarRateioCredito,
                                toRemessaAlterarUsoEmpresa,
                                toRemessaNaoProtestar,
                                toRemessaProtestoFinsFalimentares,
                                toRemessaBaixaporPagtoDiretoCedente,
                                toRemessaCancelarInstrucao,
                                toRemessaAlterarVencSustarProtesto,
                                toRemessaCedenteDiscordaSacado,
                                toRemessaCedenteSolicitaDispensaJuros,
                                toRemessaOutrasAlteracoes,
                                toRemessaAlterarModalidade,
                                toRemessaAlterarExclusivoCliente,
                                toRemessaNaoCobrarJurosMora,
                                toRemessaCobrarJurosMora,
                                toRemessaAlterarValorTitulo,
                                toRemessaExcluirSacadorAvalista,
                                toRemessaAlterarNumeroDiasProtesto,
                                toRemessaAlterarPrazoProtesto,
                                toRemessaAlterarPrazoDevolucao,
                                toRemessaAlterarOutrosDados,
                                toRemessaAlterarDadosEmissaoBloqueto,
                                toRemessaAlterarProtestoDevolucao,
                                toRemessaAlterarDevolucaoProtesto,
                                toRemessaNegativacaoSerasa,
                                toRemessaExcluirNegativacaoSerasa
                               ]
                          );
end;

function TEnumTypedConvertion.TipoUsuarioToInteger(
  const t: pcn_type_user_sys): Integer;
begin
  result := TipadoToInteger(t, [0, 1, 2, 3, 4], [tuRoot, tuAdmin, tuPrev, tuCommon, tuRestrict]);
end;

function TEnumTypedConvertion.VarianteToStr(AVarRec: TVarRec): string;
const
  Bool: array[Boolean] of string = ('False', 'True');
var
  basicType: Integer;
begin
  case AVarRec.VType of
    vtInteger:    Result := IntToStr(AVarRec.VInteger);
    vtBoolean:    Result := Bool[AVarRec.VBoolean];
    vtChar:       Result := QuotedStr(AVarRec.VChar);
    vtExtended:   Result := FloatToStr(AVarRec.VExtended^);
    vtString:     Result := QuotedStr(AVarRec.VString^);
    vtPChar:      Result := QuotedStr(AVarRec.VPChar);
    vtObject:     Result := AVarRec.VObject.ClassName;
    vtClass:      Result := AVarRec.VClass.ClassName;
    vtWideChar:   Result := QuotedStr(string(AVarRec.VWideChar));
    vtAnsiString: Result := QuotedStr(string(AVarRec.VAnsiString));
    vtCurrency:   Result := CurrToStr(AVarRec.VCurrency^);
    vtVariant:
                  begin
                    basicType := VarType(AVarRec.VType) and VarTypeMask;

                    case basicType of
                      varEmpty:     Result := QuotedStr(string(AVarRec.VVariant^));
                      varNull:      Result := QuotedStr('');
                      varSmallInt:  Result := IntToStr(Integer(AVarRec.VVariant^));
                      varInteger:   Result := IntToStr(Integer(AVarRec.VVariant^));
                      varSingle:    Result := IntToStr(Integer(AVarRec.VVariant^));
                      varDouble:    Result := FloatToStr(Double(AVarRec.VVariant^));
                      varCurrency:  Result := CurrToStr(Currency(AVarRec.VVariant^));
                      varDate:      Result := DateToStr(TDateTime(AVarRec.VVariant^));
                      varOleStr:    Result := QuotedStr(string(AVarRec.VVariant^));
                      varBoolean:   Result := Bool[Boolean(AVarRec.VVariant^)];
                      varVariant:   Result := QuotedStr(string(AVarRec.VVariant^));
                      varUnknown:   Result := QuotedStr(string(AVarRec.VVariant^));
                      varByte:      Result := IntToStr(Integer(AVarRec.VVariant^));
                      varWord:      Result := QuotedStr(string(AVarRec.VVariant^));
                      varLongWord:  Result := QuotedStr(string(AVarRec.VVariant^));
                      varInt64:     Result := IntToStr(Integer(AVarRec.VVariant^));
                      varStrArg:    Result := QuotedStr(string(AVarRec.VVariant^));
                      varString:    Result := QuotedStr(string(AVarRec.VVariant^));
                      varUString:   Result := QuotedStr(string(AVarRec.VVariant^));
                    end;
                  end;
    vtPWideChar:      Result := QuotedStr(string(AVarRec.VPWideChar));
    vtUnicodeString:  Result := QuotedStr(string(AVarRec.VUnicodeString));
    vtWideString:     Result := QuotedStr(string(AVarRec.VWideString));
  else
    Result := QuotedStr(string(AVarRec.VPChar));
  end;
end;

function TEnumTypedConvertion.CSTToInteger(const t: TCST_ICMS): Integer;
begin
  result := TipadoToInteger(t, [0,10,20,30,40,41,45,50,51,60,70,80,81,90],
                               [t_cst00,t_cst10,t_cst20,t_cst30,t_cst40,t_cst41,t_cst45,t_cst50,t_cst51,t_cst60,t_cst70,t_cst80,t_cst81,t_cst90]);
end;

function TEnumTypedConvertion.IntegerToCST(s: Integer): TCST_ICMS;
var
  ok: Boolean;
begin
  ok := True;
  result := IntegerToTipado(ok, s, [0,10,20,30,40,41,45,50,51,60,70,80,81,90],
                                   [t_cst00,t_cst10,t_cst20,t_cst30,t_cst40,t_cst41,t_cst45,t_cst50,t_cst51,t_cst60,t_cst70,t_cst80,t_cst81,t_cst90]);
end;

function TEnumTypedConvertion.CSOSNToInteger(const t: TCSOSN): Integer;
begin
  result := TipadoToInteger(t, [101,102,103,201,202,203,300,400,500,900],
                               [t_csosn101,t_csosn102,t_csosn103,t_csosn201,t_csosn202,t_csosn203,t_csosn300,t_csosn400,t_csosn500,t_csosn900]);
end;

function TEnumTypedConvertion.IntegerToCSOSN(s: Integer): TCSOSN;
var
  ok: Boolean;
begin
  ok := True;
  result := IntegerToTipado(ok, s, [101,102,103,201,202,203,300,400,500,900],
                                   [t_csosn101,t_csosn102,t_csosn103,t_csosn201,t_csosn202,t_csosn203,t_csosn300,t_csosn400,t_csosn500,t_csosn900]);
end;

function TEnumTypedConvertion.IPIToInteger(const t: TCST_IPI): Integer;
begin
result := TipadoToInteger(t, [0,49,50,99,01,02,03,04,05,51,52,53,54,55],
                             [t_ipi00,t_ipi49,t_ipi50,t_ipi99,t_ipi01,t_ipi02,t_ipi03,t_ipi04,t_ipi05,t_ipi51,t_ipi52,t_ipi53,t_ipi54,t_ipi55]);
end;

function TEnumTypedConvertion.IntegerToIPI(s: Integer): TCST_IPI;
var
  ok: Boolean;
begin
  ok := True;
  result := IntegerToTipado(ok, s, [0,49,50,99,01,02,03,04,05,51,52,53,54,55],
                                   [t_ipi00,t_ipi49,t_ipi50,t_ipi99,t_ipi01,t_ipi02,t_ipi03,t_ipi04,t_ipi05,t_ipi51,t_ipi52,t_ipi53,t_ipi54,t_ipi55]);
end;

function TEnumTypedConvertion.PISToInteger(const t: TCST_PIS): Integer;
begin
result := TipadoToInteger(t, [1,2,3,4,6,7,8,9,49,50,51,52,
                              53,54,55,56,60,61,62,63,64,65,66,67,
                              70,71,72,73,74,75,98,99],
                             [t_pis01,t_pis02,t_pis03,t_pis04,t_pis06,t_pis07,t_pis08,t_pis09,t_pis49,t_pis50,t_pis51,t_pis52,
                              t_pis53,t_pis54,t_pis55,t_pis56,t_pis60,t_pis61,t_pis62,t_pis63,t_pis64,t_pis65,t_pis66,t_pis67,
                              t_pis70,t_pis71,t_pis72,t_pis73,t_pis74,t_pis75,t_pis98,t_pis99]);

end;

function TEnumTypedConvertion.IntegerToPIS(s: Integer): TCST_PIS;
var
  ok: Boolean;
begin
  ok := True;
  result := IntegerToTipado(ok, s, [1,2,3,4,6,7,8,9,49,50,51,52,
                                    53,54,55,56,60,61,62,63,64,65,66,67,
                                    70,71,72,73,74,75,98,99],
                                   [t_pis01,t_pis02,t_pis03,t_pis04,t_pis06,t_pis07,t_pis08,t_pis09,t_pis49,t_pis50,t_pis51,t_pis52,
                                    t_pis53,t_pis54,t_pis55,t_pis56,t_pis60,t_pis61,t_pis62,t_pis63,t_pis64,t_pis65,t_pis66,t_pis67,
                                    t_pis70,t_pis71,t_pis72,t_pis73,t_pis74,t_pis75,t_pis98,t_pis99]);
end;

function TEnumTypedConvertion.COFINSToInteger(const t: TCST_COFINS): Integer;
begin
result := TipadoToInteger(t, [1,2,3,4,6,7,8,9,49,50,51,52,
                              53,54,55,56,60,61,62,63,64,65,66,67,
                              70,71,72,73,74,75,98,99],
                             [t_cof01,t_cof02,t_cof03,t_cof04,t_cof06,t_cof07,t_cof08,t_cof09,t_cof49,t_cof50,t_cof51,t_cof52,
                              t_cof53,t_cof54,t_cof55,t_cof56,t_cof60,t_cof61,t_cof62,t_cof63,t_cof64,t_cof65,t_cof66,t_cof67,
                              t_cof70,t_cof71,t_cof72,t_cof73,t_cof74,t_cof75,t_cof98,t_cof99]);

end;

function TEnumTypedConvertion.IntegerToCOFINS(s: Integer): TCST_COFINS;
var
  ok: Boolean;
begin
  ok := True;
  result := IntegerToTipado(ok, s, [1,2,3,4,6,7,8,9,49,50,51,52,
                                    53,54,55,56,60,61,62,63,64,65,66,67,
                                    70,71,72,73,74,75,98,99],
                                   [t_cof01,t_cof02,t_cof03,t_cof04,t_cof06,t_cof07,t_cof08,t_cof09,t_cof49,t_cof50,t_cof51,t_cof52,
                                    t_cof53,t_cof54,t_cof55,t_cof56,t_cof60,t_cof61,t_cof62,t_cof63,t_cof64,t_cof65,t_cof66,t_cof67,
                                    t_cof70,t_cof71,t_cof72,t_cof73,t_cof74,t_cof75,t_cof98,t_cof99]);
end;

function TEnumTypedConvertion.CSTToString(const t: TCST_ICMS): String;
begin
  result := TipadoToString(t, ['00','10','20','30','40','41','45','50','51','60','70','80','81','90'],
                              [t_cst00,t_cst10,t_cst20,t_cst30,t_cst40,t_cst41,t_cst45,t_cst50,t_cst51,t_cst60,t_cst70,t_cst80,t_cst81,t_cst90]);
end;

function TEnumTypedConvertion.CSOSNToString(const t: TCSOSN): String;
begin
  result := TipadoToString(t, ['101','102','103','201','202','203','300','400','500','900'],
                              [t_csosn101,t_csosn102,t_csosn103,t_csosn201,t_csosn202,t_csosn203,t_csosn300,t_csosn400,t_csosn500,t_csosn900]);
end;

function TEnumTypedConvertion.IPIToString(const t: TCST_IPI): String;
begin
result := TipadoToString(t, ['00','49','50','99','01','02','03','04','05','51','52','53','54','55'],
                            [t_ipi00,t_ipi49,t_ipi50,t_ipi99,t_ipi01,t_ipi02,t_ipi03,t_ipi04,t_ipi05,t_ipi51,t_ipi52,t_ipi53,t_ipi54,t_ipi55]);
end;

function TEnumTypedConvertion.PISToString(const t: TCST_PIS): String;
begin
result := TipadoToString(t, ['01','02','03','04','06','07','08','09','49','50','51','52',
                              '53','54','55','56','60','61','62','63','64','65','66','67',
                              '70','71','72','73','74','75','98','99'],
                             [t_pis01,t_pis02,t_pis03,t_pis04,t_pis06,t_pis07,t_pis08,t_pis09,t_pis49,t_pis50,t_pis51,t_pis52,
                              t_pis53,t_pis54,t_pis55,t_pis56,t_pis60,t_pis61,t_pis62,t_pis63,t_pis64,t_pis65,t_pis66,t_pis67,
                              t_pis70,t_pis71,t_pis72,t_pis73,t_pis74,t_pis75,t_pis98,t_pis99]);

end;

function TEnumTypedConvertion.COFINSToString(const t: TCST_COFINS): String;
begin
result := TipadoToString(t, ['01','02','03','04','06','07','08','09','49','50','51','52',
                              '53','54','55','56','60','61','62','63','64','65','66','67',
                              '70','71','72','73','74','75','98','99'],
                             [t_cof01,t_cof02,t_cof03,t_cof04,t_cof06,t_cof07,t_cof08,t_cof09,t_cof49,t_cof50,t_cof51,t_cof52,
                              t_cof53,t_cof54,t_cof55,t_cof56,t_cof60,t_cof61,t_cof62,t_cof63,t_cof64,t_cof65,t_cof66,t_cof67,
                              t_cof70,t_cof71,t_cof72,t_cof73,t_cof74,t_cof75,t_cof98,t_cof99]);

end;
end.
