program projectTicketFlow;

uses
  Vcl.Forms,
  uTicketFlow in 'uTicketFlow.pas' {formTicketFlow};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformTicketFlow, formTicketFlow);
  Application.Run;
end.
