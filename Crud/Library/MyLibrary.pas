unit MyLibrary;

interface

uses
  System.JSON,
  REST.Response.Adapter,
  System.SysUtils,
  Datasnap.DBClient;

type
   TMyLibrary = class
     public
        class function JsonToDataset(aJSON: string): TClientDataSet;

   end;
implementation


class function TMyLibrary.JsonToDataset(aJSON: string): TClientDataSet;
var
  JObj: TJSONArray;
  vConv : TCustomJSONDataSetAdapter;
  aDataset : TClientDataSet;
begin
  if (aJSON = EmptyStr) then
  begin
    Result := NIL;
    Exit;
  end;

  JObj  := TJSONObject.ParseJSONValue(aJSON) as TJSONArray;
  vConv := TCustomJSONDataSetAdapter.Create(Nil);

  try
    aDataset      := TClientDataSet.Create(nil);
    vConv.Dataset := aDataset;
    // faz o parse para dataset
    vConv.UpdateDataSet(JObj);
    Result        := aDataset;
  finally
    vConv.Free;
    JObj.Free;
  end;
end;
end.
