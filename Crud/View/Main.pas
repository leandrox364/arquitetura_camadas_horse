unit Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ExtCtrls,
  Data.DB,
  ClienteResource,
  Datasnap.DBClient ;

type
  TFrmMain = class(TForm)
    DBGridDados: TDBGrid;
    DtsDados: TDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    EdtId: TEdit;
    EdtNome: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    EdtEmail: TEdit;
    Label4: TLabel;
    EdtIdade: TEdit;
    Panel2: TPanel;
    BtnGetId: TButton;
    BtnGetAll: TButton;
    BtnPost: TButton;
    BtnPut: TButton;
    BtnDeleteId: TButton;
    BtnGetNome: TButton;
    BtnGetEmail: TButton;
    Button1: TButton;
    Button2: TButton;
    Memo: TMemo;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnGetIdClick(Sender: TObject);
    procedure BtnGetAllClick(Sender: TObject);
    procedure BtnPostClick(Sender: TObject);
    procedure BtnPutClick(Sender: TObject);
    procedure BtnDeleteIdClick(Sender: TObject);
    procedure BtnGetNomeClick(Sender: TObject);
    procedure BtnGetEmailClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGridDadosDblClick(Sender: TObject);
    procedure DBGridDadosCellClick(Column: TColumn);
    procedure Button3Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    FClienteResource : TClienteResource;
    ListaClientes : TClientDataSet;
    procedure FormatGrid;
    procedure ExibirDados;

  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  MyLibrary , Horse;

{$R *.dfm}

procedure TFrmMain.FormatGrid;
var
  i: Integer;
begin
  for I := 0 to DBGridDados.Columns.Count - 1 do
      DBGridDados.Columns[i].Width := 150;
end;

procedure TFrmMain.ExibirDados;
begin
  EdtId.Text    := ListaClientes.FieldByName('id').AsString;
  EdtNome.Text  := ListaClientes.FieldByName('nome').AsString;
  EdtEmail.Text := ListaClientes.FieldByName('email').AsString;
  EdtIdade.Text := ListaClientes.FieldByName('idade').AsString;
end;
procedure TFrmMain.BtnGetIdClick(Sender: TObject);
begin
  Memo.Lines.Clear;
  Memo.Lines.Add(  FClienteResource.GetById( StrToInt(EdtID.Text) ));

  if Assigned(ListaClientes) then
     FreeAndNil(ListaClientes);

  ListaClientes    := TMyLibrary.JsonToDataset('['+FClienteResource.GetById( StrToInt(EdtID.Text) )+']');
  DtsDados.DataSet := ListaClientes;

  FormatGrid;
end;

procedure TFrmMain.BtnGetAllClick(Sender: TObject);
begin
  Memo.Lines.Clear;
  Memo.Lines.Add(FClienteResource.GetAll);

  if Assigned(ListaClientes) then
     FreeAndNil(ListaClientes);

  ListaClientes    := TMyLibrary.JsonToDataset(FClienteResource.GetAll);

  DtsDados.DataSet :=  ListaClientes;

  FormatGrid;
end;

procedure TFrmMain.BtnPostClick(Sender: TObject);
var
  vJson : string;
begin
  vJson :=
  '{'+
  '"nome" : "' + EdtNome.Text  +'", ' +
  '"email" : "'+ edtemail.Text +'", ' +
  '"idade" : ' + edtidade.Text +
  '}' ;

  Memo.Lines.Clear;
  Memo.Lines.Add( FClienteResource.Post(vJson) );


end;

procedure TFrmMain.BtnPutClick(Sender: TObject);
var
  vJson : string;
begin
  vJson :=
  '{'+
  '"id" : '     + EdtId.Text    +', '  +
  '"nome" : "'  + EdtNome.Text  +'", ' +
  '"email" : "' + edtemail.Text +'", ' +
  '"idade" : '  + edtidade.Text +
  '}' ;

  Memo.Lines.Clear;
  Memo.Lines.Add( FClienteResource.Put(vJson) );

