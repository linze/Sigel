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
unit VerListaEsperaFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Grids, ExtCtrls, uDatos, CEspera;

type

  { TfrmVerListaEspera }

  TfrmVerListaEspera = class(TForm)
      btnCerrar: TButton;
      Panel1: TPanel;
      Panel2: TPanel;
      Panel3: TPanel;
      Panel4: TPanel;
      gridVisualizacion: TStringGrid;
      procedure btnCerrarClick(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure ListBox1Click(Sender: TObject);
      procedure Panel3Click(Sender: TObject);
  private
  public
    { public declarations }
  end; 

var
  frmVerListaEspera: TfrmVerListaEspera;

implementation

{ TfrmVerListaEspera }

procedure TfrmVerListaEspera.FormCreate(Sender: TObject);
var
    i: integer;
begin
    gridVisualizacion.RowCount := 1;
    for i:=0 to uDatos.Esperas.Count -1 do
    begin
        gridVisualizacion.RowCount := gridVisualizacion.RowCount + 1;
        gridVisualizacion.Cells[0,i+1] := TEspera(uDatos.Esperas.Items[i]).Nombre;
        gridVisualizacion.Cells[1,i+1] := TEspera(uDatos.Esperas.Items[i]).Telefono;
        gridVisualizacion.Cells[2,i+1] := TEspera(uDatos.Esperas.Items[i]).Email;
        gridVisualizacion.Cells[3,i+1] := IntToStr(TEspera(uDatos.Esperas.Items[i]).Numero);
        if TEspera(uDatos.Esperas.Items[i]).Asignada then
            gridVisualizacion.Cells[4,i+1] := 'Si'
        else
            gridVisualizacion.Cells[4,i+1] := 'No';
        gridVisualizacion.Cells[5,i+1] := TEspera(uDatos.Esperas.Items[i]).LocalidadesAsignadas;
    end;
end;

procedure TfrmVerListaEspera.btnCerrarClick(Sender: TObject);
begin
    Self.Close;
end;

procedure TfrmVerListaEspera.ListBox1Click(Sender: TObject);
begin

end;

procedure TfrmVerListaEspera.Panel3Click(Sender: TObject);
begin

end;

initialization
  {$I verlistaesperafrm.lrs}

end.

