unit SRIBANK.PARAMS;

interface

uses
  System.Classes, System.SysUtils;


type
  TSRIBankParams = class
  private
    Fcnpj: string;
    Falias: string;
    Fhost: string;
    Faccess_token: string;
    Fid_account: string;
    Fusername: string;
    Fpassword: string;
  public
    property access_token: string read Faccess_token;
    property cnpj: string read Fcnpj;
    property alias: string read Falias;
    property id_account: string read Fid_account;
    property host: string read Fhost;
    property username: string read Fusername;
    property password: string read Fpassword;
    constructor Create();
  end;
var
  SRIBankParams: TSRIBankParams;

implementation

uses
  FireDAC.Comp.Client, FireDAC.Stan.Option, uFunctions;

{ TSRIBank }

constructor TSRIBankParams.Create();
var
  dbConn: TFDConnection;
  qry   : TFDQuery;
begin

  dbConn:=nil;
  qry   :=nil;
  try
    qry := TFDQuery.Create(nil);
    qry.Connection:= connectDB();
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('select * from SRIBANK');
    qry.Open();
    if qry.IsEmpty then
      raise Exception.Create('Não configurado para PIX');

    Self.Fcnpj := '26191804000109';
    Self.Falias:= qry.FieldByName('ALIAS').AsString;
    Self.Fhost := qry.FieldByName('host').AsString;
    Self.Faccess_token:= qry.FieldByName('ACCESS_TOKEN').AsString;
    Self.Fid_account  := qry.FieldByName('ID_ACCOUNT').AsString;
    Self.Fusername    := qry.FieldByName('USERNAME').AsString;
    Self.Fpassword    := qry.FieldByName('PASSWORD').AsString;
  except
    Self.Fcnpj := EmptyStr;
    Self.Falias:= EmptyStr;
    Self.Fhost := EmptyStr;
    Self.Faccess_token:= EmptyStr;
    Self.Fid_account  := EmptyStr;
    Self.Fusername    := EmptyStr;
    Self.Fpassword    := EmptyStr;
  end;
  if Assigned(dbConn) then
    FreeAndNil(dbConn);
  if Assigned(qry) then
      FreeAndNil(qry);
end;








end.
