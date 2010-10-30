unit CTipoEspera;

{$mode objfpc}{$H+}

interface

	uses
		CTipoLocalidad, PTipoListaEspera, PTipoEspera;
	type
	
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
	self.FNombre := Nombre;
end.

procedure TEspera.SetTelefono (Telefono: longint);
begin
	self.FTelefono := Telefono;
end;

procedure SetEmail (Email: String);
begin
	self.FEmail := Email;
end;

procedure SetNumero (numero: TNumero);
begin
	self.FNumero := numero;
end;

procedure SetTipoLocalidad (TipoLocalidad: TTipoLocalidad);
begin
	self.FTipoLocalidad := TipoLocalidad;
end;

procedure SetSiguiente (Siguiente: TPEspera);
begin
	self.FSiguiente := Siguiente;
end;

function GetNombre: String;
begin
	GetNombre := self.FNombre;
end;

function GetTelefono: longint; 
begin
	GetTelefono := self.FTelefono;
end;

function GetEmail: String;
begin
	GetEmail := self.FEmail;
end;

function GetNumero: TNumero;
begin
	GetNumero := self.FNumero;
end;

function GetTipoLocalidad: TTipoLocalidad;
begin
	GetTipoLocalidad := self.FTipoLocalidad
end;

function GetSiguiente: TPEspera;
begin
	GetSiguiente := self.FSiguiente
end;
