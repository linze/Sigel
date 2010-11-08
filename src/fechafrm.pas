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
unit FechaFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Calendar, DateUtils;

type

  { TfrmFecha }

    TfrmFecha = class(TForm)
        btnAceptar: TButton;
        btnCancelar: TButton;
        clCalendario: TCalendar;
        Label1: TLabel;
        procedure btnAceptarClick(Sender: TObject);
        procedure btnCancelarClick(Sender: TObject);
        procedure FormCreate(Sender: TObject);
    private
        procedure ComprobarFecha (Fecha : TDateTime);
    public
        Fecha           : TDateTime;
        FechaMarcada    : boolean;
        EsReserva       : boolean;
    end;

var
  frmFecha: TfrmFecha;

implementation

{ TfrmFecha }

procedure TfrmFecha.FormCreate(Sender: TObject);
begin
    Self.FechaMarcada := False;
    clCalendario.DateTime := Now;
end;

procedure TfrmFecha.btnCancelarClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmFecha.ComprobarFecha (Fecha : TDateTime);
var
    TmpFecha : TDateTime;
begin
    TmpFecha := IncMonth(DateOf(Now));
    if CompareDate(Fecha, TmpFecha) = -1 then
    begin
        if CompareDate(Fecha, Now) <> - 1 then
        begin
            if  Self.EsReserva then
            begin
                if CompareDate(Fecha, DateOf(Now)) <> 0 then
                begin
                  Self.FechaMarcada := True;
                  Self.Fecha := Fecha;
                end
                else
                    ShowMessage ('Las reservas no pueden realizarse para el mismo día');
            end
            else
            begin
                Self.FechaMarcada := True;
                Self.Fecha := Fecha;
            end
        end
        else
            ShowMessage ('No se puede operar con funciones pasadas');
    end
    else
        ShowMessage('No se puede operar con más de un mes de antelación');
end;


procedure TfrmFecha.btnAceptarClick(Sender: TObject);
begin
    ComprobarFecha(clCalendario.DateTime);
    if Self.FechaMarcada then
        Self.Close;
end;

initialization
  {$I fechafrm.lrs}

end.

