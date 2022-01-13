unit IClienteRepository;

interface

uses
  System.Classes,
  System.Generics.Collections,
  IRepository,
  Data.DB;

type
   IClienteRepository<T : class>   = Interface (IRepository<T>)
   ['{0A6978DE-96A9-4033-B8F6-D92D34A90237}']
      function GetByNome(nome : String) : TObjectList<T>;
      function GetByNomeJson(nome : String) : String;

      function GetByEmail(email : String) : T;
      function GetByEmailJson(email : String)   : String;


   end;

implementation


end.
