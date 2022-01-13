unit ClienteModel;

interface

type
   TClienteModel = class
  private
    Fid: Integer;
    FNome: String;
    FEmail: String;
    FIdade: Integer;

    procedure SetEmail(const Value: String);
    procedure Setid(const Value: Integer);
    procedure SetIdade(const Value: Integer);
    procedure SetNome(const Value: String);

  Public
     constructor Create(const id:integer; const nome, email : string; const idade: integer); overload;
     property id : Integer read Fid write Setid;
     property Nome : String read FNome write SetNome;
     property Email : String read FEmail write SetEmail;
     property Idade : Integer read FIdade write SetIdade;

   end;
implementation

{ TClienteModel }


{ TClienteModel }

constructor TClienteModel.Create(const id: integer; const nome, email: string;
  const idade: integer);
begin
  Fid    := id;
  FNome  := nome;
  FEmail := email;
  FIdade := idade;
end;

procedure TClienteModel.SetEmail(const Value: String);
begin
  FEmail := Value;
end;

procedure TClienteModel.Setid(const Value: Integer);
begin
  Fid := Value;
end;

procedure TClienteModel.SetIdade(const Value: Integer);
begin
  FIdade := Value;
end;

procedure TClienteModel.SetNome(const Value: String);
begin
  FNome := Value;
end;

end.
