unit Schema.Error;

interface

type
  TError = class
  private
    Ferror: string;
    Fresult: Boolean;
  public
    property result: Boolean read Fresult write Fresult default False;
    property error: string read Ferror write Ferror;
  end;

implementation



end.
