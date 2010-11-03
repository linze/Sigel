unit CObjectList;

{$mode objfpc}{$H+}

interface

    uses
      Classes, SysUtils, CObjectListItem;

    type

        { TObjectList }

        TObjectList = class (TList)
        protected
            // Para trabajar los datos de cada elemento de la lista
            // NOTICE: Hacer override a ambos
            procedure EscribirDatosElemento (Escritor: TWriter;
                                             Indice: Integer);
            procedure LeerDatosElemento (Lector: TReader;
                                        var Objeto: TPersistent;
                                        Clase: TPersistentClass);
        public
            destructor Destroy; override;
            procedure Clear;

            { Para ser usado como lista }
            procedure SaveToStream(Stream: TStream);
            procedure LoadFromStream (Stream: TStream);
            procedure SaveToFile (const FileName: string);
            procedure LoadFromFile (const FileName: string);

            { Para guardar sus propios valores }
            // NOTICE: Hacer override a ambos
            procedure LeerDatos (Lector : TReader);
            procedure EscribirDatos (Escritor: TWriter);
        end;

implementation

{ TObjectList }

procedure TObjectList.EscribirDatosElemento(Escritor: TWriter;
    Indice: Integer);
begin
    // NOTICE: Invocará a EscribirDatos de Items[i]
    TObjectListItem(Items[Indice]).EscribirDatos(Escritor);
end;

procedure TObjectList.LeerDatosElemento(Lector: TReader;
    var Objeto: TPersistent; Clase: TPersistentClass);
begin
    // NOTICE: Invocará a Clase(Objeto).LeerDatos(Lector)
    TObjectListItem(Objeto).LeerDatos(Lector);
end;

destructor TObjectList.Destroy;
begin
    Clear;
    inherited Destroy;
end;

procedure TObjectList.Clear;
var
    i : integer;
begin
    for i:=0 to Count - 1 do
    begin
        TObject(Items[i]).Free;
        Delete(0);
    end;
end;

procedure TObjectList.SaveToStream(Stream: TStream);
var
    Writer : TWriter;
    i : integer;
begin
    Writer := TWriter.Create(Stream, $ff);
    try
        EscribirDatos(Writer);
        Writer.WriteInteger(Count);
        Writer.WriteListBegin;
        for i:=0 to Count - 1 do
        begin
            if TObject(Items[i]) is TPersistent then
            begin
                Writer.WriteString(TPersistent(Items[i]).ClassName);
                EscribirDatosElemento(Writer, i);
            end;
        end;
        Writer.WriteListEnd;
    finally
        Writer.Free;
    end;
end;

procedure TObjectList.LoadFromStream(Stream: TStream);
var
    Reader : TReader;
    Objeto : TPersistent;
    TipoClase : TPersistentClass;
    NombreClase : string;
    i : integer;
    ItemsCount : integer;
begin
    Reader := TReader.Create(Stream, $ff);
    try
        LeerDatos(Reader);
        ItemsCount := Reader.ReadInteger;
        Reader.ReadListBegin;
        for i:=0 to ItemsCount - 1 do
        begin
            NombreClase := Reader.ReadString;
            TipoClase := GetClass(NombreClase);
            if Assigned (TipoClase) then
            begin
                Objeto := TipoClase.Create;
                try
                    LeerDatosElemento(Reader, Objeto, TipoClase);
                except
                    Objeto.Free;
                    raise;
                end;
                Add(Objeto);
            end;
        end;
        Reader.ReadListEnd;
    finally
    end;
end;

procedure TObjectList.SaveToFile(const FileName: string);
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

procedure TObjectList.LoadFromFile(const FileName: string);
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

procedure TObjectList.LeerDatos(Lector: TReader);
begin
    // TODO: Leer datos de la lista
end;

procedure TObjectList.EscribirDatos(Escritor: TWriter);
begin
    // TODO: Guardar datos de la lista
end;


end.

