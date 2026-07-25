object formTicketAtendente: TformTicketAtendente
  Left = 0
  Top = 0
  Caption = 'Ticket Atendente'
  ClientHeight = 280
  ClientWidth = 330
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  TextHeight = 15
  object lblGuiche: TLabel
    Left = 104
    Top = 8
    Width = 37
    Height = 15
    Caption = 'Guich'#234
  end
  object lblTituloSenhaChamada: TLabel
    Left = 8
    Top = 147
    Width = 89
    Height = 15
    Caption = 'Senha Chamada:'
  end
  object sbtnChamarSenha: TSpeedButton
    Left = 104
    Top = 88
    Width = 121
    Height = 22
    Caption = 'Chamar Senha'
    OnClick = sbtnChamarSenhaClick
  end
  object edtGuiche: TEdit
    Left = 104
    Top = 29
    Width = 121
    Height = 23
    NumbersOnly = True
    TabOrder = 0
  end
  object pnlSenhaChamada: TPanel
    Left = 0
    Top = 168
    Width = 330
    Height = 112
    Align = alBottom
    TabOrder = 1
  end
end
