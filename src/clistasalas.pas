unit CListaSalas;

{$mode objfpc}{$H+}

interface
    uses
        CObjectList, Classes, CSala;

    type

        { TListaSalas }
        TListaSalas = class (TObjectList)
        private
        public
            function BuscarSala(Fecha : TDateTime): TSala;
            { Para guardar la fecha }
            procedure LeerDatos (Lector : TReader); override;
            procedure EscribirDatos (Escritor: TWriter); override;
        end;

implementation

{ TListaSalas }

function TListaSalas.BuscarSala(Fecha: TDateTime): TSala;
var
    Found : boolean;
    i : integer;
begin
    Found := False;
    i := 0;
    while not (Found) and (i < Self.Count - 1 )  do
    begin
        if TSala(Self.Items[i]).Fecha = Fecha then
            Found := True
        else
            i := i + 1;
    end;

    if Found then
        Result := TSala(Self.Items[i])
    else
        Result := nil;
end;

procedure TListaSalas.LeerDatos(Lector: TReader);
begin
    //
end;

procedure TListaSalas.EscribirDatos(Escritor: TWriter);
begin
    //
end;

end.

