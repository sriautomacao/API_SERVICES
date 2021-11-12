unit DM.POO.picpay;

interface

uses
  SysUtils, 
  Generics.Collections, 
  Aurelius.Mapping.Attributes, 
  Aurelius.Types.Blob, 
  Aurelius.Types.DynamicProperties, 
  Aurelius.Types.Nullable, 
  Aurelius.Types.Proxy, 
  Aurelius.Dictionary.Classes, 
  Aurelius.Linq;

type
  TPICPAY = class;
  TPICPAYDictionary = class;
  
  [Entity]
  [Table('PICPAY')]
  [Id('FTOKEN', TIdGenerator.None)]
  TPICPAY = class
  private
    [Column('TOKEN', [TColumnProp.Required], 40)]
    FTOKEN: string;
    
    [Column('FONE', [], 15)]
    FFONE: Nullable<string>;
    
    [Column('EMAIL', [], 65)]
    FEMAIL: Nullable<string>;
  public
    property TOKEN: string read FTOKEN write FTOKEN;
    property FONE: Nullable<string> read FFONE write FFONE;
    property EMAIL: Nullable<string> read FEMAIL write FEMAIL;
  end;
  
  IPICPAYDictionary = interface;
  
  IPICPAYDictionary = interface(IAureliusEntityDictionary)
    function TOKEN: TLinqProjection;
    function FONE: TLinqProjection;
    function EMAIL: TLinqProjection;
  end;
  
  TPICPAYDictionary = class(TAureliusEntityDictionary, IPICPAYDictionary)
  public
    function TOKEN: TLinqProjection;
    function FONE: TLinqProjection;
    function EMAIL: TLinqProjection;
  end;
  
  IDictionary = interface(IAureliusDictionary)
    function PICPAY: IPICPAYDictionary;
  end;
  
  TDictionary = class(TAureliusDictionary, IDictionary)
  public
    function PICPAY: IPICPAYDictionary;
  end;
  
function Dic: IDictionary;

implementation

var
  __Dic: IDictionary;

function Dic: IDictionary;
begin
  if __Dic = nil then __Dic := TDictionary.Create;
  result := __Dic;
end;

{ TPICPAYDictionary }

function TPICPAYDictionary.TOKEN: TLinqProjection;
begin
  Result := Prop('TOKEN');
end;

function TPICPAYDictionary.FONE: TLinqProjection;
begin
  Result := Prop('FONE');
end;

function TPICPAYDictionary.EMAIL: TLinqProjection;
begin
  Result := Prop('EMAIL');
end;

{ TDictionary }

function TDictionary.PICPAY: IPICPAYDictionary;
begin
  Result := TPICPAYDictionary.Create;
end;

initialization
  RegisterEntity(TPICPAY);

end.
