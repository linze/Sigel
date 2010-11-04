unit CGestionListaReserva;

{$mode objfpc}{$H+}

interface

    uses
        Classes, SysUtils, CReserva, CListaReservas;

    type
        TGestionListaReserva = class (TList)
        protected
            procedure EscribirDatosElemento (Escritor: TWriter;
                                             Indice: Integer);
            procedure LeerDatosElemento (Lector: TReader;
                                        var Objeto: TListaReservas);
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

procedure TGestionListaReserva.EscribirDatosElemento(Escritor: TWriter;
    Indice: Integer);
begin
    TListaReservas(Items[Indice]).EscribirDatosLista(Escritor);
end;

procedure TGestionListaReserva.LeerDatosElemento(Lector: TReader;
    var Objeto: TListaReservas);
begin
    Objeto.LeerDatosLista(Lector);
end;

procedure TGestionListaReserva.SaveToStream(Stream: TStream);
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

procedure TGestionListaReserva.LoadFromStream(Stream: TStream);
var
    Reader : TReader;
    i : integer;
    Objeto : TListaReservas;
    ItemsCount : integer;
begin
    Reader := TReader.Create(Stream, $ffffff);
    try
        // LeerDatos(Reader);
        ItemsCount := Reader.ReadInteger;
        for i:=0 to ItemsCount - 1 do
        begin
            Objeto := TListaReservas.Create;
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

procedure TGestionListaReserva.SaveToFile(const FileName: string);
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

procedure TGestionListaReserva.LoadFromFile(const FileName: string);
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

