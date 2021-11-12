(* From: http://delphi.cjcsoft.net/viewthread.php?tid=45763 *)
unit ThreadFileLog;

interface

uses Windows, ThreadUtilities, System.Classes;

type
    PLogRequest = ^TLogRequest;
    TLogRequest = record
        LogText  : String;
        FileName : String;
    end;

    TThreadFileLog = class(TObject)
    private
        FThreadPool: TThreadPool;
        procedure HandleLogRequest(Data: Pointer; AThread: TThread);
    public
        constructor Create();
        destructor Destroy; override;
        procedure Log( LogText: string);
    end;

implementation

uses
  System.SysUtils, uConstants;

(* Simple reuse of a logtofile function for example *)
procedure LogToFile(const FileName, LogString: String);
var
    F: TextFile;
begin

    AssignFile(F, FileName);

    if not FileExists(FileName) then
        Rewrite(F)
    else
        Append(F);

    try
        Writeln(F, LogString);
    finally
        CloseFile(F);
    end;
end;

constructor TThreadFileLog.Create();
begin
    FThreadPool := TThreadPool.Create(HandleLogRequest, 1);
end;

destructor TThreadFileLog.Destroy;
begin
    FThreadPool.Free;
    inherited;
end;

procedure TThreadFileLog.HandleLogRequest(Data: Pointer; AThread: TThread);
var
    Request: PLogRequest;
begin
    Request := Data;
    try
        LogToFile(Request^.FileName, Request^.LogText);
    finally
        Dispose(Request);
    end;
end;

procedure TThreadFileLog.Log( LogText: string);
var
    Request: PLogRequest;
    FileName: string;
begin
    FileName:= pathLog + 'Log_' + FormatDateTime('yyyymmdd_hh', Now) + '.Log';
    New(Request);
    Request^.LogText  := LogText;
    Request^.FileName := FileName;
    FThreadPool.Add(Request);
end;

end.