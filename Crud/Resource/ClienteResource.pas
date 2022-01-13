unit ClienteResource;

interface

uses
 ClienteModel,
 System.Classes,
 System.Generics.Collections,
 ClienteService,
 Data.DB,
 ClienteRepository,
 IClienteRepository;

type
   TClienteResource = class
     private
        FClienteRepository : IClienteRepository<TClienteModel>;
        FClienteService : TClienteService;
        FClienteModel : TClienteModel;
    procedure SetCliente(const Value: TClienteModel);
     public
        constructor Create;
        destructor Destroy; override;

        function GetById(id : integer) : String;
        function GetAll : String;
        function Post(obj :String) : String;
        function Put(obj : String) : String;
        function Delete(id : integer)   : boolean; overload;

        function GetByNomeJson(nome : String) : String;
        function GetByEmailJson(email : String) : String;

        Property ClienteModel : TClienteModel read FClienteModel write SetCliente;

   end;
implementation

uses
  System.SysUtils;



{ TClienteResource }

constructor TClienteResource.Create;
begin
  FClienteModel           := TClienteModel.Create;
  FClienteService    := TClienteService.Create;
  FClienteRepository := TClienteRepository.New;
end;

destructor TClienteResource.Destroy;
begin
  FreeAndNil(FClienteService);
  FreeAndNil(FClienteModel);
  inherited;
end;

function TClienteResource.GetById(id: integer): String;
begin
  Result := FClienteService.GetByIdJson(id);
end;


function TClienteResource.GetAll: String;
begin
  Result := FClienteRepository.GetAllJson;
end;


function TClienteResource.Post(obj: String): String;
begin
  Result := FClienteService.Post(obj);
end;


function TClienteResource.Put(obj: String): String;
begin
  Result := FClienteService.Put(obj);
end;

procedure TClienteResource.SetCliente(const Value: TClienteModel);
begin
  FClienteModel := Value;
end;

function TClienteResource.Delete(id: integer): boolean;
begin
  Result := FClienteService.Delete(id);
end;


function TClienteResource.GetByNomeJson(nome: String): String;
begin
  Result := FClienteService.GetByNomeJson(nome);
end;


function TClienteResource.GetByEmailJson(email: String): String;
begin
  Result := FClienteService.GetByEmailJson(email);
end;


end.
