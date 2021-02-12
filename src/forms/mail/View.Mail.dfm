object FormMail: TFormMail
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'ENVIO DE E-MAILS'
  ClientHeight = 89
  ClientWidth = 336
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonEnviarEmail: TButton
    Left = 98
    Top = 32
    Width = 140
    Height = 25
    Caption = 'Enviar E-mail!'
    TabOrder = 0
    OnClick = ButtonEnviarEmailClick
  end
end
