unit CEspera;

{$mode objfpc}{$H+}

interface

    uses
        CLocalidad, CTipoLocalidad, Classes;

    type
        { TEspera }
        TEspera = class
        private
        (*Atributos*)
            FNombre        : String;
            FTelefono      : String;
            FEmail         : String;
            FNumero        : Integer;
            FTipoLocalidad : TTipoLocalidad;
        public
            { Constructor}
            constructor Create;
			
            { Propiedades }
            property Nombre:String read FNombre write FNombre;
            property Telefono:String read FTelefono write FTelefono;
            property Email: String read FEmail write FEmail;
            property Numero: Integer read FNumero write FNumero;
            property TipoLocalidad: TTipoLocalidad read FTipoLocalidad write FTipoLocalidad;

            { Para guardar-extraer desde ficheros }
            procedure LeerDatos (Lector : TReader);
            procedure EscribirDatos (Escritor: TWriter);
        end;
			
implementation

{ TEspera }

constructor TEspera.Create;
begin
	// TODO: Hacer
end;

procedure TEspera.LeerDatos(Lector: TReader);
begin
    Self.FNombre := Lector.ReadString;
    Self.FTelefono := Lector.ReadString;
    Self.FEmail := Lector.ReadString;
    Self.FNumero := Lector.ReadInteger;
    // NOTICE: Comprobar si este tipo de casting funciona
    Self.FTipoLocalidad := TTipoLocalidad(Lector.ReadInteger);
end;

procedure TEspera.EscribirDatos(Escritor: TWriter);
begin
    Escritor.WriteString(Self.FNombre);
    Escritor.WriteString(Self.FTelefono);
    Escritor.WriteString(Self.FEmail);
    Escritor.WriteInteger(Self.FNumero);
    Escritor.WriteInteger(ord(Self.FTipoLocalidad));
end;



end.
