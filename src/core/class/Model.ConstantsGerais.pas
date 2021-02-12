unit Model.ConstantsGerais;

Interface

uses  Model.TypedGeral;

Const

    //  Tamanho de arquivos
    OneKB = 1024;
    OneMB = OneKB * OneKB;
    OneGB = OneKB * OneMB;
    OneTB = Int64(OneKB) * OneGB;

    // Criptografia
    C1=39572;
    C2=42937;
    KEY_CRYPT ='65534';

    // Buttons Name
    CAP_BTN_NEW      : string = ' &Novo';
    CAP_BTN_EDIT     : string = ' &Alterar';
    CAP_BTN_SAVE     : string = ' &Salvar ';
    CAP_BTN_DELETE   : string = ' &Excluir';
    CAP_BTN_CANCEL   : string = ' &Desistir';
    CAP_BTN_EXIT     : string = ' &Sair';
    CAP_BTN_REPORT   : string = ' &Relatório(s)';
    CAP_BTN_REPRINT  : string = ' &Imprimir';
    CAP_BTN_RESELECT : string = ' Se&lecionar';
    CAP_BTN_RECOPY   : string = ' E&spelhar';
    CAP_BTN_IMPORT   : string = ' Im&portar';
    CAP_BTN_SYNC     : string = ' S&incronizar';
    CAP_BTN_GETWEB   : string = ' R&esgatar';

    // Info Sistema
    INFO_POWERED_SYS : string = 'Powered by kaneda - (31)98114-8814 - kaneda_sam@hotmail.com - Belo Horizonte/MG ';
    COD_SIST = 33;
    LOCALREGISTER = 'SOFTWARE\TESTE\Geral';

    // ----------------- CONSTANTES DE BANCO DE DADOS / SQL ----------------- //
    COMMSQL : array[0..3] of string = ('SELECT ','INSERT ','UPDATE ','DELETE ');
    SQL_CONSQL_GETCONSULTMAG = 'scrit que busca outras consultas cadastradas no banco de dados';

    PRE_NAME_DATA_TMP = 'Tmp';
    PRE_NAME_DATA_SOURCE_TMP = 'dts';
    ACOES: array[TAcao] of string = ('Adicionar item', 'Adicionar TODOS itens',
            'Editar Item', 'Retirar item', 'Retirar TODOS itens','Atualizar Itens',
            'Salvar item', 'Cancelar item','Fechar item');

    RC_NAME_FB     : array [0..9] of string = ('dll_fbembedes','dll_add_1','dll_add_2','dll_add_3','dll_add_4','dll_add_5','dll_add_6','dll_add_7','dll_add_8','script_db');
    RC_FILENAME_FB : array [0..9] of string = ('fbembed.dll','ib_util.dll','icudt30.dll','icuin30.dll','icuuc30.dll','msvcp80.dll','msvcr80.dll','libeay32.dll','ssleay32.dll','scriptdb.sql');

    FIELDNAMEDEF : array[0..20] of TFieldDefs =
    (
      (FieldName:'ID';FieldReName:'Código';FieldWith:50),
      (FieldName:'COD_TIPO_ENTIDADE';FieldReName:'Tipo Entidade';FieldWith: 90),
      (FieldName:'COD_TIPO_PESSOA';FieldReName:'Tipo Pessoa';FieldWith: 90),
      (FieldName:'NOME';FieldReName:'Nome';FieldWith: 20),
      (FieldName:'CPF_CNPJ';FieldReName:'Cpf / Cnpj';FieldWith: 70),
      (FieldName:'IDENTIDADE';FieldReName:'Identidade';FieldWith: 70),
      (FieldName:'EMAIL';FieldReName:'E-mail';FieldWith: 150),
      (FieldName:'COD_ENTIDADE_ENDERECO';FieldReName:'Endereço Principal';FieldWith: 155),
      (FieldName:'COD_ENTIDADE';FieldReName:'Nome';FieldWith: 100),
      (FieldName:'COD_TIPO_ENDERECO';FieldReName:'Tipo de Endereço';FieldWith: 40),
      (FieldName:'CEP';FieldReName:'Cep';FieldWith: 60),
      (FieldName:'LOGRADOURO';FieldReName:'Logradouro';FieldWith: 150),
      (FieldName:'NUMERO';FieldReName:'Número';FieldWith: 50),
      (FieldName:'COMPLEMENTO';FieldReName:'Complemento';FieldWith: 60),
      (FieldName:'BAIRRO';FieldReName:'Bairro';FieldWith: 70),
      (FieldName:'CIDADE';FieldReName:'Cidade';FieldWith: 70),
      (FieldName:'ESTADO';FieldReName:'Estadado';FieldWith: 70),
      (FieldName:'PAIS';FieldReName:'País';FieldWith: 70),
      (FieldName:'DSC_ENDERECO';FieldReName:'Tipo de Endereço';FieldWith: 70),
      (FieldName:'DSC_ENTIDADE';FieldReName:'Tipo Entidade';FieldWith: 70),
      (FieldName:'DSC_PESSOA';FieldReName:'Tipo Pessoa';FieldWith: 70)
    );

     MNEMONICOS: array[0..20] of string =
      ( '_ID_',
        '_COD_TIPO_ENTIDADE_',
        '_COD_TIPO_PESSOA_',
        '_NOME_',
        '_CPF_CNPJ_',
        '_IDENTIDADE_',
        '_EMAIL_',
        '_COD_ENTIDADE_ENDERECO_',
        '_COD_ENTIDADE_',
        '_COD_TIPO_ENDERECO_',
        '_CEP_',
        '_LOGRADOURO_',
        '_NUMERO_',
        '_COMPLEMENTO_',
        '_BAIRRO_',
        '_CIDADE_',
        '_ESTADO_',
        '_PAIS_',
        '_DSC_ENDERECO_',
        '_DSC_ENTIDADE_',
        '_DSC_PESSOA_'
      );

     SQL_LIST_ENTIDADE = ' SELECT '+
                         '   E.ID, '+
                         '   TE.DSC_ENTIDADE, '+
                         '   TP.DSC_PESSOA, '+
                         '   E.NOME, '+
                         '   E.CPF_CNPJ, '+
                         '   E.IDENTIDADE, '+
                         '   E.EMAIL, '+
                         '   EE.LOGRADOURO||'' '' || '+
                         '   IIF(EE.FLG_SEM_NUMERO = 1, ''SN'', EE.NUMERO) || '' '' || '+
                         '   ''Bairro: '' || EE.BAIRRO||'' '' || EE.CIDADE||''/''|| '+
                         '   EE.ESTADO AS COD_ENTIDADE_ENDERECO '+
                         ' FROM '+
                         '   ENTIDADE E '+
                         '   INNER JOIN TIPO_ENTIDADE TE ON (E.COD_TIPO_ENTIDADE = TE.ID) '+
                         '   INNER JOIN TIPO_PESSOA TP ON (E.COD_TIPO_PESSOA = TP.ID) '+
                         '   LEFT JOIN ENTIDADE_ENDERECO EE ON (E.COD_ENTIDADE_ENDERECO = EE.ID) '+
                         '   AND (E.ID = EE.COD_ENTIDADE) '+
                         '   LEFT JOIN TIPO_ENDERECO TEND ON (EE.COD_TIPO_ENDERECO = TEND.ID) '+
                         ' WHERE 1=1 '+
                         ' ORDER BY '+
                         '   E.ID ';

       SQL_INSERT_ENDERECO = 'SELECT FIRST 0 * FROM ENTIDADE_ENDERECO';
       SQL_LIST_ENDERECO   = 'SELECT * FROM ENTIDADE_ENDERECO WHERE COD_ENTIDADE = :VCP00';

       SQL_LIST_ENDERECOS = 'SELECT '+
                             ' ENTIDADE_ENDERECO.ID, '+
                             ' ENTIDADE.NOME, '+
                             ' TIPO_ENDERECO.DSC_ENDERECO, '+
                             ' ENTIDADE_ENDERECO.CEP, '+
                             ' ENTIDADE_ENDERECO.LOGRADOURO, '+
                             ' ENTIDADE_ENDERECO.NUMERO, '+
                             ' ENTIDADE_ENDERECO.BAIRRO, '+
                             ' ENTIDADE_ENDERECO.CIDADE, '+
                             ' ENTIDADE_ENDERECO.ESTADO '+
                             'FROM '+
                             ' ENTIDADE_ENDERECO '+
                             ' INNER JOIN TIPO_ENDERECO ON (ENTIDADE_ENDERECO.COD_TIPO_ENDERECO = TIPO_ENDERECO.ID) '+
                             ' INNER JOIN ENTIDADE ON (ENTIDADE_ENDERECO.COD_ENTIDADE = ENTIDADE.ID) ';

    implementation

end.

