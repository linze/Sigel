unit CEspera;

{$mode objfpc}{$H+}

interface

    uses
        CLocalidad, CTipoLocalidad;

    type
        { PTEspera }
        PTEspera = ^TEspera;

        { TEspera }

        TNumero = 1..4;
        TEspera = class
        private
        (*Atributos*)
            FNombre        : String;
            FTelefono      : longint;
            FEmail         : String;
            FNumero        : TNumero;
            FTipoLocalidad : TTipoLocalidad;
            FSiguiente     : PTEspera;
        public
            (*Constructor*)
            Constructor Create();
			
            (* Métodos Set *)
            procedure SetNombre (Nombre: String);
            procedure SetTelefono (Telefono: longint);
            procedure SetEmail (Email: String);
            procedure SetNumero (numero: TNumero);
            procedure SetTipoLocalidad (TipoLocalidad: TTipoLocalidad);
            procedure SetSiguiente (Siguiente: PTEspera);

            (* Métodos Get *)
            function GetNombre: String;
            function GetTelefono: longint;
            function GetEmail: String;
            function GetNumero: TNumero;
            // TODO: Verificar que una función puede devolver estos tipos
            function GetTipoLocalidad: TTipoLocalidad;
            function GetSiguiente: PTEspera;
        end;
			
implementation

{ TEspera }

constructor TEspera.Create;
begin
	// TODO: Hacer
end;

procedure TEspera.SetNombre (Nombre: String);
begin
	Self.FNombre := Nombre;
end;

procedure TEspera.SetTelefono (Telefono: longint);
begin
	Self.FTelefono := Telefono;
end;

procedure TEspera.SetEmail (Email: String);
begin
	Self.FEmail := Email;
end;

procedure TEspera.SetNumero (numero: TNumero);
begin
	Self.FNumero := numero;
end;

procedure TEspera.SetTipoLocalidad (TipoLocalidad: TTipoLocalidad);
begin
	Self.FTipoLocalidad := TipoLocalidad;
end;

procedure TEspera.SetSiguiente (Siguiente: PTEspera);
begin
	Self.FSiguiente := Siguiente;
end;

function TEspera.GetNombre: String;
begin
	GetNombre := Self.FNombre;
end;

function TEspera.GetTelefono: longint;
begin
	GetTelefono := Self.FTelefono;
end;

function TEspera.GetEmail: String;
begin
	GetEmail := Self.FEmail;
end;

function TEspera.GetNumero: TNumero;
begin
	GetNumero := Self.FNumero;
end;

function TEspera.GetTipoLocalidad: TTipoLocalidad;
begin
	GetTipoLocalidad := Self.FTipoLocalidad
end;

function TEspera.GetSiguiente: PTEspera;
begin
	GetSiguiente := Self.FSiguiente
end;

end.
