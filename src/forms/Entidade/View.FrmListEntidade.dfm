inherited FrmListEntidade: TFrmListEntidade
  BorderIcons = [biSystemMenu]
  ClientHeight = 556
  ClientWidth = 954
  OnCreate = FormCreate
  OnResize = FormResize
  ExplicitWidth = 960
  ExplicitHeight = 585
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridListEntidade: TDBGrid
    Left = 0
    Top = 0
    Width = 954
    Height = 496
    Align = alClient
    DataSource = dsQryListEntidade
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDblClick = DBGridListEntidadeDblClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 496
    Width = 954
    Height = 60
    Align = alBottom
    BevelOuter = bvNone
    Color = clSilver
    ParentBackground = False
    TabOrder = 1
    object btn_refresh: TSpeedButton
      AlignWithMargins = True
      Left = 871
      Top = 3
      Width = 80
      Height = 54
      Align = alRight
      Caption = 'ATUALIZAR'
      OnClick = btn_refreshClick
      ExplicitLeft = 846
    end
    object btn_add: TSpeedButton
      AlignWithMargins = True
      Left = 613
      Top = 3
      Width = 80
      Height = 54
      Align = alRight
      Caption = 'INCLUIR'
      OnClick = btn_addClick
      ExplicitLeft = 502
    end
    object btn_edt: TSpeedButton
      AlignWithMargins = True
      Left = 699
      Top = 3
      Width = 80
      Height = 54
      Align = alRight
      Caption = 'EDITAR'
      OnClick = btn_edtClick
      ExplicitLeft = 674
    end
    object btn_del: TSpeedButton
      AlignWithMargins = True
      Left = 785
      Top = 3
      Width = 80
      Height = 54
      Align = alRight
      Caption = 'EXCLUIR'
      OnClick = btn_delClick
      ExplicitLeft = 760
    end
    object btn_mail: TSpeedButton
      AlignWithMargins = True
      Left = 458
      Top = 3
      Width = 80
      Height = 54
      Cursor = crHandPoint
      Align = alLeft
      Caption = 'E-MAIL'
      OnClick = btn_mailClick
      ExplicitLeft = 588
    end
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 449
      Height = 54
      Align = alLeft
      Caption = '[ Filtrar ]'
      Color = clSilver
      Ctl3D = False
      DoubleBuffered = False
      ParentBackground = False
      ParentColor = False
      ParentCtl3D = False
      ParentDoubleBuffered = False
      TabOrder = 0
      object ListField: TComboBoxEx
        Left = 16
        Top = 21
        Width = 105
        Height = 22
        AutoCompleteOptions = []
        ItemsEx = <>
        Style = csExDropDownList
        TabOrder = 0
        OnChange = ListFieldChange
      end
      object BtnEdt_source: TButtonedEdit
        Left = 200
        Top = 21
        Width = 241
        Height = 19
        Ctl3D = False
        DoubleBuffered = False
        Images = ImageList1
        ParentCtl3D = False
        ParentDoubleBuffered = False
        ParentShowHint = False
        RightButton.Hint = 'Pesquisar'
        RightButton.ImageIndex = 0
        RightButton.PressedImageIndex = 0
        RightButton.Visible = True
        ShowHint = True
        TabOrder = 1
        OnExit = BtnEdt_sourceExit
        OnRightButtonClick = BtnEdt_sourceRightButtonClick
      end
      object cboxCondicoes: TComboBox
        Left = 127
        Top = 21
        Width = 67
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 2
        Text = 'Igual'
        OnChange = ListFieldChange
        Items.Strings = (
          'Igual'
          'Diferente'
          'Maior'
          'Maior Igua'
          'Menor'
          'Menor Igual '
          'Contenha')
      end
    end
  end
  object QryListEntidade: TFDQuery
    Left = 400
    Top = 144
  end
  object dsQryListEntidade: TDataSource
    DataSet = QryListEntidade
    Left = 520
    Top = 160
  end
  object ImageList1: TImageList
    Left = 136
    Top = 224
    Bitmap = {
      494C010101000800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      000000000000000000000000000000000000F4F4F400F4F4F400F4F4F400F4F4
      F400F3F3F300F3F3F300F4F4F400F2F2F200F1F1F100F6F6F600F6F6F600F3F3
      F300FFFFFF004242420015151500FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2F2F200F2F2F200F2F2F200F2F2
      F200F2F2F200F4F4F400F3F3F300F3F3F300F3F3F300F4F4F400F3F3F300FEFE
      FE00141414000000000003030300626262000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F3F3F300F3F3F300F3F3F300F3F3
      F300F3F3F300F2F2F200F3F3F300F3F3F300F3F3F300F6F6F600FFFFFF001717
      1700000000000000000000000000D0D0D0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F3F3F300F3F3F300F3F3F300F3F3
      F300FDFDFD00FFFFFF00FFFFFF00F9F9F900F4F4F400FFFFFF000F0F0F000000
      00000000000000000000C8C8C800F3F3F3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F1F1F100F5F5F500FFFFFF00ABAB
      AB000B0B0B0000000000030303003F3F3F00F9F9F900E4E4E400010101000000
      000000000000C7C7C700EFEFEF00F1F1F1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2F2F200FCFCFC00000000000101
      01000F0F0F00676767004E4E4E00030303000000000059595900FEFEFE000101
      0100CBCBCB00F2F2F200EFEFEF00F1F1F1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE000000000001010100FFFF
      FF00FFFFFF00F4F4F400F7F7F700FDFDFD00818181000000000075757500FFFF
      FF00F4F4F400F3F3F300F2F2F200F2F2F2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007070700000000000FCFCFC00F0F0
      F000F3F3F300F3F3F300F4F4F400F1F1F100FBFBFB006868680000000000FFFF
      FF00F1F1F100F0F0F000EFEFEF00F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000044444400F7F7F700F6F6
      F600F3F3F300F3F3F300F2F2F200F2F2F200F4F4F400FCFCFC00030303008787
      8700F4F4F400F4F4F400F3F3F300F2F2F2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A5A5A500FEFEFE00FBFB
      FB00F1F1F100F1F1F100F1F1F100F5F5F500F0F0F000FEFEFE00000000003E3E
      3E00F8F8F800F1F1F100F4F4F400F3F3F3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009F9F9F0052525200A6A6
      A600EEEEEE00F9F9F900F1F1F100F4F4F400F4F4F400FFFFFF00000000004747
      4700F6F6F600F2F2F200F3F3F300F3F3F3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000029292900FFFFFF000000
      0000FCFCFC00FCFCFC00F2F2F200F3F3F300F2F2F200FEFEFE00000000009F9F
      9F00F2F2F200F4F4F400F2F2F200F2F2F2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009494940000000000F4F4F400A0A0
      A0000202020020202000FAFAFA00F1F1F100FCFCFC003737370005050500FDFD
      FD00F1F1F100F4F4F400F2F2F200F3F3F3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF000101010001010100C5C5
      C500FEFEFE00EDEDED00FCFCFC00FFFFFF003636360004040400B1B1B100F1F1
      F100F2F2F200F4F4F400F2F2F200F2F2F2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2F2F200FAFAFA00151515000101
      0100000000001A1A1A00050505000303030000000000A9A9A900FAFAFA00F3F3
      F300F2F2F200F1F1F100F3F3F300F2F2F2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F3F3F300F2F2F200FDFDFD00E5E5
      E500565656000C0C0C002525250089898900FFFFFF00F4F4F400F7F7F700F4F4
      F400F4F4F400F5F5F500F3F3F300F5F5F5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
end