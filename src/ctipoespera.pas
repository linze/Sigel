unit CTipoEspera;

{$mode objfpc}{$H+}

interface

    uses
        CTipoLocalidad, PTipoListaEspera;
    type

    { TEspera }

        TNumero = 1..4;
        TPEspera = ^TipoEspera;
        TEspera = class
        private
        (*Atributos*)
            FNombre        : String;
            FTelefono      : longint;
            FEmail         : String;
            FNumero        : TNumero;
            FTipoLocalidad : TTipoLocalidad;
            FSiguiente     : TPEspera;
        public
            (*Constructor*)
            Constructor Create();
			
            (* Métodos Set *)
            procedure SetNombre (Nombre: String);
            procedure SetTelefono (Telefono: longint);
            procedure SetEmail (Email: String);
            procedure SetNumero (numero: TNumero);
            procedure SetTipoLocalidad (TipoLocalidad: TTipoLocalidad);
            procedure SetSiguiente (Siguiente: TPEspera);

            (* Métodos Get *)
            function GetNombre: String;
            function GetTelefono: longint;
            function GetEmail: String;
            function GetNumero: TNumero;
            // TODO: Verificar que una función puede devolver estos tipos
            function GetTipoLocalidad: TTipoLocalidad;
            function GetSiguiente: TPEspera;
        end;
			
implementation

{ TEspera }

Constructor TEspera.Create;
begin
	// TODO: Hacer
end.

procedure TEspera.SetNombre (Nombre: String);
begin
	Self.FNombre := Nombre;
end.

procedure TEspera.SetTelefono (Telefono: longint);
begin
	Self.FTelefono := Telefono;
end;

procedure SetEmail (Email: String);
begin
	Self.FEmail := Email;
end;

procedure SetNumero (numero: TNumero);
begin
	Self.FNumero := numero;
end;

procedure SetTipoLocalidad (TipoLocalidad: TTipoLocalidad);
begin
	Self.FTipoLocalidad := TipoLocalidad;
end;

procedure SetSiguiente (Siguiente: TPEspera);
begin
	Self.FSiguiente := Siguiente;
end;

function GetNombre: String;
begin
	GetNombre := Self.FNombre;
end;

function GetTelefono: longint; 
begin
	GetTelefono := Self.FTelefono;
end;

function GetEmail: String;
begin
	GetEmail := Self.FEmail;
end;

function GetNumero: TNumero;
begin
	GetNumero := Self.FNumero;
end;

function GetTipoLocalidad: TTipoLocalidad;
begin
	GetTipoLocalidad := Self.FTipoLocalidad
end;

function GetSiguiente: TPEspera;
begin
	GetSiguiente := Self.FSiguiente
end;
