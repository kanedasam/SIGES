inherited FrmCadEntidade: TFrmCadEntidade
  Caption = 'GEST'#195'O DE PESSOAS'
  ClientHeight = 600
  ClientWidth = 919
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnResize = FormResize
  ExplicitWidth = 925
  ExplicitHeight = 629
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 256
    Top = 72
    Width = 5
    Height = 13
    Caption = '*'
  end
  object Pnl_control: TPanel
    Left = 0
    Top = 557
    Width = 919
    Height = 43
    Align = alBottom
    BevelOuter = bvNone
    Color = clSilver
    ParentBackground = False
    TabOrder = 0
    ExplicitTop = 408
    ExplicitWidth = 943
    object btn_save: TSpeedButton
      AlignWithMargins = True
      Left = 700
      Top = 3
      Width = 105
      Height = 37
      Cursor = crHandPoint
      Align = alRight
      Caption = 'SALVAR'
      OnClick = btn_saveClick
      ExplicitLeft = 509
      ExplicitTop = 2
    end
    object btn_close: TSpeedButton
      AlignWithMargins = True
      Left = 811
      Top = 3
      Width = 105
      Height = 37
      Cursor = crHandPoint
      Align = alRight
      Caption = 'FECHAR'
      OnClick = btn_closeClick
      ExplicitLeft = 512
      ExplicitTop = 6
      ExplicitHeight = 30
    end
  end
  object pgctrl_entidade: TPageControl
    Left = 0
    Top = 0
    Width = 919
    Height = 557
    ActivePage = tabs_endereco
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 800
    object tabs_entidade: TTabSheet
      Caption = 'Pessoa'
      OnShow = tabs_entidadeShow
      ExplicitWidth = 281
      ExplicitHeight = 165
      object Label1: TLabel
        Left = 16
        Top = 8
        Width = 11
        Height = 13
        Caption = 'ID'
        FocusControl = DBEdit1
      end
      object Label2: TLabel
        Left = 16
        Top = 48
        Width = 79
        Height = 13
        Caption = 'TIPO ENTIDADE'
        FocusControl = DBEdit2
      end
      object Label3: TLabel
        Left = 16
        Top = 88
        Width = 67
        Height = 13
        Caption = 'TIPO PESSOA'
        FocusControl = DBEdit3
      end
      object Label4: TLabel
        Left = 16
        Top = 128
        Width = 33
        Height = 13
        Caption = 'NOME'
        FocusControl = DBEdit4
      end
      object lbl_cpfcnpj: TLabel
        Left = 16
        Top = 168
        Width = 47
        Height = 13
        Caption = 'CPF/CNPJ'
        FocusControl = dbedt_cpfcnpj
      end
      object Label6: TLabel
        Left = 16
        Top = 208
        Width = 63
        Height = 13
        Caption = 'IDENTIDADE'
        FocusControl = edt_ident
      end
      object Label7: TLabel
        Left = 16
        Top = 248
        Width = 31
        Height = 13
        Caption = 'EMAIL'
        FocusControl = dbedt_mail
      end
      object Label8: TLabel
        Left = 16
        Top = 288
        Width = 111
        Height = 13
        Caption = 'ENDERE'#199'O PRINCIPAL'
        FocusControl = DBEdit8
      end
      object DBEdit1: TDBEdit
        Left = 16
        Top = 24
        Width = 130
        Height = 19
        CharCase = ecUpperCase
        Color = clSilver
        DataField = 'ID'
        DataSource = dsEntidadeTable
        Enabled = False
        TabOrder = 0
      end
      object DBEdit4: TDBEdit
        Left = 16
        Top = 144
        Width = 425
        Height = 19
        CharCase = ecUpperCase
        DataField = 'NOME'
        DataSource = dsEntidadeTable
        TabOrder = 3
      end
      object dbedt_cpfcnpj: TDBEdit
        Left = 16
        Top = 184
        Width = 234
        Height = 19
        CharCase = ecUpperCase
        DataField = 'CPF_CNPJ'
        DataSource = dsEntidadeTable
        TabOrder = 4
        OnEnter = dbedt_cpfcnpjEnter
        OnExit = dbedt_cpfcnpjExit
      end
      object edt_ident: TDBEdit
        Left = 16
        Top = 224
        Width = 260
        Height = 19
        CharCase = ecUpperCase
        DataField = 'IDENTIDADE'
        DataSource = dsEntidadeTable
        TabOrder = 5
      end
      object dbedt_mail: TDBEdit
        Left = 16
        Top = 264
        Width = 300
        Height = 19
        CharCase = ecUpperCase
        DataField = 'EMAIL'
        DataSource = dsEntidadeTable
        TabOrder = 6
        OnExit = dbedt_mailExit
      end
      object DBEdit2: TDBLookupComboBox
        Left = 16
        Top = 64
        Width = 130
        Height = 19
        DataField = 'COD_TIPO_ENTIDADE'
        DataSource = dsEntidadeTable
        KeyField = 'ID'
        ListField = 'DSC_ENTIDADE'
        ListSource = dsTipo_entidadeTable
        TabOrder = 1
      end
      object DBEdit3: TDBLookupComboBox
        Left = 16
        Top = 104
        Width = 130
        Height = 19
        DataField = 'COD_TIPO_PESSOA'
        DataSource = dsEntidadeTable
        KeyField = 'ID'
        ListField = 'DSC_PESSOA'
        ListSource = dsTipo_pessoaTable
        TabOrder = 2
      end
      object DBEdit8: TDBLookupComboBox
        Left = 16
        Top = 304
        Width = 500
        Height = 19
        DataField = 'COD_ENTIDADE_ENDERECO'
        DataSource = dsEntidadeTable
        KeyField = 'ID'
        ListField = 'END_FULL'
        ListSource = dsQryEndPrincipal
        TabOrder = 7
      end
    end
    object tabs_endereco: TTabSheet
      Caption = 'Endere'#231'os'
      ImageIndex = 1
      OnShow = tabs_enderecoShow
      ExplicitWidth = 281
      ExplicitHeight = 165
      object pgctrl_enderecos: TPageControl
        Left = 0
        Top = 0
        Width = 911
        Height = 529
        ActivePage = tabs_end_list
        Align = alClient
        MultiLine = True
        TabOrder = 0
        ExplicitWidth = 792
        object tabs_end_list: TTabSheet
          Caption = 'Listagem de Endere'#231'os'
          OnShow = tabs_end_listShow
          ExplicitWidth = 784
          object DBGridListEntidadeEndereco: TDBGrid
            Left = 0
            Top = 0
            Width = 903
            Height = 464
            Align = alClient
            DataSource = dsQryListEnderecos
            TabOrder = 0
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Segoe UI'
            TitleFont.Style = []
            OnDblClick = DBGridListEntidadeEnderecoDblClick
          end
          object PnlBtn_list_end: TPanel
            Left = 0
            Top = 464
            Width = 903
            Height = 37
            Align = alBottom
            BevelOuter = bvNone
            Color = clSilver
            ParentBackground = False
            TabOrder = 1
            ExplicitWidth = 784
            object btn_refresh: TSpeedButton
              AlignWithMargins = True
              Left = 795
              Top = 3
              Width = 105
              Height = 31
              Align = alRight
              Caption = 'ATUALIZAR'
              OnClick = btn_refreshClick
              ExplicitLeft = 512
              ExplicitTop = 6
              ExplicitHeight = 30
            end
            object btn_add: TSpeedButton
              AlignWithMargins = True
              Left = 462
              Top = 3
              Width = 105
              Height = 31
              Align = alRight
              Caption = 'INCLUIR'
              OnClick = btn_addClick
              ExplicitLeft = 512
              ExplicitTop = 6
              ExplicitHeight = 30
            end
            object btn_edt: TSpeedButton
              AlignWithMargins = True
              Left = 573
              Top = 3
              Width = 105
              Height = 31
              Align = alRight
              Caption = 'EDITAR'
              OnClick = btn_edtClick
              ExplicitLeft = 512
              ExplicitTop = 6
              ExplicitHeight = 30
            end
            object btn_del: TSpeedButton
              AlignWithMargins = True
              Left = 684
              Top = 3
              Width = 105
              Height = 31
              Align = alRight
              Caption = 'EXCLUIR'
              OnClick = btn_delClick
              ExplicitLeft = 512
              ExplicitTop = 6
              ExplicitHeight = 30
            end
          end
        end
        object tabs_end_edt: TTabSheet
          Caption = 'Inclus'#227'o/Edi'#231#227'o de Endere'#231'o'
          ImageIndex = 1
          OnShow = tabs_end_edtShow
          ExplicitWidth = 784
          object Label9: TLabel
            Left = 8
            Top = 8
            Width = 11
            Height = 13
            Caption = 'ID'
          end
          object Label12: TLabel
            Left = 8
            Top = 128
            Width = 19
            Height = 13
            Caption = 'CEP'
          end
          object Label20: TLabel
            Left = 8
            Top = 416
            Width = 21
            Height = 13
            Caption = 'PAIS'
          end
          object Label10: TLabel
            Left = 8
            Top = 48
            Width = 40
            Height = 13
            Caption = 'PESSOA'
            FocusControl = DBEdit6
          end
          object Label11: TLabel
            Left = 8
            Top = 88
            Width = 115
            Height = 13
            Caption = 'COD_TIPO_ENDERECO'
            FocusControl = DBEdit7
          end
          object Label13: TLabel
            Left = 8
            Top = 168
            Width = 77
            Height = 13
            Caption = 'LOGRADOURO'
            FocusControl = DBEdit10
          end
          object Label14: TLabel
            Left = 168
            Top = 208
            Width = 48
            Height = 13
            Caption = 'N'#218'MERO'
            FocusControl = dbedt_numero
          end
          object Label15: TLabel
            Left = 8
            Top = 208
            Width = 122
            Height = 13
            Caption = 'END. SEM NUMERA'#199#195'O'
            FocusControl = dbchk_semnum
          end
          object Label16: TLabel
            Left = 8
            Top = 253
            Width = 81
            Height = 13
            Caption = 'COMPLEMENTO'
            FocusControl = DBEdit13
          end
          object Label17: TLabel
            Left = 8
            Top = 296
            Width = 39
            Height = 13
            Caption = 'BAIRRO'
            FocusControl = DBEdit14
          end
          object Label18: TLabel
            Left = 8
            Top = 336
            Width = 39
            Height = 13
            Caption = 'CIDADE'
            FocusControl = DBEdit15
          end
          object Label19: TLabel
            Left = 8
            Top = 376
            Width = 41
            Height = 13
            Caption = 'ESTADO'
            FocusControl = DBEdit16
          end
          object DBEdit5: TDBEdit
            Left = 8
            Top = 24
            Width = 130
            Height = 19
            Color = clSilver
            DataField = 'ID'
            DataSource = dsEntidade_enderecoTable
            Enabled = False
            TabOrder = 0
          end
          object DBEdit6: TDBEdit
            Left = 8
            Top = 64
            Width = 553
            Height = 19
            Color = clSilver
            DataField = 'NOME'
            DataSource = dsEntidadeTable
            Enabled = False
            ReadOnly = True
            TabOrder = 1
          end
          object dbedt_cep: TDBEdit
            Left = 8
            Top = 144
            Width = 153
            Height = 19
            CharCase = ecUpperCase
            DataField = 'CEP'
            DataSource = dsEntidade_enderecoTable
            TabOrder = 3
          end
          object DBEdit10: TDBEdit
            Left = 8
            Top = 184
            Width = 500
            Height = 19
            CharCase = ecUpperCase
            DataField = 'LOGRADOURO'
            DataSource = dsEntidade_enderecoTable
            TabOrder = 4
          end
          object dbedt_numero: TDBEdit
            Left = 168
            Top = 224
            Width = 130
            Height = 19
            CharCase = ecUpperCase
            DataField = 'NUMERO'
            DataSource = dsEntidade_enderecoTable
            TabOrder = 5
          end
          object DBEdit13: TDBEdit
            Left = 8
            Top = 272
            Width = 500
            Height = 19
            CharCase = ecUpperCase
            DataField = 'COMPLEMENTO'
            DataSource = dsEntidade_enderecoTable
            TabOrder = 7
          end
          object DBEdit14: TDBEdit
            Left = 8
            Top = 312
            Width = 300
            Height = 19
            CharCase = ecUpperCase
            DataField = 'BAIRRO'
            DataSource = dsEntidade_enderecoTable
            TabOrder = 8
          end
          object DBEdit15: TDBEdit
            Left = 8
            Top = 352
            Width = 300
            Height = 19
            CharCase = ecUpperCase
            DataField = 'CIDADE'
            DataSource = dsEntidade_enderecoTable
            TabOrder = 9
          end
          object DBEdit16: TDBEdit
            Left = 8
            Top = 392
            Width = 81
            Height = 19
            CharCase = ecUpperCase
            DataField = 'ESTADO'
            DataSource = dsEntidade_enderecoTable
            TabOrder = 10
          end
          object DBEdit17: TDBEdit
            Left = 8
            Top = 432
            Width = 81
            Height = 19
            CharCase = ecUpperCase
            DataField = 'PAIS'
            DataSource = dsEntidade_enderecoTable
            TabOrder = 11
          end
          object PnlBtn_edt_end: TPanel
            Left = 0
            Top = 464
            Width = 903
            Height = 37
            Align = alBottom
            BevelOuter = bvNone
            Color = clSilver
            ParentBackground = False
            TabOrder = 12
            ExplicitTop = 466
            ExplicitWidth = 784
            object btn_edt_close: TSpeedButton
              AlignWithMargins = True
              Left = 795
              Top = 3
              Width = 105
              Height = 31
              Align = alRight
              Caption = 'FECHAR'
              OnClick = btn_edt_closeClick
              ExplicitLeft = 512
              ExplicitTop = 6
              ExplicitHeight = 30
            end
            object btn_edt_save: TSpeedButton
              AlignWithMargins = True
              Left = 684
              Top = 3
              Width = 105
              Height = 31
              Align = alRight
              Caption = 'SALVAR'
              OnClick = btn_edt_saveClick
              ExplicitLeft = 512
              ExplicitTop = 6
              ExplicitHeight = 30
            end
          end
          object DBEdit7: TDBLookupComboBox
            Left = 8
            Top = 104
            Width = 153
            Height = 19
            DataField = 'COD_TIPO_ENDERECO'
            DataSource = dsEntidade_enderecoTable
            KeyField = 'ID'
            ListField = 'DSC_ENDERECO'
            ListSource = dsTipo_enderecoTable
            TabOrder = 2
          end
          object dbchk_semnum: TDBCheckBox
            Left = 8
            Top = 224
            Width = 130
            Height = 19
            Caption = 'N'#195'O CONT'#201'M'
            DataField = 'FLG_SEM_NUMERO'
            DataSource = dsEntidade_enderecoTable
            ParentColor = False
            TabOrder = 6
            ValueChecked = '1'
            ValueUnchecked = '0'
            OnClick = dbchk_semnumClick
          end
          object btn_pesq_cep: TBitBtn
            Left = 168
            Top = 144
            Width = 97
            Height = 19
            Caption = 'PESQUISAR CEP'
            TabOrder = 13
            OnClick = btn_pesq_cepClick
          end
        end
      end
    end
  end
  object QryEntidade: TFDQuery
    Left = 400
    Top = 104
  end
  object dsEntidade: TDataSource
    DataSet = QryEntidade
    Left = 456
    Top = 104
  end
  object Connectiondef1Connection: TFDConnection
    ConnectionName = 'bd_dac'
    Params.Strings = (
      'ConnectionDef=ConnectionDef1')
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    Connected = True
    LoginPrompt = False
    Left = 747
    Top = 33
  end
  object EntidadeTable: TFDQuery
    AfterInsert = EntidadeTableAfterInsert
    BeforePost = EntidadeTableBeforePost
    Connection = Connectiondef1Connection
    SQL.Strings = (
      'SELECT * FROM ENTIDADE')
    Left = 747
    Top = 81
    object EntidadeTableID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object EntidadeTableCOD_TIPO_ENTIDADE: TIntegerField
      FieldName = 'COD_TIPO_ENTIDADE'
      Origin = 'COD_TIPO_ENTIDADE'
    end
    object EntidadeTableCOD_TIPO_PESSOA: TIntegerField
      FieldName = 'COD_TIPO_PESSOA'
      Origin = 'COD_TIPO_PESSOA'
    end
    object EntidadeTableNOME: TWideStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 200
    end
    object EntidadeTableCPF_CNPJ: TWideStringField
      FieldName = 'CPF_CNPJ'
      Origin = 'CPF_CNPJ'
      Size = 18
    end
    object EntidadeTableIDENTIDADE: TWideStringField
      FieldName = 'IDENTIDADE'
      Origin = 'IDENTIDADE'
    end
    object EntidadeTableEMAIL: TWideStringField
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 100
    end
    object EntidadeTableCOD_ENTIDADE_ENDERECO: TIntegerField
      FieldName = 'COD_ENTIDADE_ENDERECO'
      Origin = 'COD_ENTIDADE_ENDERECO'
    end
  end
  object Entidade_enderecoTable: TFDQuery
    AfterInsert = Entidade_enderecoTableAfterInsert
    IndexFieldNames = 'COD_ENTIDADE'
    SQL.Strings = (
      'SELECT * FROM ENTIDADE_ENDERECO')
    Left = 742
    Top = 136
    object Entidade_enderecoTableID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Entidade_enderecoTableCOD_ENTIDADE: TIntegerField
      FieldName = 'COD_ENTIDADE'
      Origin = 'COD_ENTIDADE'
      Required = True
    end
    object Entidade_enderecoTableCOD_TIPO_ENDERECO: TIntegerField
      FieldName = 'COD_TIPO_ENDERECO'
      Origin = 'COD_TIPO_ENDERECO'
      Required = True
    end
    object Entidade_enderecoTableCEP: TWideStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 10
    end
    object Entidade_enderecoTableLOGRADOURO: TWideStringField
      FieldName = 'LOGRADOURO'
      Origin = 'LOGRADOURO'
      Size = 150
    end
    object Entidade_enderecoTableNUMERO: TIntegerField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
    end
    object Entidade_enderecoTableFLG_SEM_NUMERO: TSmallintField
      FieldName = 'FLG_SEM_NUMERO'
      Origin = 'FLG_SEM_NUMERO'
      Required = True
    end
    object Entidade_enderecoTableCOMPLEMENTO: TWideStringField
      FieldName = 'COMPLEMENTO'
      Origin = 'COMPLEMENTO'
    end
    object Entidade_enderecoTableBAIRRO: TWideStringField
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      Size = 100
    end
    object Entidade_enderecoTableCIDADE: TWideStringField
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 100
    end
    object Entidade_enderecoTableESTADO: TWideStringField
      FieldName = 'ESTADO'
      Origin = 'ESTADO'
      Size = 40
    end
    object Entidade_enderecoTablePAIS: TWideStringField
      FieldName = 'PAIS'
      Origin = 'PAIS'
      Size = 50
    end
  end
  object Tipo_enderecoTable: TFDQuery
    SQL.Strings = (
      'SELECT * FROM TIPO_ENDERECO')
    Left = 747
    Top = 203
    object Tipo_enderecoTableID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Tipo_enderecoTableDSC_ENDERECO: TWideStringField
      FieldName = 'DSC_ENDERECO'
      Origin = 'DSC_ENDERECO'
      Size = 15
    end
  end
  object Tipo_entidadeTable: TFDQuery
    SQL.Strings = (
      'SELECT * FROM TIPO_ENTIDADE')
    Left = 745
    Top = 262
    object Tipo_entidadeTableID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Tipo_entidadeTableDSC_ENTIDADE: TWideStringField
      FieldName = 'DSC_ENTIDADE'
      Origin = 'DSC_ENTIDADE'
      Size = 18
    end
  end
  object Tipo_pessoaTable: TFDQuery
    SQL.Strings = (
      'SELECT * FROM TIPO_PESSOA')
    Left = 750
    Top = 322
    object Tipo_pessoaTableID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Tipo_pessoaTableDSC_PESSOA: TWideStringField
      FieldName = 'DSC_PESSOA'
      Origin = 'DSC_PESSOA'
      Size = 12
    end
  end
  object dsEntidadeTable: TDataSource
    DataSet = EntidadeTable
    OnDataChange = dsEntidadeTableDataChange
    Left = 832
    Top = 80
  end
  object dsEntidade_enderecoTable: TDataSource
    DataSet = Entidade_enderecoTable
    OnDataChange = dsEntidade_enderecoTableDataChange
    Left = 832
    Top = 136
  end
  object dsTipo_enderecoTable: TDataSource
    DataSet = Tipo_enderecoTable
    Left = 832
    Top = 208
  end
  object dsTipo_entidadeTable: TDataSource
    DataSet = Tipo_entidadeTable
    Left = 832
    Top = 256
  end
  object dsTipo_pessoaTable: TDataSource
    DataSet = Tipo_pessoaTable
    Left = 832
    Top = 320
  end
  object QryListEnderecos: TFDQuery
    AfterInsert = EntidadeTableAfterInsert
    BeforePost = EntidadeTableBeforePost
    IndexFieldNames = 'ENTIDADE_ID'
    MasterSource = dsEntidadeTable
    MasterFields = 'ID'
    Connection = Connectiondef1Connection
    SQL.Strings = (
      'SELECT '
      '  ENTIDADE_ENDERECO.ID,'
      '  ENTIDADE.NOME,'
      '  ENTIDADE.ID AS ENTIDADE_ID,'
      '  TIPO_ENDERECO.DSC_ENDERECO,'
      '  ENTIDADE_ENDERECO.CEP,'
      '  ENTIDADE_ENDERECO.LOGRADOURO,'
      '  ENTIDADE_ENDERECO.NUMERO,'
      '  ENTIDADE_ENDERECO.BAIRRO,'
      '  ENTIDADE_ENDERECO.CIDADE,'
      '  ENTIDADE_ENDERECO.ESTADO'
      'FROM'
      '  ENTIDADE_ENDERECO'
      
        '  INNER JOIN TIPO_ENDERECO ON (ENTIDADE_ENDERECO.COD_TIPO_ENDERE' +
        'CO = TIPO_ENDERECO.ID)'
      
        '  INNER JOIN ENTIDADE ON (ENTIDADE_ENDERECO.COD_ENTIDADE = ENTID' +
        'ADE.ID)')
    Left = 451
    Top = 177
    object QryListEnderecosID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryListEnderecosNOME: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 200
    end
    object QryListEnderecosDSC_ENDERECO: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'DSC_ENDERECO'
      Origin = 'DSC_ENDERECO'
      ProviderFlags = []
      ReadOnly = True
      Size = 15
    end
    object QryListEnderecosCEP: TWideStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 10
    end
    object QryListEnderecosLOGRADOURO: TWideStringField
      FieldName = 'LOGRADOURO'
      Origin = 'LOGRADOURO'
      Size = 150
    end
    object QryListEnderecosNUMERO: TIntegerField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
    end
    object QryListEnderecosBAIRRO: TWideStringField
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      Size = 100
    end
    object QryListEnderecosCIDADE: TWideStringField
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 100
    end
    object QryListEnderecosESTADO: TWideStringField
      FieldName = 'ESTADO'
      Origin = 'ESTADO'
      Size = 40
    end
    object QryListEnderecosENTIDADE_ID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'ENTIDADE_ID'
      Origin = 'ID'
      ProviderFlags = []
      ReadOnly = True
      Visible = False
    end
  end
  object dsQryListEnderecos: TDataSource
    DataSet = QryListEnderecos
    OnDataChange = dsEntidadeTableDataChange
    Left = 536
    Top = 176
  end
  object QryEndPrincipal: TFDQuery
    AfterInsert = EntidadeTableAfterInsert
    BeforePost = EntidadeTableBeforePost
    IndexFieldNames = 'COD_ENTIDADE'
    MasterSource = dsEntidadeTable
    MasterFields = 'ID'
    Connection = Connectiondef1Connection
    SQL.Strings = (
      'SELECT '
      '  ENTIDADE_ENDERECO.ID,'
      '  ENTIDADE_ENDERECO.COD_ENTIDADE,'
      '  CAST(ENTIDADE_ENDERECO.ID||'#39'-'#39'|| '
      '  TIPO_ENDERECO.DSC_ENDERECO||'#39' | '#39'||'
      '  ENTIDADE_ENDERECO.CEP||'#39' | '#39'||'
      '  ENTIDADE_ENDERECO.LOGRADOURO||'#39' '#39'||'
      '  --ENTIDADE_ENDERECO.NUMERO  ||'#39' '#39'||'
      '  ENTIDADE_ENDERECO.BAIRRO||'#39' '#39'||'
      '  ENTIDADE_ENDERECO.CIDADE||'#39'/'#39'||'
      '  ENTIDADE_ENDERECO.ESTADO as varchar(3000)) AS END_FULL'
      'FROM'
      '  ENTIDADE_ENDERECO'
      
        '  INNER JOIN TIPO_ENDERECO ON (ENTIDADE_ENDERECO.COD_TIPO_ENDERE' +
        'CO = TIPO_ENDERECO.ID)'
      
        '  INNER JOIN ENTIDADE ON (ENTIDADE_ENDERECO.COD_ENTIDADE = ENTID' +
        'ADE.ID)')
    Left = 451
    Top = 385
    object QryEndPrincipalID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryEndPrincipalCOD_ENTIDADE: TIntegerField
      FieldName = 'COD_ENTIDADE'
      Origin = 'COD_ENTIDADE'
      Required = True
    end
    object QryEndPrincipalEND_FULL: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'END_FULL'
      Origin = 'END_FULL'
      ProviderFlags = []
      ReadOnly = True
      Size = 3000
    end
  end
  object dsQryEndPrincipal: TDataSource
    DataSet = QryEndPrincipal
    OnDataChange = dsEntidadeTableDataChange
    Left = 536
    Top = 384
  end
end
