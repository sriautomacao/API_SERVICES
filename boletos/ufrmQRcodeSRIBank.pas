unit ufrmQRcodeSRIBank;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  System.JSON;

type
  TfrmQRcodeSRIBank = class(TForm)
    Image: TImage;
    LinkLabel1: TLabel;
    Timer1: TTimer;
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    Label1: TLabel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    transactionId: string;
    externalIdentifier: string;
    status: string;
    transactionDate: TDateTime;
    transactionType: string;
    totalAmount: Currency;
    paidAmount: Currency;
    textContent: string;
    reference: string;
    qrcodeURL: string;
    cnpj: string;
    jsoAut: TJSONObject;
  end;

var
  frmQRcodeSRIBank: TfrmQRcodeSRIBank;

implementation

uses
  udm, ufrmPrincipal;

{$R *.dfm}

procedure TfrmQRcodeSRIBank.FormActivate(Sender: TObject);
begin
Image.Left:= Trunc((Self.Width-Image.Width)/2);
Image.Top := Trunc((Self.Height-Image.Height) /2);
LinkLabel1.Left:= Trunc((Self.Width-LinkLabel1.Width)/2);
LinkLabel1.Top := Image.Top + Image.Height + 10;
Label1.Left:= Trunc((Self.Width-LinkLabel1.Width)/2);
Label1.Top := LinkLabel1.Top + LinkLabel1.Height + 10;
end;

procedure TfrmQRcodeSRIBank.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Timer1.Enabled:= False;
end;

procedure TfrmQRcodeSRIBank.FormKeyPress(Sender: TObject; var Key: Char);
begin
if (Key=#27) then
  Close;
end;

procedure TfrmQRcodeSRIBank.FormShow(Sender: TObject);
begin
Timer1.Enabled:= True;

end;

procedure TfrmQRcodeSRIBank.Timer1Timer(Sender: TObject);
//const bodyLogin = '{"login":"{{login}}","password":"{{password}}"}';
const bodyLogin = '{"access_token":"{{access_token}}","cnpj":"{{cnpj}}"}';
var
  resp: TStringStream;
  jso: TJSONObject;
  jsoDados: TJSONObject;
  sToken: string;
begin
Timer1.Enabled:= False;
Timer1.Interval:= 3000;
resp   := nil;
jso    := nil;
try
  resp:= TStringStream.Create;
  IdHTTP1.Get(hostAPI + '/pagamentopix/'+cnpj+'/'+externalIdentifier, resp);
  jso:= TJSONObject.Create;
  jso.Parse(resp.Bytes, 0);
  jsoDados:= jso.GetValue('payerPayMediator') as TJSONObject;
  ShowMessage(jsoDados.ToString);

except
  on E: EIdHTTPProtocolException do
    begin
    {
      if Assigned(resp) then
        FreeAndNil(resp);
      if Assigned(jso) then
        FreeAndNil(jso);
      jso:= TJSONObject.Create;
      jso.Parse(BytesOf(e.ErrorMessage), 0); }
    end;
  on e: Exception do
    begin
      ShowMessage(e.Message);
      Close;
    end;
end;
if Assigned(jso) then
  FreeAndNil(jso);
if Assigned(resp) then
  FreeAndNil(resp);
Timer1.Enabled:= True;
end;

end.
