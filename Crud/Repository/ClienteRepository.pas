unit ClienteRepository;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Rest.Json,
  ClienteModel,
  IClienteRepository,
  Data.DB,
  IDataBase,
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
  TClienteRepository = class (TInterfacedObject , IClienteRepository<TClienteModel>)
   private
      FQuery : IQuery;
      constructor Create;
   public
      destructor Destroy; override;

      class function New: IClienteRepository<TClienteModel>;

      function GetById(id : integer) : TClienteModel;
      function GetByIdJson(id : integer)   : String;

      function GetAll : TObjectList<TClienteModel>;
      function GetAllJson     : String;

      function Post(obj : TClienteModel)  : TClienteModel; overload;
      function Post(json :String) : String;       overload;

      function Put(obj : TClienteModel)   : TClienteModel; overload;
      function Put(json : String) : String;   overload;

      function Delete(id : integer)   : boolean; overload;
      function Delete(obj : TClienteModel) : boolean; overload;

      function GetByNome(nome : String) : TObjectList<TClienteModel>;
      function GetByNomeJson(nome : String)   : String;

      function GetByEmail(email : String) : TClienteModel;
      function GetByEmailJson(email : String)   : String;

  end;


implementation

uses
  FireDacQuery, FactoryQuery;



{ TClienteRepository }
constructor TClienteRepository.Create;
begin
  // em cada método é instânciado uma nova query na variavel FQuery
end;

destructor TClienteRepository.Destroy;
begin
  inherited;
end;

class function TClienteRepository.New: IClienteRepository<TClienteModel>;
begin
  Result := self.Create;
end;

function TClienteRepository.GetById(id: integer): TClienteModel;
var
  ClienteModel : TClienteModel;
begin
  FQuery := TFactoryQuery.New.Query;
  FQuery.Close;
  FQuery.SQLClear;
  FQuery.SQLAdd('SELECT * FROM CLIENTE ');
  FQuery.SQLAdd('WHERE ID = :ID ');
  FQuery.ParamByName('ID' , id);

  FQuery.Open;


  if not FQuery.GetQuery.IsEmpty then
  begin
    ClienteModel       := TClienteModel.Create;
    ClienteModel.id    := FQuery.GetQuery.FieldByName('id').AsInteger;
    ClienteModel.Nome  := FQuery.GetQuery.FieldByName('nome').AsString;
    ClienteModel.Email := FQuery.GetQuery.FieldByName('email').AsString;
    ClienteModel.Idade := FQuery.GetQuery.FieldByName('idade').AsInteger;
    Result        :=  ClienteModel;
  end
  else
    Result:= Nil;
end;

function TClienteRepository.GetByIdJson(id: integer): String;
var
  ClienteModel : TClienteModel;
begin
  ClienteModel       := GetById(id);

  if Assigned(ClienteModel) then
     Result := TJson.ObjectToJsonString( ClienteModel )
  else
     Result := '';

  ClienteModel.free;

end;


function TClienteRepository.GetAll: TObjectList<TClienteModel>;
var
  ClienteModel : TClienteModel;
begin
  Result := TObjectList<TClienteModel>.Create;

  FQuery := TFactoryQuery.New.Query;
  FQuery.Close;
  FQuery.SQLClear;
  FQuery.SQLAdd('SELECT * FROM CLIENTE ');
  FQuery.SQLAdd('ORDER BY NOME ');

  FQuery.Open;

  if not FQuery.GetQuery.IsEmpty then
  begin

    while not FQuery.GetQuery.Eof do
    begin
      ClienteModel       := TClienteModel.Create;
      ClienteModel.id    := FQuery.GetQuery.FieldByName('id').AsInteger;
      ClienteModel.Nome  := FQuery.GetQuery.FieldByName('nome').AsString;
      ClienteModel.Email := FQuery.GetQuery.FieldByName('email').AsString;
      ClienteModel.Idade := FQuery.GetQuery.FieldByName('idade').AsInteger;

      Result.Add(ClienteModel);

      FQuery.GetQuery.Next;
    end;
  end;

end;

function TClienteRepository.GetAllJson: String;
var
  vjson : string;
  ListaClientes : TObjectList<TClienteModel>;
  i: Integer;
begin
  vjson := '[';

  ListaClientes := GetAll;

  for i := 0 to pred(ListaClientes.Count) do
  begin
    if  i = 0 then
        vjson := vjson + TJson.ObjectToJsonString(ListaClientes[i])
    else
        vjson := vjson +',' + TJson.ObjectToJsonString(ListaClientes[i]);
  end;

  vjson := vjson + ']';

  Result := vjson;

  ListaClientes.Free;
end;

function TClienteRepository.Post(obj: TClienteModel): TClienteModel;
var
  vid : integer;
begin
  FQuery := TFactoryQuery.New.Query;
  FQuery.Close;
  FQuery.SQLClear;
  FQuery.SQLAdd('insert into CLIENTE (ID, NOME, EMAIL, IDADE) ');
  FQuery.SQLAdd('values (:ID, :NOME, :EMAIL, :IDADE)');
  FQuery.SQLAdd('returning ID ');

  FQuery.ParamByName('id'    , obj.Id);
  FQuery.ParamByName('nome'  , obj.Nome);
  FQuery.ParamByName('email' , obj.Email);
  FQuery.ParamByName('idade' , obj.Idade);

  FQuery.Connection.StarTransaction;
  try
     FQuery.Open;
     FQuery.Connection.Commit;
  except
     FQuery.Connection.Rollback;
  end;
  vid := FQuery.GetQuery.FieldByName('id').AsInteger;

  Result := GetById(vid);


end;

