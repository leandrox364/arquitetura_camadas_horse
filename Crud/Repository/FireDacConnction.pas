unit FireDacConnction;

interface

uses
  IDataBase,
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
  TFireDacConnection = class(TInterfacedObject, IConnection)
    private
      FDConnection: TFDConnection;
      class var FInstancia : TFireDacConnection;

      constructor Create;
    public
      destructor Destroy; override;
      class function New : IConnection;
      function GetConnection : TCustomConnection;

      function StarTransaction  : IConnection;
      function Commit : IConnection;
      function RollBack : IConnection;
  end;

implementation

uses
  System.SysUtils, Vcl.Forms;

{ TFireDacConnection }

function TFireDacConnection.Commit: IConnection;
begin
  Result := self;
  FDConnection.Commit;
end;

constructor TFireDacConnection.Create;
begin
  if not Assigned(FDConnection)  then
  begin
    try
      FDConnection := TFDConnection.Create(nil);
      FDConnection.Params.Add('Database=C:\Projetos\Crud\DB\CRUD.FDB');
      FDConnection.Params.Add('User_Name=SYSDBA');
      FDConnection.Params.Add('Password=masterkey');
      FDConnection.Params.Add('Server=LOCALHOST');
      FDConnection.Params.Add('Port=3050');
      FDConnection.Params.Add('DriverID=FB');

      FDConnection.Connected:=true;
    except
       on E: Exception do
       begin
          raise Exception.Create('Erro ao tentar conectar ao banco de dados!' + #13 + E.Message);
          Application.terminate;
       end;
    end;
  end;
end;

destructor TFireDacConnection.Destroy;
begin
  if FDConnection.Connected then
     FDConnection.Connected := False;
  if Assigned(FDConnection) then
     FreeAndNil(FDConnection);

  inherited;
end;

function TFireDacConnection.GetConnection: TCustomConnection;
begin
  Result := FDConnection;
end;

class function TFireDacConnection.New: IConnection;
begin
//  if not Assigned(Self.FInstancia)  then
  Self.FInstancia := Self.Create;

  Result := Self.FInstancia;

end;

function TFireDacConnection.RollBack: IConnection;
begin
  Result := self;
  FDConnection.Rollback;
end;

function TFireDacConnection.StarTransaction: IConnection;
begin
  Result := self;
  FDConnection.StartTransaction;
end;

end.
