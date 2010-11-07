unit uFuncionesComunes;

{$mode objfpc}{$H+}

interface

    uses
        Classes, SysUtils, CLocalidad, CTipoLocalidad, Dialogs;

    type
        EInvalidDNICIF = class(Exception);

    function EsEmail(EMail: string): Boolean;
    function LocalidadToString(Localidad: TLocalidad): string;
    function DNIValido (Cadena : String): boolean;

implementation

function EsEmail(EMail: string): Boolean;
var
    s    : string;
    ETpos: Integer;
begin
    ETpos := pos('@', EMail);
    if ETpos > 1 then
    begin
        s := copy(EMail, ETpos + 1, Length(EMail));
        if (pos('.', s) > 1) and (pos('.', s) < length(s)) then
             Result := true
        else
             Result := false;
        end
    else
        Result := false;
end;

function LocalidadToString(Localidad: TLocalidad): string;
var
    TmpStr    : string;
begin
    case Localidad.Tipo of
        Patio: TmpStr := 'Pat: F' + IntToStr(Localidad.Fila) + 'N' + IntToStr(Localidad.Numero) + '  ';
        PrimeraPlanta: TmpStr := 'PP: F' + IntToStr(Localidad.Fila) + 'N' + IntToStr(Localidad.Numero) + '  ';
        Palco: TmpStr := 'Palco: ' + IntToStr(Localidad.Numero) + '  ';
    end;
    Result := TmpStr;
end;

function DNIValido (Cadena : String): boolean;
var
    NumeroStr : String;
    i         : integer;
    valido  : boolean;
begin
    valido := true;
    if Length(Cadena) < 9 then
        valido := false
    else
    begin
        for i:=1 to 8 do
            if not ((Cadena[i] >= '0') and (Cadena[i] <= '9')) then
                valido := false;

        if ((Cadena[9] >= '0') and (Cadena[9] <= '9')) then
            valido := false;
    end;

    result := valido;
end;

end.

