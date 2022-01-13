unit FactoryConnection;

interface

uses
  Data.DB,
  System.SysUtils,
  IDataBase;

type
  TFactoryConnection = class(TInterfacedObject, IFactoryConnection)
    private
      FConnection : IConnection;
      constructor Create;
    public
      destructor Destroy; override;
      class function New : IFactoryConnection;

     function GetConnection : IConnection;

  end;

implementation

uses
  FireDacQuery, FireDacConnction;

{ TFactoryConnection }

constructor TFactoryConnection.Create;
begin
  Fconnection := TFireDacConnection.New;
end;

destructor TFactoryConnection.Destroy;
begin

  inherited;
end;

class function TFactoryConnection.New: IFactoryConnection;
begin
  Result := Self.Create;
end;

function TFactoryConnection.GetConnection: IConnection;
begin
  Result := FConnection;
end;

end.

