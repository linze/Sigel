unit CLocalidad;

{$mode objfpc}{$H+}

interface
         uses
             CTipoLocalidad, CEstadoLocalidad;
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

                    { Métodos de asignación de atributos }
                    procedure SetFila(Fila: integer);
                    procedure SetTipo(Tipo: TTipoLocalidad);
                    procedure SetEstado(Estado: TEstadoLocalidad);
                    procedure SetNumero(Numero: integer);

                    { Métodos de obtención de atributos }
                    function GetTipo: TTipoLocalidad;
                    function GetEstado: TEstadoLocalidad;
                    function GetNumero: integer;
                    function GetFila: integer;

                    { Operaciones propias de la clase }
                    function EstaOcupado: boolean;
             end;


implementation

{ TLocalidad }

constructor TLocalidad.Create;
begin
     // TODO: Evaluar si es necesario e implementar
end;

procedure TLocalidad.SetTipo (Tipo: TTipoLocalidad);
begin
     Self.FTipo := Tipo;
end;

procedure TLocalidad.SetEstado (Estado: TEstadoLocalidad);
begin
     Self.FEstado := Estado;
end;

procedure TLocalidad.SetNumero (Numero: integer);
begin
     Self.FNumero := Numero;
end;

procedure TLocalidad.SetFila (Fila: integer);
begin
     Self.FFila := Fila;
end;

function TLocalidad.GetTipo : TTipoLocalidad;
begin
     GetTipo := Self.FTipo;
end;

function TLocalidad.GetEstado : TEstadoLocalidad;
begin
     GetEstado := Self.FEstado;
end;

function TLocalidad.GetNumero : integer;
begin
     GetNumero := Self.FNumero;
end;

function TLocalidad.GetFila : integer;
begin
     GetFila := Self.FFila;
end;

function TLocalidad.EstaOcupado : boolean;
begin
     EstaOcupado := (Self.GetEstado <> Libre);
end;

end.

