unit uConfigDataBase;

interface

type
  TDBConfig = class
  strict private
    FPort: Word;
    FPassword: string;
    FHostName: string;
    FUserName: string;
    FDBName: string;
    FDBName2: string;
  public
    procedure SetHostName(const Value: string);
    procedure SetDBName(const Value: string);
    procedure SetDBName2(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetPort(const Value: Word);
    procedure SetUserName(const Value: string);
    property HostName: string read FHostName;
    property DBName: string read FDBName;
     property DBName2: string read FDBName2;
    property UserName: string read FUserName;
    property Password: string read FPassword;
    property Port: Word read FPort;
  end;

implementation

{ TDBConfig }

procedure TDBConfig.SetDBName(const Value: string);
begin
  FDBName:= Value;
end;

procedure TDBConfig.SetDBName2(const Value: string);
begin
 FDBName2:= Value;
end;

procedure TDBConfig.SetHostName(const Value: string);
begin
  FHostName := Value;
end;

procedure TDBConfig.SetPassword(const Value: string);
begin
  FPassword := Value;
end;

procedure TDBConfig.SetPort(const Value: Word);
begin
  FPort := Value;
end;

procedure TDBConfig.SetUserName(const Value: string);
begin
  FUserName := Value;
end;

end.
