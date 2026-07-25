object formTicketFlow: TformTicketFlow
  Left = 0
  Top = 0
  Caption = 'Ticket Flow'
  ClientHeight = 249
  ClientWidth = 137
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  DesignSize = (
    137
    249)
  TextHeight = 15
  object lblGuiche: TLabel
    Left = 8
    Top = 8
    Width = 37
    Height = 15
    Caption = 'Guich'#234
  end
  object lblSenhaChamada: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 168
    Width = 121
    Height = 45
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblTituloSenhaChamada: TLabel
    Left = 8
    Top = 147
    Width = 89
    Height = 15
    Caption = 'Senha Chamada:'
  end
  object sbtnChamarSenha: TSpeedButton
    Left = 8
    Top = 88
    Width = 121
    Height = 22
    Caption = 'Chamar Senha'
    OnClick = sbtnChamarSenhaClick
  end
  object edtGuiche: TEdit
    Left = 8
    Top = 29
    Width = 121
    Height = 23
    NumbersOnly = True
    TabOrder = 0
  end
end
