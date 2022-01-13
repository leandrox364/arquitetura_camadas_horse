program Crud;

uses
  Vcl.Forms,
  IRepository in 'Repository\Interface\IRepository.pas',
  IClienteRepository in 'Repository\Interface\IClienteRepository.pas',
  ClienteModel in 'Model\ClienteModel.pas',
  ClienteRepository in 'Repository\ClienteRepository.pas',
  IDataBase in 'Repository\Interface\IDataBase.pas',
  FireDacConnction in 'Repository\FireDacConnction.pas',
  FireDacQuery in 'Repository\FireDacQuery.pas',
  Main in 'View\Main.pas' {FrmMain},
  ClienteService in 'Service\ClienteService.pas',
  ClienteResource in 'Resource\ClienteResource.pas',
  FactoryQuery in 'Repository\FactoryQuery.pas',
  FactoryConnection in 'Repository\FactoryConnection.pas',
  MyLibrary in 'Library\MyLibrary.pas',
  Horse.Commons in 'horse-master\src\Horse.Commons.pas',
  Horse.Constants in 'horse-master\src\Horse.Constants.pas',
  Horse.Core.Group.Contract in 'horse-master\src\Horse.Core.Group.Contract.pas',
  Horse.Core.Group in 'horse-master\src\Horse.Core.Group.pas',
  Horse.Core.Param.Header in 'horse-master\src\Horse.Core.Param.Header.pas',
  Horse.Core.Param in 'horse-master\src\Horse.Core.Param.pas',
  Horse.Core in 'horse-master\src\Horse.Core.pas',
  Horse.Core.Route.Contract in 'horse-master\src\Horse.Core.Route.Contract.pas',
  Horse.Core.Route in 'horse-master\src\Horse.Core.Route.pas',
  Horse.Core.RouterTree in 'horse-master\src\Horse.Core.RouterTree.pas',
  Horse.Exception in 'horse-master\src\Horse.Exception.pas',
  Horse.HTTP in 'horse-master\src\Horse.HTTP.pas',
  Horse in 'horse-master\src\Horse.pas',
  Horse.Proc in 'horse-master\src\Horse.Proc.pas',
  Horse.Provider.Abstract in 'horse-master\src\Horse.Provider.Abstract.pas',
  Horse.Provider.Apache in 'horse-master\src\Horse.Provider.Apache.pas',
  Horse.Provider.CGI in 'horse-master\src\Horse.Provider.CGI.pas',
  Horse.Provider.Console in 'horse-master\src\Horse.Provider.Console.pas',
  Horse.Provider.Daemon in 'horse-master\src\Horse.Provider.Daemon.pas',
  Horse.Provider.FPC.Apache in 'horse-master\src\Horse.Provider.FPC.Apache.pas',
  Horse.Provider.FPC.CGI in 'horse-master\src\Horse.Provider.FPC.CGI.pas',
  Horse.Provider.FPC.Daemon in 'horse-master\src\Horse.Provider.FPC.Daemon.pas',
  Horse.Provider.FPC.FastCGI in 'horse-master\src\Horse.Provider.FPC.FastCGI.pas',
  Horse.Provider.FPC.HTTPApplication in 'horse-master\src\Horse.Provider.FPC.HTTPApplication.pas',
  Horse.Provider.IOHandleSSL in 'horse-master\src\Horse.Provider.IOHandleSSL.pas',
  Horse.Provider.ISAPI in 'horse-master\src\Horse.Provider.ISAPI.pas',
  Horse.Provider.VCL in 'horse-master\src\Horse.Provider.VCL.pas',
  Horse.Rtti in 'horse-master\src\Horse.Rtti.pas',
  Horse.WebModule in 'horse-master\src\Horse.WebModule.pas' {HorseWebModule: TWebModule},
  ThirdParty.Posix.Syslog in 'horse-master\src\ThirdParty.Posix.Syslog.pas',
  Web.WebConst in 'horse-master\src\Web.WebConst.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown := true;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
