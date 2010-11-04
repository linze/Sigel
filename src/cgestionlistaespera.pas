unit CGestionListaEspera;

{$mode objfpc}{$H+}

interface

    uses
        Classes, SysUtils, CEspera, CListaEspera;

    type
        TGestionListaEspera = class (TList)
        protected
            procedure EscribirDatosElemento (Escritor: TWriter;
                                             Indice: Integer);
            procedure LeerDatosElemento (Lector: TReader;
                                        var Objeto: TListaEspera);
        public
            { Para ser usado como lista }
            procedure SaveToStream(Stream: TStream);
            procedure LoadFromStream (Stream: TStream);
            procedure SaveToFile (const FileName: string);
            procedure LoadFromFile (const FileName: string);

            { Para guardar sus propios valores }
            // NOTICE: Hacer override a ambos
            procedure LeerDatos (Lector : TReader); virtual; abstract;
            procedure EscribirDatos (Escritor: TWriter); virtual; abstract;
        end;

implementation

procedure TGestionListaEspera.EscribirDatosElemento(Escritor: TWriter;
    Indice: Integer);
begin
    TListaEspera(Items[Indice]).EscribirDatosLista(Escritor);
end;

procedure TGestionListaEspera.LeerDatosElemento(Lector: TReader;
    var Objeto: TListaEspera);
begin
    Objeto.LeerDatosLista(Lector);
end;

procedure TGestionListaEspera.SaveToStream(Stream: TStream);
var
    Writer : TWriter;
    i : integer;
begin
    Writer := TWriter.Create(Stream, $ffffff);
    try
        // EscribirDatos(Writer);
        Writer.WriteInteger(Self.Count);
        for i:=0 to Count - 1 do
        begin
            EscribirDatosElemento(Writer, i);
        end;
    finally
        Writer.Free;
    end;
end;

procedure TGestionListaEspera.LoadFromStream(Stream: TStream);
var
    Reader : TReader;
    i : integer;
    Objeto : TListaEspera;
    ItemsCount : integer;
begin
    Reader := TReader.Create(Stream, $ffffff);
    try
        // LeerDatos(Reader);
        ItemsCount := Reader.ReadInteger;
        for i:=0 to ItemsCount - 1 do
        begin
            Objeto := TListaEspera.Create;
            try
                LeerDatosElemento(Reader, Objeto);
            except
                Objeto.Free;
                raise;
            end;
            if Objeto.CanBeAdded then
                Add(Objeto);
        end;
    finally
        Reader.Free;
    end;
end;

procedure TGestionListaEspera.SaveToFile(const FileName: string);
var
    FStream: TFileStream;
begin
    FStream := TFileStream.Create(FileName, fmCreate or fmOpenWrite);
    try
        SaveToStream(FStream);
    finally
        FStream.Free;
    end;
end;

procedure TGestionListaEspera.LoadFromFile(const FileName: string);
var
    FStream : TFileStream;
begin
    FStream := TFileStream.Create(FileName, fmOpenRead);
    try
        Clear;
        LoadFromStream (FStream);
    finally
        FStream.Free;
    end;
end;

end.

