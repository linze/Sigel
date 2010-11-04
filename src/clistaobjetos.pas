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
            procedure SaveToStream(Stream: TStream);
            procedure LoadFromStream (Stream: TStream);
            procedure SaveToFile (const FileName: string);
            procedure LoadFromFile (const FileName: string);
        end;
implementation

{ TListaObjetos }

destructor TListaObjetos.Destroy;
begin
    Clear;
    inherited Destroy;
end;

procedure TListaObjetos.Clear;
var
    i : integer;
begin
    for i:=0 to Count - 1 do
    begin
        TObject(Items[i]).Free;
        Delete(0);
    end;
end;

procedure TListaObjetos.SaveToStream(Stream: TStream);
var
    Writer  : TWriter;
    i       : integer;
begin
    Writer := TWriter.Create(Stream, $ff);
    try
        Writer.WriteListBegin;
        for i:=0 to Count - 1 do
        begin
            if TObject(Items[i]) is TPersistent then
            begin
                Writer.WriteString(TPersistent(Items[i]).ClassName);
                if (TPersistent(Items[i]) is TSala) then
                    TSala(Items[i]).EscribirDatos(Writer)
                else if (TPersistent(Items[i]) is TEspera) then
                    TEspera(Items[i]).EscribirDatos(Writer)
                else if (TPersistent(Items[i]) is TReserva) then
                    TReserva(Items[i]).EscribirDatos(Writer)
            end;
        end;
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
    i           : integer;
begin
    Reader  := TReader.Create(Stream, $ff);
    try
        Reader.ReadListBegin;
        while not Reader.EndOfList do
        begin
            NombreClase := Reader.ReadString;
            TipoClase := GetClass(NombreClase);
            if Assigned (TipoClase) then
            begin
                if TPersistent(TipoClase) is TSala then
                    Objeto := TSala.Create
                else if TPersistent(TipoClase) is TReserva then
                    Objeto := TReserva.Create
                else if TPersistent(TipoClase) is TEspera then
                    Objeto := TEspera.Create
                else
                    Objeto := TipoClase.Create;
                try
                    if Objeto is TSala then
                        TSala(Objeto).LeerDatos(Reader)
                    else if Objeto is TReserva then
                        TReserva(Objeto).LeerDatos(Reader)
                    else if Objeto is TEspera then
                        TEspera(Objeto).LeerDatos(Reader);
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

procedure TListaObjetos.SaveToFile(const FileName: string);
var
    FStream:  TFileStream;
begin
    FStream := TFileStream.Create(FileName, fmCreate or fmOpenWrite);
    try
        SaveToStream(FStream);
    finally
        FStream.Free;
    end;
end;

procedure TListaObjetos.LoadFromFile(const FileName: string);
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
