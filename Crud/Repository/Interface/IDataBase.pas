unit IDataBase;

interface

uses
  System.Generics.Collections,
  System.SysUtils,
  System.Classes,
  Data.DB;

type
   IConnection = Interface
   ['{9DD56595-7E43-4D67-856F-0A1E9E9CB54A}']
      function GetConnection : TCustomConnection;
      function StarTransaction  : IConnection;
      function Commit : IConnection;
      function RollBack : IConnection;
   End;

   IQuery = Interface
   ['{C0A84993-01EE-4AE4-8FA0-712B47C4AA2E}']
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

    End;

   IFactoryConnection = Interface
   ['{836E65DF-1CF4-4590-956D-7C59AFB0EA8C}']
      function GetConnection : IConnection;

   End;
   IFactoryQuery = Interface
   ['{487C2E36-C33A-4D60-88C6-56C029D9B858}']
     function Query : Iquery;

   End;

implementation

end.
