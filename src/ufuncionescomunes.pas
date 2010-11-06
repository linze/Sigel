unit uFuncionesComunes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils; 

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


end.

