program serveOSConsole;
 {$APPTYPE CONSOLE}

uses
  uFunctions in 'uFunctions.pas',
  uMain in 'uMain.pas',
  uClasses in 'uClasses.pas',
  Horse,
  System.Json,
  System.SysUtils,
  uSwagger in 'uSwagger.pas',
  uConfigDataBase in 'uConfigDataBase.pas',
  uConstants in 'uConstants.pas',
  SRIBANK.PARAMS in 'SRIBANK.PARAMS.pas';

procedure Console(cmd: String);
begin
  Writeln(cmd);
end;


procedure Terminal(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Next;


  Writeln(DateTimeToStr(Now) );
  Writeln('Router: ' + QuotedStr( Req.RawWebRequest.PathInfo));
  Writeln('Method: ' + QuotedStr(Req.RawWebRequest.Method));
  Writeln('Content: ' + Req.RawWebRequest.Content);
  Writeln('Response:');

  try
    Writeln((Res.Content as TJSONObject).ToString);
  except
     try
       Writeln((Res.Content as TJSONArray).ToString);
     except
      Writeln('{}');
     end;
  end;
  Writeln('');
end;

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  TApi.Initialize();
  Api.Log(Terminal);
  Api.Listen(Console);
end.
