unit uFrmPrincipal;

interface

uses
  System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, uDWAbout, uRESTDWBase, FMX.Forms;

type
  TfrmPrincipal = class(TForm)
    Switch1: TSwitch;
    RESTServicePooler: TRESTServicePooler;
    procedure Switch1Switch(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure conectaBanco;
  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  uDataModule, System.SysUtils;

{$R *.fmx}

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  RESTServicePooler.ServerMethodClass := TDM;
  RESTServicePooler.Active := Switch1.IsChecked;

  conectaBanco;
end;

procedure TfrmPrincipal.Switch1Switch(Sender: TObject);
begin
  RESTServicePooler.Active := Switch1.IsChecked;
end;

procedure TfrmPrincipal.conectaBanco();
var  sLinha,slocal,slocal2, sAux, sPathSysAdm : String;
     ARQ_CABCUPOM, STATUS_SYS : TEXTFILE;
     LINHA : INTEGER;
begin

   sPathSysAdm := ExtractFilePath(ParamStr(0))+ 'sysadm.txt';

  if fileexists(sPathSysAdm) then
     begin

       AssignFile (STATUS_SYS, sPathSysAdm);
       Reset( STATUS_SYS );
       while not Eof (status_sys) do
         begin

           ReadLn ( STATUS_SYS, sLinha    );
           if Copy(sLinha, 1, 8) = 'PATHSVR1' then
              slocal := Copy(sLinha, 12, Length(sLinha) - 11);

           if Copy(sLinha, 1, 8) = 'PATHSVR2' then
              slocal2 := Copy(sLinha, 12, Length(sLinha) - 11);

         end;

       CloseFile ( STATUS_SYS );
     end
  else
     begin
       ShowMessage('Arquivo de Configuração do Sistema não encontrado');
       Application.terminate;
     end;

   try
     DM.Conn.Connected := False;
     DM.Conn.Params.Values['DriverID'] := 'FB';
     DM.Conn.Params.Values['DataBase'] := slocal;
     DM.Conn.Params.Values['User_Name'] := 'SYSDBA';
     DM.Conn.Params.Values['Password'] := 'masterkey';
     DM.Conn.Connected := True;

   Except
      ShowMessage('Erro ao conectar no Banco');
   end;

   try
     DM.Conn2.Connected := False;
     DM.Conn2.Params.Values['DriverID'] := 'FB';
     DM.Conn2.Params.Values['DataBase'] := slocal2;
     DM.Conn2.Params.Values['User_Name'] := 'SYSDBA';
     DM.Conn2.Params.Values['Password'] := 'masterkey';
     DM.Conn2.Connected := True;

   Except
      ShowMessage('Erro ao conectar no Banco 2');
   end;

end;

end.
