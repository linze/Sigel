unit CListaEspera;

{$mode objfpc}{$H+}

interface
    uses
        CObjectList, Classes;

    type

        { TListaEspera }

        TListaEspera = class (TObjectList)
        private
            { Atributos }
            FFecha        : TDateTime;
        public
            { Propiedades }
            property Fecha:TDateTime read FFecha write FFecha;

            { Para guardar la fecha }
            procedure LeerDatos (Lector : TReader); override;
            procedure EscribirDatos (Escritor: TWriter); override;
        end;
        
implementation

{ TListaEspera }

procedure TListaEspera.LeerDatos(Lector: TReader);
begin
    Self.FFecha := Lector.ReadDate;
end;

procedure TListaEspera.EscribirDatos(Escritor: TWriter);
begin
    Escritor.WriteDate(Self.FFecha);
end;

end.
