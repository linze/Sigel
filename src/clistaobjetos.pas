unit CListaObjetos;

{$mode objfpc}{$H+}

interface

    uses
      Classes, SysUtils, CSala, CReserva, CEspera;
    type

        { TListaObjetos }

        TListaObjetos = class (TList)
        public
            destructor Destroy; override;
            procedure Clear;

            { Para guardar y cargar desde un stream }
            procedure SaveToStream(Stream: TStream);
            procedure LoadFromStream (Stream: TStream);

            { Para guardar y escribir en un fichero }
            procedure SaveToFile (const FileName: string);
            procedure LoadFromFile (const FileName: string);
        end;
implementation

{ TListaObjetos }

destructor TListaObjetos.Destroy;
begin
    // Limpiamos la lista antes de destruir el objeto
    Clear;
    inherited Destroy;
end;

procedure TListaObjetos.Clear;
var
    i : integer;
begin
    // Libera cada uno de los objetos y los elimina de la lista
    for i:=0 to Count - 1 do
    begin
        TObject(Items[i]).Free;
        Delete(i);
    end;
end;

procedure TListaObjetos.SaveToStream(Stream: TStream);
var
    Writer  : TWriter;
    i       : integer;
begin
    // Creamos un TWriter para poder escribir en el stream pasado
    // por argumentos.
    Writer := TWriter.Create(Stream, $ffffff);
    try
        // Insertamos el inicio de lista
        Writer.WriteListBegin;
        // Para cada uno de los elementos en la lista...
        for i:=0 to Count - 1 do
        begin
            // Llama al procedimiento de escribir los datos de cada
            // clase que puede ser contenida en la lista.
            if TObject(Items[i]) is TPersistent then
            begin
                // Escribimos el tipo de objeto
                Writer.WriteString(TPersistent(Items[i]).ClassName);
                // Llamamos a su escritor
                if TPersistent(Items[i]).ClassType = TSala then
                    TSala(Items[i]).EscribirDatos(Writer)
                else if TPersistent(Items[i]).ClassType = TEspera then
                    TEspera(Items[i]).EscribirDatos(Writer)
                else if TPersistent(Items[i]).ClassType = TReserva then
                    TReserva(Items[i]).EscribirDatos(Writer)
            end;
        end;
        // Escribimos el fin de lista
        Writer.WriteListEnd;
    finally
        Writer.Free;
    end;
end;

procedure TListaObjetos.LoadFromStream(Stream: TStream);
var
    Reader      :  TReader;
    Objeto      : TPersistent;
    TipoClase   : TPersistentClass;
    NombreClase : string;
begin
    // Creamos un TReader para leer desde el Stream
    Reader  := TReader.Create(Stream, $ffffff);
    try
        // Leemos el comienzo de lista
        Reader.ReadListBegin;
        // Mientras que no llegue al final de la lista...
        while not Reader.EndOfList do
        begin
            // Se obtiene el nombre de la clase
            NombreClase := Reader.ReadString;
            // Transformamos el nombre en un tipo de clase
            TipoClase := GetClass(NombreClase);
            // Si está asignada... (Se ha realizado un RegisterClass sobre
            // esa clase)
            if Assigned (TipoClase) then
            begin
                // Construimos la clase
                if TipoClase = TSala then
                    Objeto := TSala.Create
                else if TipoClase = TReserva then
                    Objeto := TReserva.Create
                else if TipoClase = TEspera then
                    Objeto := TEspera.Create
                else
                    Objeto := TipoClase.Create;
                // Invocamos el procedimiento de lectura de cada clase
                try
                    if TipoClase = TSala then
                        TSala(Objeto).LeerDatos(Reader)
                    else if TipoClase = TReserva then
                        TReserva(Objeto).LeerDatos(Reader)
                    else if TipoClase = TEspera then
                        TEspera(Objeto).LeerDatos(Reader);
                except
                    Objeto.Free;
                    raise;
                end;
                // Añadimos el objeto a la lista
                Self.Add(Objeto);
            end;
        end;
        // Leemos el final de la lista
        Reader.ReadListEnd;
    finally
    end;
end;

procedure TListaObjetos.SaveToFile(const FileName: string);
var
    FStream:  TFileStream;
begin
    // Abrimos el fichero en un stream en modo creación o escritura
    FStream := TFileStream.Create(FileName, fmCreate or fmOpenWrite);
    try
        // Guardamos el contenido en el stream del fichero
        SaveToStream(FStream);
    finally
        FStream.Free;
    end;
end;

procedure TListaObjetos.LoadFromFile(const FileName: string);
var
    FStream : TFileStream;
begin
    // Abrimos un fichero en un stream en modo lectura
    FStream := TFileStream.Create(FileName, fmOpenRead);
    try
        // Limpiamos el posible contenido de la lista
        Clear;
        // Cargamos el stream del fichero
        LoadFromStream (FStream);
    finally
        FStream.Free;
    end;
end;

end.