end;


procedure TFrmMain.Button1Click(Sender: TObject);
begin
  EdtId.Text    := '0';
  EdtNome.Text  := 'Leandro dos Santos Silva';
  EdtEmail.Text := 'leandrox364@gmail.com';
  EdtIdade.Text := '38';
end;

procedure TFrmMain.Button2Click(Sender: TObject);
begin
  EdtId.Text    := '';
  EdtNome.Text  := '';
  EdtEmail.Text := '';
  EdtId.Text    := '';
end;

procedure TFrmMain.Button3Click(Sender: TObject);
begin
  FormatGrid;
end;

procedure TFrmMain.DBGridDadosCellClick(Column: TColumn);
begin
  ExibirDados;
end;

procedure TFrmMain.DBGridDadosDblClick(Sender: TObject);
begin
  ExibirDados;
end;

procedure TFrmMain.BtnDeleteIdClick(Sender: TObject);
begin
  if FClienteResource.Delete(StrtoInt(EdtId.Text)) then
     Memo.Lines.Add('Cliente Deletado id: '+EdtId.Text);
end;

procedure TFrmMain.BtnGetNomeClick(Sender: TObject);
begin
  Memo.Lines.Clear;
  Memo.Lines.Add(FClienteResource.GetByNomeJson(EdtNome.Text));

  if Assigned(ListaClientes) then
     FreeAndNil(ListaClientes);

  ListaClientes    :=  TMyLibrary.JsonToDataset( FClienteResource.GetByNomeJson(EdtNome.Text));
  DtsDados.DataSet :=  ListaClientes;

  FormatGrid;
end;

procedure TFrmMain.BtnGetEmailClick(Sender: TObject);
begin
  Memo.Lines.Clear;
  Memo.Lines.Add(FClienteResource.GetByEmailJson(EdtEmail.Text));

  if Assigned(ListaClientes) then
     FreeAndNil(ListaClientes);

  ListaClientes    := TMyLibrary.JsonToDataset('['+FClienteResource.GetByEmailJson(EdtEmail.Text)+']');
  DtsDados.DataSet :=  ListaClientes;

  FormatGrid;
end;


procedure TFrmMain.FormCreate(Sender: TObject);
begin
  FClienteResource := TClienteResource.Create;


  THorse.Get('/cliente',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.ContentType('application/json');

      if req.Query.Count > 0 then
      begin

      if req.Query.ContainsKey('nome') then
         Res.Send(
         FClienteResource
         .GetByNomeJson( req.Query.Items['nome'] )
                 )
      else
      if req.Query.ContainsKey('email') then
         Res.Send(
         FClienteResource
         .GetByEmailJson( req.Query.Items['email'] )
                 );
      end
      else
         Res.Send(FClienteResource.GetAll);

    end);

  THorse.Get('/cliente/:id',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.ContentType('application/json');
      Res.Send(FClienteResource.GetById(req.Params['id'].ToInt64));
    end);

  THorse.Post('/cliente',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.ContentType('application/json');
      Res.Send(FClienteResource.Post(req.Body));
    end);

  THorse.Put('/cliente',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.ContentType('application/json');
      Res.Send(FClienteResource.Put(req.Body));
    end);

  THorse.Delete('/cliente/:id',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.ContentType('application/json');
      if FClienteResource.Delete(req.Params['id'].ToInt64) then
         Res.Send('Cliente deletado id = '+ req.Params['id'].ToUpper)
      else
         Res.Send('Não foi possivel deletar o cliente');


    end);


  THorse.Listen(9000);


end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(ListaClientes) then
  begin
    ListaClientes.Close;
    FreeAndNil(ListaClientes);
  end;
  FreeAndNil(FClienteResource);

end;

procedure TFrmMain.FormResize(Sender: TObject);
begin
  Memo.Height := Trunc(self.Height / 2)-100;
end;

end.