function TClienteRepository.Post(json: String): String;
var
  ClienteModel : TClienteModel;
  ClienteSalvo : TClienteModel;
begin
  ClienteModel := TJson.JsonToObject<TClienteModel>(json);
  ClienteSalvo := Post(ClienteModel);
  Result := TJson.ObjectToJsonString( ClienteSalvo );

  ClienteModel.Free;
  ClienteSalvo.Free;
end;

function TClienteRepository.Put(obj: TClienteModel): TClienteModel;
begin
  FQuery := TFactoryQuery.New.Query;

  FQuery.Close;
  FQuery.SQLClear;
  FQuery.SQLAdd('update CLIENTE ');
  FQuery.SQLAdd('set NOME  = :NOME, ');
  FQuery.SQLAdd('    EMAIL = :EMAIL, ');
  FQuery.SQLAdd('    IDADE = :IDADE ');
  FQuery.SQLAdd('where (ID = :ID)');

  FQuery.ParamByName('id'    , obj.id);
  FQuery.ParamByName('nome'  , obj.Nome);
  FQuery.ParamByName('email' , obj.Email);
  FQuery.ParamByName('idade' , obj.Idade);

  FQuery.Connection.StarTransaction;
  try
     FQuery.ExecSQL;
     FQuery.Connection.Commit;

  except
     FQuery.Connection.Rollback;
  end;
  Result := GetById(obj.id);
end;

function TClienteRepository.Put(json: String): String;
var
  ClienteModel : TClienteModel;
  ClienteSalvo : TClienteModel;
begin
  ClienteModel := TJson.JsonToObject<TClienteModel>(json);
  ClienteSalvo := Put(ClienteModel);
  Result := TJson.ObjectToJsonString( ClienteSalvo );

  ClienteModel.Free;
  ClienteSalvo.Free
end;

function TClienteRepository.Delete(id: integer): boolean;
begin
  FQuery := TFactoryQuery.New.Query;
  FQuery.SQLClear;
  FQuery.SQLAdd('DELETE FROM CLIENTE ');
  FQuery.SQLAdd('WHERE ID = :ID ');
  FQuery.ParamByName('ID' , id);

  try
     FQuery.ExecSQL;
     FQuery.Connection.Commit;
     Result := True;
  except
     FQuery.Connection.Rollback;
     Result := False;

  end;
end;

function TClienteRepository.Delete(obj: TClienteModel): boolean;
begin
  Result := Delete(obj.id);
end;

function TClienteRepository.GetByNome(nome: String): TObjectList<TClienteModel>;
var
  ClienteModel : TClienteModel;
begin
  Result := TObjectList<TClienteModel>.Create;

  FQuery := TFactoryQuery.New.Query;
  FQuery.Close;
  FQuery.SQLClear;
  FQuery.SQLAdd('SELECT * FROM CLIENTE ');
  FQuery.SQLAdd('WHERE UPPER(NOME) LIKE UPPER(:NOME) ');
  FQuery.SQLAdd('ORDER BY NOME ');
  FQuery.ParamByName('NOME' , '%'+nome+'%');
  FQuery.Open;

  while not FQuery.GetQuery.Eof do
  begin
    ClienteModel       := TClienteModel.Create;
    ClienteModel.id    := FQuery.GetQuery.FieldByName('id').AsInteger;
    ClienteModel.Nome  := FQuery.GetQuery.FieldByName('nome').AsString;
    ClienteModel.Email := FQuery.GetQuery.FieldByName('email').AsString;
    ClienteModel.Idade := FQuery.GetQuery.FieldByName('idade').AsInteger;

    Result.Add(ClienteModel);

    FQuery.GetQuery.Next;
  end;

end;


function TClienteRepository.GetByNomeJson(nome: String): String;
var
  vjson : string;
  ListaClientes : TObjectList<TClienteModel>;
  i : integer;
begin
  vjson := '[';

  ListaClientes := GetByNome(nome);

  for i := 0 to pred(ListaClientes.Count) do
  begin
    if  i = 0 then
        vjson := vjson + TJson.ObjectToJsonString(ListaClientes[i])
    else
        vjson := vjson +',' + TJson.ObjectToJsonString(ListaClientes[i]);
  end;


  vjson := vjson + ']';

  Result := vjson;

  ListaClientes.Free;
end;


function TClienteRepository.GetByEmail(email: String): TClienteModel;
var
  ClienteModel : TClienteModel;
begin
  FQuery := TFactoryQuery.New.Query;
  FQuery.Close;
  FQuery.SQLClear;
  FQuery.SQLAdd('SELECT * FROM CLIENTE ');
  FQuery.SQLAdd('WHERE EMAIL = :EMAIL  ');
  FQuery.ParamByName('EMAIL' , email);
  FQuery.Open;


  if not FQuery.GetQuery.IsEmpty then
  begin
    ClienteModel       := TClienteModel.Create;
    ClienteModel.id    := FQuery.GetQuery.FieldByName('id').AsInteger;
    ClienteModel.Nome  := FQuery.GetQuery.FieldByName('nome').AsString;
    ClienteModel.Email := FQuery.GetQuery.FieldByName('email').AsString;
    ClienteModel.Idade := FQuery.GetQuery.FieldByName('idade').AsInteger;
    Result :=  ClienteModel;
  end
  else
    Result:= Nil;

end;

function TClienteRepository.GetByEmailJson(email: String): String;
var
  ClienteModel : TClienteModel;
begin
  ClienteModel := GetByEmail(email);
  if Assigned(ClienteModel) then
     Result :=  TJson.ObjectToJsonString(ClienteModel)
  else
     Result := '';

  ClienteModel.free;
end;

end.
