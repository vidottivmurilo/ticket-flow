unit uTicketMonitor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Bird.Socket.Client, System.JSON;

type
  TformTicketMonitor = class(TForm)
    pnlSenha: TPanel;
    pnlGuiche: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    FBirdSocket: TBirdSocketClient;
  public
    { Public declarations }
  end;

var
  frmMonitor: TformTicketMonitor;

implementation

{$R *.dfm}

procedure TformTicketMonitor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  frmMonitor := nil;
end;

procedure TformTicketMonitor.FormCreate(Sender: TObject);
begin
  FBirdSocket := TBirdSocketClient.New('ws://localhost:3000');

  FBirdSocket.AddEventListener(TEventType.MESSAGE,
    procedure(const AMsg: string)
    begin

      TThread.Synchronize(nil,
        procedure
        var
          LJson: TJSONObject;
        begin
          LJson := TJSONObject.ParseJSONValue(AMsg) as TJSONObject;
          try
            if LJson <> nil then
            begin

              pnlGuiche.Caption := 'Guichê: ' + LJson.GetValue<Integer>('guiche').ToString;
              pnlSenha.Caption := 'Senha: ' + LJson.GetValue<Integer>('senha').ToString;

            end;
          finally
            LJson.Free;
          end;
        end);
    end);

  FBirdSocket.Connect;
end;

end.
