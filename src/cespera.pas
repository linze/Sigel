{    This file is part of Sigel.

    Sigel is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Sigel is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Sigel.  If not, see <http://www.gnu.org/licenses/>. }
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
            // Indica si se le han asignado localidades o no
            FAsignada: boolean;
            // Contiene las localidades que le han sido asignadas
            FLocalidadesAsignadas: String;
        public
            { Constructor}
            constructor Create;
			
            { Propiedades }
            property Nombre:String read FNombre write FNombre;
            property Telefono:String read FTelefono write FTelefono;
            property Email: String read FEmail write FEmail;
            property Numero: Integer read FNumero write FNumero;
            property TipoLocalidad: TTipoLocalidad read FTipoLocalidad write FTipoLocalidad;

            property Asignada: boolean read FAsignada write FAsignada;
            property LocalidadesAsignadas : String read FLocalidadesAsignadas write FLocalidadesAsignadas;

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
    // Lee los datos del TEspera desde un stream
    Self.FNombre := Lector.ReadString;
    Self.FTelefono := Lector.ReadString;
    Self.FEmail := Lector.ReadString;
    Self.FNumero := Lector.ReadInteger;
    Self.FTipoLocalidad := TTipoLocalidad(Lector.ReadInteger);
    Self.FAsignada := Lector.ReadBoolean;
    Self.FLocalidadesAsignadas := Lector.ReadString;
end;

procedure TEspera.EscribirDatos(Escritor: TWriter);
begin
    // Escribe los datos del TEspera en un stream
    Escritor.WriteString(Self.FNombre);
    Escritor.WriteString(Self.FTelefono);
    Escritor.WriteString(Self.FEmail);
    Escritor.WriteInteger(Self.FNumero);
    Escritor.WriteInteger(ord(Self.FTipoLocalidad));
    Escritor.WriteBoolean(Self.FAsignada);
    Escritor.WriteString(Self.FLocalidadesAsignadas);
end;

initialization
    RegisterClass (TEspera);



end.
