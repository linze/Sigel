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
    function IsNumero (Caracter : Char) : boolean;
    function IsLetra (Caracter : Char) : boolean;
    function EsNumero (Tecla : Char) : Char;
    function EsLetra (Tecla : Char) : Char;

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
    i         : integer;
    valido  : boolean;
begin
    valido := true;
    if Length(Cadena) < 9 then
        valido := false
    else
    begin
        for i:=1 to 8 do
            if not IsNumero(Cadena[i]) then
                valido := false;

        if IsNumero(Cadena[9]) then
            valido := false;
    end;

    result := valido;
end;

function IsNumero (Caracter : Char) : boolean;
begin
    result := ((Caracter >= '0') and (Caracter <= '9'))
end;

function IsLetra (Caracter : Char) : boolean;
begin
    result := ((Caracter >= 'a') and (Caracter <= 'z')) or
                ((Caracter >= 'A') and (Caracter <= 'Z'));
end;

function EsNumero (Tecla : Char) : Char;
begin
    if not (Tecla in [#8, '0'..'9']) then
        result := #0
    else
        result := Tecla;

end;

function EsLetra (Tecla : Char) : Char;
begin
    if not (Tecla in [#8, 'a'..'z', 'A'..'Z', #32]) then
    begin
        result := #0;
    end
    else
        result := Tecla;
end;

end.

