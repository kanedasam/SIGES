unit Model.PcnTyped;

interface

uses  System.Classes, Data.DB; //ACBrValidador,

type

TArrayofVariant = array of Variant;
TArrayofString  = array of String;
TArrayofInteger = array of integer;
TArrayFieldType = array of TFieldType;

pcn_type_pessoa     = (tpIndef, tpFisica, tpJuridica, tpProdRural) ;
pcn_type_entidade   = (teIndef, teEmpresa, teFilial, teCliente, teFornecedor,
                       teClienteFornecedor, teTransportadora, teColaborador,
                       teContabilidade, teProspeccao, tePrestador, teRepresentante,
                       teVendedor) ;
//pcn_type_doc_id     =  TACBrValTipoDocto;
{pcn_type_doc_id    =  (docCPF, docCNPJ, docUF, docInscEst, docNumCheque, docPIS,
                        docCEP, docCartaoCredito, docSuframa, docGTIN, docRenavam,
                        docEmail, docCNH, docPrefixoGTIN);}
pcn_form_style     = (fswNormal, fswMDIChild, fswMDIForm, fswStayOnTop);
pcn_form_show      = (sfShow,sfModal,sfClose);
pcn_form_env       = (feUnitario, feLote, feLoteIndividual, feNone);
pcn_sn             = (nsSim,nsNao);
pcn_type_drive     = (tdRemovivel, tdFixo, tdRede, tdCDROM, tdRAMDISK, tdNenhum);
pcn_type_user_sys  = (tuRoot,tuAdmin,tuPrev,tuCommon,tuRestrict);
pcn_type_mov       = (tmSaida,tmEntrada);
pcn_type_doc_origem    =  (doNFe, doNFSe, doECFe, doNFCe, doCTe,  doDuplicata, doDAV, doPV, doOP, doOC);
pcn_direcao            = (diDireita,diEsquerda,diCentro,diEspaco);
pcn_feriados           = (frPascoa, frCarnaval, frQuartaCinzas, frSextaSanta, frCorpusChristi);
pcn_messageicom        = (msHelp, msNote, msAtention, msStop);
pcn_typereturn         = (trBoolean, trVarRec);
pcn_window_type        = (wtAlert,wtConfirmation);
pcn_byte_format        = (bsfDefault, bsfBytes, bsfKB, bsfMB, bsfGB, bsfTB);
pcn_bancocaixa         = (bcBanco, bcCaixaEmpresa, bcCaixaPessoal);
pcn_datetimestampunix  = (tsIntToDateTime, tsDateTimeToInt);

pcn_vs_pessoa          = (vIDPESSOA,vRAZAOSOCIAL,vENDERECO,vTELEFONE, vEMAIL,vCNPJCPF,vCONTRATO);
pcn_vs_dfe             = (vIDDFE,vTIPODOC,vNUMERODOC,vCHAVEDOC, vPROTOCOLODOC,vSTATUSDOC,vDATAEMISSAODOC);
pcn_vs_boleto          = (vIDBOLETO,vNUMEROBOLETO,vTOTALPARCELAS,vNUMEROPARCELA, vVALORBOLETO,vDATAVENCIMENTOBOLETO);
pcn_vs_fatura          = (vIDFATURA,vNUMEROFATURA,vMESCOBRANCA,vDATAVENCIMENTOFATURA, vVALORFATURA);

