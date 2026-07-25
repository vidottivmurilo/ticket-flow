unit uTicketAtendente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, RESTRequest4D, System.JSON,
  Vcl.ExtCtrls;

type
  TformTicketAtendente = class(TForm)
    edtGuiche: TEdit;
    lblGuiche: TLabel;
    lblTituloSenhaChamada: TLabel;
    sbtnChamarSenha: TSpeedButton;
    pnlSenhaChamada: TPanel;
    procedure sbtnChamarSenhaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure ChamarSenha(guiche: string);
  end;

var
  frmAtendimento: TformTicketAtendente;

implementation


{$R *.dfm}

{ TformTicketFlow }

procedure TformTicketAtendente.ChamarSenha(guiche: string);
var
  LResponse: IResponse;
  LBody: string;
  LJson: TJSONObject; // Variável para o JSON
begin
  LBody := '{"guiche": ' + guiche + '}';
  try
    LResponse := TRequest.New.BaseURL('http://localhost:3000')
      .Resource('tickets/chamar')
      .Accept('application/json')
      .AddBody(LBody)
      .Post;

    LJson := TJSONObject.ParseJSONValue(LResponse.Content) as TJSONObject;
    try
      if LResponse.StatusCode = 200 then
        pnlSenhaChamada.Caption := LJson.GetValue<Integer>('senha').ToString

      else if LResponse.StatusCode = 404 then
        ShowMessage(LJson.GetValue<string>('error'))

      else
        ShowMessage('Erro Inesperado: ' + LResponse.Content);

    finally
      LJson.Free;
    end;

  except
    ShowMessage('Erro ao conectar com o servidor!');
  end;

end;

procedure TformTicketAtendente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  frmAtendimento := nil;
end;

procedure TformTicketAtendente.sbtnChamarSenhaClick(Sender: TObject);
var
  guiche: string;
begin
  guiche := edtGuiche.Text;

  if guiche = '' then begin
    ShowMessage('É necessário informar um guichê!');
    edtGuiche.SetFocus;
    Exit;
  end;

  ChamarSenha(guiche);

end;

end.
