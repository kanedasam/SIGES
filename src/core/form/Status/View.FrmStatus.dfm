object frmStatusMsm: TfrmStatusMsm
  Left = 528
  Top = 295
  AlphaBlend = True
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 109
  ClientWidth = 481
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 481
    Height = 109
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 2
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object Panel2: TPanel
      Left = 2
      Top = 71
      Width = 477
      Height = 36
      Align = alBottom
      BevelEdges = []
      BevelOuter = bvNone
      Color = 4407268
      ParentBackground = False
      TabOrder = 1
      object lblStatus: TLabel
        Left = 0
        Top = 0
        Width = 477
        Height = 13
        Align = alTop
        Caption = 'Aguarde...'
        Color = 4407268
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        ExplicitWidth = 54
      end
    end
    object Panel3: TPanel
      Left = 2
      Top = 2
      Width = 477
      Height = 69
      Align = alClient
      BevelEdges = []
      BevelOuter = bvNone
      Color = 14080731
      ParentBackground = False
      TabOrder = 0
    end
  end
end
