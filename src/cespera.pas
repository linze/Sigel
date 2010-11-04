unit CEspera;

{$mode objfpc}{$H+}

interface

    uses
        CTipoLocalidad, Classes;

    type
        { TEspera }
        TEspera = class (TPersistent)
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
            procedure LeerDatos (Lector : TReader); dynamic;
            procedure EscribirDatos (Escritor: TWriter); dynamic;
        end;
			
implementation

{ TEspera }

constructor TEspera.Create;
begin
	inherited Create;
end;

procedure TEspera.LeerDatos(Lector: TReader);
begin
    Self.FNombre := Lector.ReadString;
    Self.FTelefono := Lector.ReadString;
    Self.FEmail := Lector.ReadString;
    Self.FNumero := Lector.ReadInteger;
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

initialization
    RegisterClass (TEspera);



end.
