unit uServices;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  Vcl.ExtCtrls;

type
  TServicoResultadoVenda = class(TService)
    Timer1: TTimer;
    procedure ServiceExecute(Sender: TService);
    procedure Timer1Timer(Sender: TObject);
    procedure ServiceDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  ServicoResultadoVenda: TServicoResultadoVenda;

implementation
uses uServicesFunctions;

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  ServicoResultadoVenda.Controller(CtrlCode);
end;

function TServicoResultadoVenda.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TServicoResultadoVenda.ServiceDestroy(Sender: TObject);
begin
FreeAndNil(ServicesFunction);
end;

procedure TServicoResultadoVenda.ServiceExecute(Sender: TService);
begin
  ServicesFunction:= TServicesFunction.Create;
  Timer1.Enabled:= True;
  while not Self.Terminated do
    ServiceThread.ProcessRequests(True);
  Timer1.Enabled:= False;
end;

procedure TServicoResultadoVenda.Timer1Timer(Sender: TObject);
begin
Timer1.Enabled:= False;
  try
    ServicesFunction.build;
  except
  end;
Timer1.Enabled:= True;
end;

end.
