unit IRepository;

interface

uses
  System.Classes,
  System.Generics.Collections,
  Data.DB;

type
   IRepository<T : class> = Interface
   ['{F0DC47FF-7AF5-43D7-915A-CD1F37213D87}']
      function GetById(id : integer) : T;
      function GetByIdJson(id : integer)   : String;

      function GetAll : TObjectList<T>;
      function GetAllJson     : String;

      function Post(obj : T)          : T;     overload;
      function Post(json : String) : String;    overload;

      function Put(obj : T)          : T;      overload;
      function Put(json : String) : String;     overload;

      function Delete(id : integer) : boolean; overload;
      function Delete(obj : T)      : boolean; overload;
   End;
implementation

end.
