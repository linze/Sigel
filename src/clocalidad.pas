unit CLocalidad;

{$mode objfpc}{$H+}

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
            procedure LeerDatos (Lector : TReader);
            procedure EscribirDatos (Escritor: TWriter);
        end;


implementation

{ TLocalidad }

constructor TLocalidad.Create;
begin
    // TODO: Evaluar si es necesario e implementar
end;

function TLocalidad.EstaOcupado : boolean;
begin
    EstaOcupado := (Self.FEstado <> Libre);
end;

procedure TLocalidad.LeerDatos(Lector: TReader);
begin
    // NOTICE: Desconozco si ReadValue es lo correcto. Si
    // hay conflictos, usar IntVar := Ord (MyEnumVal);
    Self.FTipo := TTipoLocalidad(Lector.ReadInteger);
    Self.FEstado := TEstadoLocalidad(Lector.ReadInteger);
    Self.FNumero := Lector.ReadInteger;
    Self.FFila := Lector.ReadInteger;
end;

procedure TLocalidad.EscribirDatos(Escritor: TWriter);
begin
    Escritor.WriteInteger(ord(Self.FTipo));
    Escritor.WriteInteger(ord(Self.FEstado));
    Escritor.WriteInteger(Self.FNumero);
    Escritor.WriteInteger(Self.FFila);
end;

end.

