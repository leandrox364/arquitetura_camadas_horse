unit ClienteService;

interface

uses
 System.Classes,
 System.Generics.Collections,
 System.SysUtils,
 REST.Json,
 IClienteRepository,
 ClienteModel,
 ClienteRepository,
 Data.DB;

type
   TClienteService = class
     private
        FClienteRepository : IClienteRepository<TClienteModel>;
     public
        constructor Create;
        destructor Destroy; override;

        function GetById(id : integer) : TClienteModel;
        function GetByIdJson(id : integer)   : String;

        function GetAll : TObjectList<TClienteModel>;
        function GetAllJson   : String;

        function Post(obj : TClienteModel)  : TClienteModel; overload;
        function Post(json :String) : String;   overload;

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

{ TClienteService }


constructor TClienteService.Create;
begin
  FClienteRepository := TClienteRepository.New;
end;

destructor TClienteService.Destroy;
begin

  inherited;
end;


function TClienteService.GetById(id: integer): TClienteModel;
begin
  if id  <= 0 then
     raise Exception.Create('Informe o id.');

  Result := FClienteRepository.GetById(id);

end;

function TClienteService.GetByIdJson(id: integer): String;
begin
  if id  <= 0 then
     raise Exception.Create('Informe o id para pesquisar.');

  Result := FClienteRepository.GetByIdJson(id);
end;


function TClienteService.GetAll: TObjectList<TClienteModel>;
begin
  Result := FClienteRepository.GetAll;
end;

function TClienteService.GetAllJson: String;
begin
  Result := FClienteRepository.GetAllJson;
end;

function TClienteService.Post(obj: TClienteModel): TClienteModel;
begin
  if obj.Nome = ''  then
     raise Exception.Create('Informe o nome.');

  if obj.Email = ''  then
     raise Exception.Create('Informe o email.');

  Result := FClienteRepository.Post(obj);
end;

function TClienteService.Post(json: String): String;
var
  ClienteModel : TClienteModel;
begin
  ClienteModel := Nil;
  try
    try
       ClienteModel := TJson.JsonToObject<TClienteModel>(json);
    except
      raise Exception.Create('Cliente não criado corretamente.');
    end;

    if ClienteModel.Nome = ''  then
       raise Exception.Create('Informe o nome.');

    if ClienteModel.Email = ''  then
       raise Exception.Create('Informe o email.');

    Result := FClienteRepository.Post(json);
  finally
    ClienteModel.Free;
  end;


end;

function TClienteService.Put(obj: TClienteModel): TClienteModel;
begin
  if obj.id <= 0  then
     raise Exception.Create('Informe o id.');

  if obj.Nome = ''  then
     raise Exception.Create('Informe o nome.');

  if obj.Email = ''  then
     raise Exception.Create('Informe o email.');

  Result := FClienteRepository.Put(obj);
end;

function TClienteService.Put(json: String): String;
var
  ClienteModel : TClienteModel;
begin
  ClienteModel := Nil;
  try
    try
       ClienteModel := TJson.JsonToObject<TClienteModel>(json);
    except
      raise Exception.Create('Cliente não criado corretamente.');
    end;
    if ClienteModel.id <= 0  then
       raise Exception.Create('Informe o id.');

    if ClienteModel.Nome = ''  then
       raise Exception.Create('Informe o nome.');

    if ClienteModel.Email = ''  then
       raise Exception.Create('Informe o email.');

    Result := FClienteRepository.Put(json);
  finally
    ClienteModel.Free;
  end;
end;

function TClienteService.Delete(id: integer): boolean;
begin
  if id  <= 0 then
     raise Exception.Create('Informe o id.');

  Result := FClienteRepository.Delete(id);

end;

function TClienteService.Delete(obj: TClienteModel): boolean;
begin
  if obj.id  <= 0 then
     raise Exception.Create('Informe o id.');
  Result := FClienteRepository.Delete(obj);
end;


function TClienteService.GetByNome(nome: String): TObjectList<TClienteModel>;
begin
  if (nome = '') or (Length(nome) < 1) then
     raise Exception.Create('Informe um nome com pelo menos 5 caracteres.');

  Result := FClienteRepository.GetByNome(nome);
end;

function TClienteService.GetByNomeJson(nome: String): String;
begin
  if (nome = '') or (Length(nome) < 1) then
     raise Exception.Create('Informe um nome com pelo menos 5 caracteres.');

  Result := FClienteRepository.GetByNomeJson(nome);
end;

function TClienteService.GetByEmail(email: String): TClienteModel;
begin
  if (email = '') then
     raise Exception.Create('Informe o email.');

  Result := FClienteRepository.GetByEmail(email);
end;

function TClienteService.GetByEmailJson(email: String): String;
begin
  if (email = '') then
     raise Exception.Create('Informe o email.');

  Result := FClienteRepository.GetByEmailJson(email);
end;


end.
