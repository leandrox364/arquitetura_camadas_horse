unit FireDacQuery;

interface

uses
  IDataBase,
  System.Classes,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  FireDAC.Comp.DataSet,
  FireDAC.Phys.FBDef,
  FireDAC.Phys.IBBase,
  FireDAC.Phys.FB;
 type
  TFireDacQuery = class(TInterfacedObject, IQuery)
    private
       FConnection : IConnection;
       FDQuery      : TFDQuery;
      constructor Create;
    public
      destructor Destroy; override;
      class function New : IQuery;

      function Close :IQuery;
      function SQLClear :IQuery;

      function SQLAdd(aValue : String) :IQuery;
      function SQL(aValue : TStrings) :IQuery;
      function ParamByName(aField : String; aValue : Variant):IQuery;

      function Open :IQuery;
      function ExecSQL : IQuery;

      function DataSource(aValue : TDataSource) : IQuery;
      function GetQuery :TDataSet;
      function Connection :IConnection;


  end;

implementation

uses
  System.SysUtils, FireDacConnction;

{ TFireDacQuery }

function TFireDacQuery.SQLAdd(aValue: String): IQuery;
begin
  Result := self;
  FDQuery.SQL.Add(aValue);

end;

function TFireDacQuery.SQLClear: IQuery;
begin
  Result := self;
  FDQuery.SQL.Clear;
end;

function TFireDacQuery.Close: IQuery;
begin
  Result := self;
  FDQuery.Active := false;

end;

constructor TFireDacQuery.Create;
begin
  // cria a conexão
  FConnection := TFireDacConnection.New;

  FDQuery     := TFDQuery.Create(nil);

  FDQuery.Connection := TFDConnection(FConnection.GetConnection);

 end;

function TFireDacQuery.DataSource(aValue: TDataSource): IQuery;
begin
  Result := self;
  aValue.DataSet := FDQuery;
end;

destructor TFireDacQuery.Destroy;
begin
  if FDQuery.Active then
     FDQuery.Active := False;


  if Assigned(FDQuery) then
     FreeAndNil(FDQuery);

  inherited;
end;

function TFireDacQuery.ExecSQL: IQuery;
begin
  Result := self;
  FDQuery.ExecSQL;

end;

function TFireDacQuery.Connection: IConnection;
begin
  Result := FConnection;
end;

function TFireDacQuery.GetQuery: TDataSet;
begin
  Result := FDQuery;
end;

class function TFireDacQuery.New: IQuery;
begin
 Result := Self.Create;
end;

function TFireDacQuery.Open: IQuery;
begin
  Result := self;
  FDQuery.Active := true;

end;

function TFireDacQuery.ParamByName(aField: String; aValue: Variant): IQuery;
begin
  Result := self;
  FDQuery.ParamByName(aField).Value := aValue;

end;

function TFireDacQuery.SQL(aValue: TStrings): IQuery;
begin
  Result := self;
  FDQuery.SQL := aValue;

end;

end.
