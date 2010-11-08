unit CLocalidad;

{$mode objfpc}{$H+}{$RangeChecks On}

interface
    uses
        CTipoLocalidad, CEstadoLocalidad, Classes;
    type
        { TLocalidad }
        TLocalidad = class
        private
            { Atributos }
            FTipo       : TTipoLocalidad;
            FEstado     : TEstadoLocalidad;
            FNumero     : integer;
            FFila       : integer;
        public
            { Constructores y destructores }
            constructor Create;

            { Propiedades }
            property Tipo : TTipoLocalidad read FTipo write FTipo;
            property Estado : TEstadoLocalidad read FEstado write FEstado;
            property Numero : integer read FNumero write FNumero;
            property Fila : integer read FFila write FFila;

            { Operaciones propias de la clase }
            function EstaOcupado: boolean;

            { Para guardar-extraer desde ficheros }
            procedure LeerDatos (Lector : TReader); dynamic;
            procedure EscribirDatos (Escritor: TWriter); dynamic;
        end;


implementation

{ TLocalidad }

constructor TLocalidad.Create;
begin
    inherited Create;
end;

function TLocalidad.EstaOcupado : boolean;
begin
    EstaOcupado := (Self.FEstado <> Libre);
end;

procedure TLocalidad.LeerDatos(Lector: TReader);
begin
    // Lee los datos de la localidad desde un stream
    Self.FTipo := TTipoLocalidad(Lector.ReadInteger);
    Self.FEstado := TEstadoLocalidad(Lector.ReadInteger);
    Self.FNumero := Lector.ReadInteger;
    Self.FFila := Lector.ReadInteger;
end;

procedure TLocalidad.EscribirDatos(Escritor: TWriter);
begin
    // Escribe los datos de la localidad en un stream
    Escritor.WriteInteger(ord(Self.FTipo));
    Escritor.WriteInteger(ord(Self.FEstado));
    Escritor.WriteInteger(Self.FNumero);
    Escritor.WriteInteger(Self.FFila);
end;

end.

