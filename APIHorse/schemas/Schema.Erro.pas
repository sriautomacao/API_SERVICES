unit Schema.Erro;

interface

type
  TErro = class
  private
    Ferror: string;
    Fresult: Boolean;
  public
    property result: Boolean read Fresult write Fresult default False;
    property erro: string read Ferror write Ferror;
  end;

implementation



end.
