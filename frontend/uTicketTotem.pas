unit uTicketTotem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, RESTRequest4D, System.JSON;

type
  TformTicketTotem = class(TForm)
    pnlSenhaGerada: TPanel;
    btnRetirarSenha: TButton;
    procedure btnRetirarSenhaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure GerarSenha;
  public
    { Public declarations }
  end;

var
  frmTotem: TformTicketTotem;

implementation

{$R *.dfm}

procedure TformTicketTotem.btnRetirarSenhaClick(Sender: TObject);
begin
  GerarSenha;
end;

procedure TformTicketTotem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  frmTotem := nil;
end;

procedure TformTicketTotem.GerarSenha;
var
  LResponse: IResponse;
  LJson: TJSONObject; // Variável para o JSON
begin
  try
    LResponse := TRequest.New.BaseURL('http://localhost:3000')
      .Resource('tickets/gerar')
      .Accept('application/json')
      .Post;

    LJson := TJSONObject.ParseJSONValue(LResponse.Content) as TJSONObject;
    try
      if LResponse.StatusCode = 201 then
        pnlSenhaGerada.Caption := LJson.GetValue<Integer>('senha').ToString
      else
        ShowMessage('Erro Inesperado: ' + LResponse.Content);

    finally
      LJson.Free;
    end;

  except
    ShowMessage('Erro ao conectar com o servidor!');
  end;

end;

end.
