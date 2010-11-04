unit CListaEspera;

{$mode objfpc}{$H+}{$RangeChecks On}

interface
    uses
        CObjectList, Classes, SysUtils, DateUtils;

    type
        { TListaEspera }

        TListaEspera = class (TObjectList)
        private
            { Atributos }
            FFecha        : TDateTime;
        public
            { Constructor }
            constructor Create;

            { Propiedades }
            property Fecha:TDateTime read FFecha write FFecha;

            { Para guardar la fecha }
            procedure LeerDatos (Lector : TReader); override;
            procedure EscribirDatos (Escritor: TWriter); override;
            function CanBeAdded: boolean;
        end;
        
implementation

{ TListaEspera }

constructor TListaEspera.Create;
begin
    inherited Create;
end;

procedure TListaEspera.LeerDatos(Lector: TReader);
begin
    Self.FFecha := Lector.ReadDate;
end;

procedure TListaEspera.EscribirDatos(Escritor: TWriter);
begin
    Escritor.WriteDate(Self.FFecha);
end;

function TListaEspera.CanBeAdded: boolean;
begin
    Result := (CompareDate(Self.Fecha, DateOf(Now)) <> -1)
end;

end.