TCST_ICMS = (
    t_cst00,
    t_cst10,
    t_cst20,
    t_cst30,
    t_cst40,
    t_cst41,
    t_cst45,
    t_cst50,
    t_cst51,
    t_cst60,
    t_cst70,
    t_cst80,
    t_cst81,
    t_cst90,
    t_cstPart10,
    t_cstPart90,
    t_cstRep41,
    t_cstVazio,
    t_cstICMSOutraUF,
    t_cstICMSSN
    );


  TCST_IPI = (
    t_ipi00,
    t_ipi49,
    t_ipi50,
    t_ipi99,
    t_ipi01,
    t_ipi02,
    t_ipi03,
    t_ipi04,
    t_ipi05,
    t_ipi51,
    t_ipi52,
    t_ipi53,
    t_ipi54,
    t_ipi55
  );

  TCST_PIS = (
    t_pis01,
    t_pis02,
    t_pis03,
    t_pis04,
    t_pis06,
    t_pis07,
    t_pis08,
    t_pis09,
    t_pis49,
    t_pis50,
    t_pis51,
    t_pis52,
    t_pis53,
    t_pis54,
    t_pis55,
    t_pis56,
    t_pis60,
    t_pis61,
    t_pis62,
    t_pis63,
    t_pis64,
    t_pis65,
    t_pis66,
    t_pis67,
    t_pis70,
    t_pis71,
    t_pis72,
    t_pis73,
    t_pis74,
    t_pis75,
    t_pis98,
    t_pis99
  );

  TCST_COFINS =(
    t_cof01,
    t_cof02,
    t_cof03,
    t_cof04,
    t_cof06,
    t_cof07,
    t_cof08,
    t_cof09,
    t_cof49,
    t_cof50,
    t_cof51,
    t_cof52,
    t_cof53,
    t_cof54,
    t_cof55,
    t_cof56,
    t_cof60,
    t_cof61,
    t_cof62,
    t_cof63,
    t_cof64,
    t_cof65,
    t_cof66,
    t_cof67,
    t_cof70,
    t_cof71,
    t_cof72,
    t_cof73,
    t_cof74,
    t_cof75,
    t_cof98,
    t_cof99
  );

  TEnquadramentoCRT = (
    t_crtSimplesNacional,
    t_crtRegimeNormalLucroPresumido,
    t_crtRegimeNormalLucroReal,
    t_crtSimplesExcessoReceita,
    t_crtNone
  );

  TCSOSN = (
    t_csosn101,
    t_csosn102,
    t_csosn103,
    t_csosn201,
    t_csosn202,
    t_csosn203,
    t_csosn300,
    t_csosn400,
    t_csosn500,
    t_csosn900
  );





  sat_calc_item_tax = record
    Cod_produto: string;
    Cod_item: integer;
    Vlr_Tot_Prd: Currency;
    Aliq_icms: Currency;
    Bc_Icms: Currency;
    Vlr_Icms: Currency;
    Bc_IcmsSN: Currency;
    Vlr_IcmsSN: Currency;
    Tip_Fiscal_ipi: string;
    Aliq_ipi: Currency;
    Vlr_Ipi: Currency;
    Vlr_IpiSN: Currency;
    Tip_Fiscal_icms: string;
    Bc_IcmsST: Currency;
    Vlr_IcmsST: Currency;
    Vlr_Venda_Prd: Currency;
    Vlr_Total_Desc: Currency;
    Vlr_Tot_Prd_bruto: Currency;
    Aliq_icmsSt: Currency;
    Aliq_mvaSt: Currency;
    Aliq_Red_BC: Currency;
    Aliq_pis: Currency;
    Aliq_cofins: Currency;
    Aliq_irrf: Currency;
    Aliq_irpj: Currency;
    Aliq_csll: Currency;
    Aliq_cpp: Currency;
    vlr_pis: Currency;
    vlr_cofins: Currency;
    vlr_irrf: Currency;
    vlr_irpj: Currency;
    vlr_csll: Currency;
    vlr_cpp: Currency;
    bc_pis: Currency;
    bc_cofins: Currency;
    bc_irrf: Currency;
    bc_irpj: Currency;
    bc_csll: Currency;
    bc_cpp: Currency;
    cod_cst_pisx: string;
    cod_cst_cofinsx: string;
    vlr_bcstpis: Currency;
    Aliq_pisst: Currency;
    vlr_pisst: Currency;
    vlr_bcstcofins: Currency;
    Aliq_cofinsst: Currency;
    vlr_cofinsst: Currency;
    vlr_ibtp_fed: Currency;
    vlr_difal: Currency;
    vlr_difal_est_org: Currency;
    vlr_difal_est_dest: Currency;
    vlr_fcp: Currency;
  end;


  rc_info_ent = record
    flg_put_record      : pcn_sn;
    flg_tp_ent          : pcn_type_pessoa;
    ent_cnpjcpf         : string[20];
    ent_tp_empresa      : string[50];
    ent_data_abertnasc  : string[10];
    ent_nome_razsoc : string[250];
    ent_nome_fant   : string[250];
    ent_end_log     : string[250];
    ent_end_num     : string[10];
    ent_end_compl   : string[150];
    ent_end_bairro  : string[50];
    ent_end_cid     : string[70];
    ent_end_cep     : string[15];
    ent_end_tel     : string[20];
    ent_mail        : string[100];
    ent_Resp        : string[100];
    ent_ie          : string[50];
    ent_efr         : string[250];
    ent_ibge_codcid : string[10];
    ent_ibge_uf     : string[2];
    ent_sit         : string[50];
    ent_sit_mot     : string[250];
    ent_cane_pri    : string[250];
    ent_cane_sec    : TStringList;
  end;

  rc_nfs = record
    num_idx: integer;
    num_rps: integer;
    arq_xml: string[250];
    num_lote: string[12];
    num_prot: string[20];
    num_serie: string[5];
  end;


  rec_imp_Prod = record
    tItem: Integer;
    nItem: Integer;
    cProd: string;
    xProd: string;
    NCM: string;
    CFOP: string;
    uCom: string;
    qCom: Currency;
    vUnCom: Currency;
    vProd: Currency;
    infAdProd: string;
    CST: string;
    ICMS_orig: string;
    ICMS_modBC: string;
    ICMS_pRedBC: Currency;
    ICMS_vBC: Currency;
    ICMS_pICMS: Currency;
    ICMS_vICMS: Currency;
    ICMS_modBCST: string;
    ICMS_pMVAST: Currency;
    ICMS_pRedBCST: Currency;
    ICMS_vBCST: Currency;
    ICMS_pICMSST: Currency;
    ICMS_vICMSST: Currency;
    ICMS_vBCSTRet: Currency;
    ICMS_vICMSSTRet: Currency;
    ICMS_pCredSN: Currency;
    ICMS_vCredICMSSN: Currency;
    ISSQN_vBC: Currency;
    ISSQN_vAliq: Currency;
    ISSQN_vISSQN: Currency;
    ISSQN_cMunFG: Integer;
    ISSQN_cListServ: string;
    cstIPI: string;
    pIPI: Currency;
    vIPI: Currency;
    COFINS_CST: string;
    COFINS_vBC: Currency;
    COFINS_pCOFINS: Currency;
    COFINS_vCOFINS: Currency;
    COFINSST_vBC: Currency;
    COFINSST_pCOFINS: Currency;
    COFINSST_vCOFINS: Currency;
    PIS_CST: string;
    PIS_vBC: Currency;
    PIS_pPIS: Currency;
    PIS_vPIS: Currency;
    PISST_vBC: Currency;
    PISST_pPIS: Currency;
    PISST_vPIS: Currency;
    xPed: string;
    nItemPedido: string;
  end;

  rec_Dup_Cob = record
    v_Tot_Record: Integer;
    v_idx: Integer;
    v_nDup: string;   // str
    v_dVenc: TDateTime;  // date
    v_vDup: Currency;   // currency
    v_vtotDup: Currency;   // currency
  end;

  rec_parcelamento = record
    Id_Convenio: Integer;
    Total_parcelas: integer;
    Numero_Parcela: integer;
    IsAvistaEntrada : Boolean;
    Data_Geracao: TDate;
    Data_Vencimento: TDate;
    Data_Multa : TDate;
    Valor_Multa: Currency;
    Valor_Juros: Currency;
    Valor_Total_Documento: Currency;
    Valor_Parcela: Currency;
  end;

  rec_licence_system = record
    FKey1: string;
    FKey2: string;
    FKey3: tdatetime;
    FKey4: tdatetime;
    FKey5: Integer;
    FKey6: Integer;
    FKey7: Integer;
    FKey8: Integer;
    FKey9: Integer;
    FKey10: Integer;
    FKey11: tdatetime;
    FKey12: Integer;
    FKey13: Integer;
    FKey14: Integer;
    FKey15: Integer;
    FKey16: string;
    FKey17: string;
    FKey18: string;
    FKey19: Integer;
    FKey20: Integer;
    FKey21: Integer;
  end;

  rc_info_end = record
    flg_put_record  : pcn_sn;
    Cep: string;
    Logradouro: string;
    Complemento: string;
    Bairro: string;
    Localidade: string;
    IBGE_Municipio: string;
    IBGE_UF: string;
    Unidade: string;
    GIA: string;
  end;

  rc_municipio = record
    Municipio: string;
    Cod_Municipio: Integer;
    UF: string;
  end;

  rc_search = record
    array_field_value: array of Variant;
  end;

  rc_calc_parcela_ag = record
    num_parc : Integer;
    dt_vencimento: Tdate;
    vlr_parc: Currency;
 end;
  rc_calc_agenda = record
    total_parcela: integer;
    dt_1_parc: TDate;
    vlr_agenda: Currency;
    vlr_ult_parcla: Currency;
    vlr_quitado: Currency;
    vlr_pendente: Currency;
    fatorreaj : Currency;
    list_parcelas : array of rc_calc_parcela_ag;
  end;

  rc_valid_doc = record
   is_valided: Boolean;
   Doc_Formated: string;
  end;

  rc_db_access = record
   server   : string;
   database : string;
   port     : string;
   licence  : string;
   cnpjcpf  : string;
   nomeraz  : string;
   codcont  : string;
   isconfig : string;
  end;

  rc_win_info = record
    architecture : string;
    Bits         : string;
    os           : string;
    build        : string;
    major        : string;
    minor        : string;
    winname      : string;
    sp_major     : string;
    sp_minor     : string;
    descfull     : string;
  end;

  rc_acceppt_pf = record
    IsValidate    : Boolean;
    IsCredICMS    : Boolean;
    IsCredIPI     : Boolean;
    IsCredPIS     : Boolean;
    IsCredCOFINS  : Boolean;
    Mensage : string;
  end;

  rc_connection_info = record
    IsConnected    : Boolean;
    status_message : string;
  end;

  rc_dfe_formulario = record
    ID          : Integer;
    Modelo      : string;
    Serie       : string;
    NumeroAtual : Integer;
  end;

 tp_result_sat_calc_item_imp = array [0 .. 998] of sat_calc_item_tax;
 tp_result_rec_pagamentos = array of rec_parcelamento;

const
    pcn_num_ddd        : array[0..66] of integer = (11,12,13,14,15,16,17,18,19,21,
                                                    22,24,27,28,31,32,33,34,35,37,
                                                    38,41,42,43,44,45,46,47,48,49,
                                                    51,53,54,55,61,62,63,64,65,66,
                                                    67,68,69,71,73,74,75,77,79,81,
                                                    82,83,84,85,86,87,88,89,91,92,
                                                    93,94,95,96,97,98,99);





implementation




end.
