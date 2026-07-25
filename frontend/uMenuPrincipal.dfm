object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Menu Principal'
  ClientHeight = 253
  ClientWidth = 551
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object btnModuloTotem: TButton
    Left = 8
    Top = 96
    Width = 129
    Height = 57
    Caption = 'M'#243'dulo Totem'
    TabOrder = 0
    OnClick = btnModuloTotemClick
  end
  object btnModuloAtendimento: TButton
    Left = 208
    Top = 96
    Width = 129
    Height = 57
    Caption = 'M'#243'dulo Atendimento'
    TabOrder = 1
    OnClick = btnModuloAtendimentoClick
  end
  object btnModuloTV: TButton
    Left = 408
    Top = 96
    Width = 129
    Height = 57
    Caption = 'M'#243'dulo TV/Monitor'
    TabOrder = 2
    OnClick = btnModuloTVClick
  end
end
