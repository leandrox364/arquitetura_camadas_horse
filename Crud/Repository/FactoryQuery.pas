unit FactoryQuery;

interface

uses
  Data.DB,
  System.SysUtils,
  IDataBase;

type
  TFactoryQuery = class(TInterfacedObject, IFactoryQuery)
    private
      constructor Create;
    public
      destructor Destroy; override;
      class function New : IFactoryQuery;

     function Query : Iquery;

  end;

implementation

uses
  FireDacQuery, FireDacConnction;

{ TFactoryQuery }

constructor TFactoryQuery.Create;
begin

end;

destructor TFactoryQuery.Destroy;
begin
  inherited;
end;

class function TFactoryQuery.New: IFactoryQuery;
begin
  Result := self.Create;
end;

function TFactoryQuery.Query: Iquery;
begin
  Result := TFireDacQuery.New;
end;

end.

