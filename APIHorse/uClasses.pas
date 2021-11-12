unit uClasses;

interface

uses
  System.SysUtils, System.Classes,
  Data.SqlExpr, MidasLib, FireDAC.Phys.Intf,
  Data.FMTBcd, FireDAC.Phys, Horse,
  Data.DB, system.variants, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.VCLUI.Wait,  FireDAC.Comp.UI,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.DApt, FireDAC.Phys.ODBCBase,
  System.NetEncoding, uConfigDataBase,
  Data.Bind.Components, Data.Bind.ObjectScope,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.Phys.IBBase;

function configureDB( configDB: TDBConfig; isProduct: Boolean = False): TFDConnection;
function ValidaGTIN (AGTIN: string): boolean;
function getUserName(Req: THorseRequest ): string;
procedure findFile(dir, findFileName: string; list: TStringList);
Procedure GetDirList(InitialDir:String; DirList:TStringList);

implementation


function configureDB( configDB: TDBConfig; isProduct: Boolean): TFDConnection;
var
  IFconfigurate  : Boolean;
  tentativas: Integer;
  erro      : string;
  fbConn   : TFDConnection;
begin
  IFconfigurate:= True;
  tentativas:= 0;
  erro:= EmptyStr;
  Result:= nil;
while IFconfigurate do
  begin
    try
      fbConn := TFDConnection.Create(nil);
      fbConn.DriverName  := 'FB';
      fbConn.LoginPrompt := False;
      fbConn.Params.Clear;
      //fbConn.Params.Add('Server='+configDB.HostName);
      if isProduct then
        fbConn.Params.Add('DataBase='+ configDB.DBName2)
      else
        fbConn.Params.Add('DataBase='+ configDB.DBName);
      fbConn.Params.Add('User_Name='+ configDB.UserName);
      fbConn.Params.Add('Password=' + configDB.Password);
      fbConn.Params.Add('Port=' + configDB.Port.ToString);
      fbConn.Params.Add('DriverID=FB');
      fbConn.Open;
      Result:= fbConn;
      IFconfigurate:= False;
      erro:= EmptyStr;
    except
      on e: exception do
        begin
          if fbConn <> nil then
              try FreeAndNil(fbConn) except end;
          inc(tentativas);
          if tentativas > 2 then
            begin
              IFconfigurate:=  False;
              erro    :=  e.Message;
            end;
        end;
    end;
  end;
end;


function ValidaGTIN(AGTIN: string): boolean;
var
  i, soma, resultado, base10: integer;
begin
  //Verifica se todos os caracteres de AGTIN são números
  for i:= 1 to Length(AGTIN) do
    if not (AGTIN[i] in ['0'..'9']) then
    begin
      Result:= False;
      Exit;
    end;
  //Verifica se AGTIN tem o tamanho necessário
  if Length(AGTIN) in [8,12,13,14] then
  begin
    soma:= 0;
    for i:= 1 to (Length(AGTIN) -1) do
    begin
      if Length(AGTIN) = 13 then
      begin
        if Odd(i) then
          soma:= soma + (strtoint(AGTIN[i]) * 1)
        else
          soma:= soma + (strtoint(AGTIN[i]) * 3);
      end
      else
      begin
        if Odd(i) then
          soma:= soma + (strtoint(AGTIN[i]) * 3)
        else
          soma:= soma + (strtoint(AGTIN[i]) * 1);
      end;
    end;
    base10:= soma;
    //Verifica se base10 é múltiplo de 10
    if not (base10 mod 10 = 0) then
    begin
      while not (base10 mod 10 = 0) do
      begin
        base10:= base10 + 1;
      end;
    end;
    resultado:= base10 - soma;
    //Verifica se o resultado encontrado é igual ao caractere de controle
    if resultado = strtoint(AGTIN[Length(AGTIN)]) then
      Result:= True
    else
      Result:= False;
  end
  else
    Result:= False;
end;

function getUserName(Req: THorseRequest ): string;
var
  sBasicAuthenticationEncode,
  sBase64String :  string;
  LBasicAuthenticationDecode: TStringList;
begin
    sBasicAuthenticationEncode := Req.Headers['authorization'];
    try
      LBasicAuthenticationDecode := TStringList.Create;
      LBasicAuthenticationDecode.Delimiter := ':';
      sBase64String := sBasicAuthenticationEncode.Replace('basic', '', [rfIgnoreCase]);
      LBasicAuthenticationDecode.DelimitedText := TBase64Encoding.Base64.Decode(sBase64String);
      result := LBasicAuthenticationDecode.Strings[0];
    finally
       FreeAndNil(LBasicAuthenticationDecode);
    end;
end;

procedure findFile(dir, findFileName: string; list: TStringList);
var
  f: TSearchRec;
  r: integer;
begin
  if dir[length(dir)]<>'\' then
    dir := dir+'\';
  if not DirectoryExists(dir) then
    exit;
  r := FindFirst(dir+findFileName,faAnyFile ,f);
  while (r=0) do
    begin
      if (f.Name = '.') or (f.Name='..') then
        Continue;
      if f.Attr = fadirectory then
        findFile(dir+f.Name,findFileName,list)
      else
        begin
          list.Add(dir+f.Name);
        end;
      r := FindNext(f);
    end;
end;

procedure GetDirList(InitialDir: String;
  DirList: TStringList);
Var
  Info:TSearchRec;
Begin
  if (Copy(InitialDir,InitialDir.Length,1)='\') then
      InitialDir:=  Copy(InitialDir,1,InitialDir.Length-1);
  If FindFirst(InitialDir + '\*.', faDirectory, Info) = 0 Then
    Begin
      If (Info.Name <> '.') And (Info.Name <> '..') Then
        Begin
          DirList.Add(InitialDir + '\' + Info.Name);
          GetDirList(InitialDir + '\' + Info.Name, DirList);
        End;
      While FindNext(Info) = 0 Do
      If (Info.Name <> '.') And (Info.Name <> '..') Then
        Begin
          DirList.Add(InitialDir + '\' + Info.Name);
          GetDirList(InitialDir + '\' + Info.Name, DirList);
        End
    End;
  System.SysUtils.FindClose(Info);
End;


end.
