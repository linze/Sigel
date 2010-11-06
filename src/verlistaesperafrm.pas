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
        if TEspera(uDatos.Esperas.Items[i]).Asignada then
            gridVisualizacion.Cells[3,i+1] := 'Si'
        else
            gridVisualizacion.Cells[3,i+1] := 'No';
        gridVisualizacion.Cells[4,i+1] := TEspera(uDatos.Esperas.Items[i]).LocalidadesAsignadas;
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

