unit VerListaReservas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, Grids, StdCtrls, uDatos, CReserva, CLocalidad,
  uFuncionesComunes;

type

  { TfrmVerListaReservas }

  TfrmVerListaReservas = class(TForm)
      btnCerrar: TButton;
      gridVisualizacion: TStringGrid;
      Panel1: TPanel;
      Panel2: TPanel;
      Panel3: TPanel;
      Panel4: TPanel;
      procedure btnCerrarClick(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure Panel4Click(Sender: TObject);
  private
    function LocalidadesToString (Reserva : TReserva) : string;
  public
    { public declarations }
  end; 

var
  frmVerListaReservas: TfrmVerListaReservas;

implementation

{ TfrmVerListaReservas }

procedure TfrmVerListaReservas.Panel4Click(Sender: TObject);
begin

end;

function TfrmVerListaReservas.LocalidadesToString(Reserva: TReserva): string;
var
    TmpStr    : string;
    i         : integer;
    Localidad : TLocalidad;
begin
    TmpStr := '';
    for i:=1 to Reserva.Cantidad do
    begin
        Localidad := Reserva.GetLocalidad(i);
        TmpStr := TmpStr + uFuncionesComunes.LocalidadToString(Localidad);
    end;
    Result := TmpStr;
end;

procedure TfrmVerListaReservas.FormCreate(Sender: TObject);
begin
end;

procedure TfrmVerListaReservas.FormShow(Sender: TObject);
var
    i: integer;
begin
    gridVisualizacion.RowCount := 1;
    if uDatos.Reservas.Count <> 0 then
    begin
        for i:=0 to uDatos.Reservas.Count -1 do
        begin
            gridVisualizacion.RowCount := gridVisualizacion.RowCount + 1;
            gridVisualizacion.Cells[0,i+1] := TReserva(uDatos.Reservas.Items[i]).Nombre;
            gridVisualizacion.Cells[1,i+1] := TReserva(uDatos.Reservas.Items[i]).Dni;
            gridVisualizacion.Cells[2,i+1] := TReserva(uDatos.Reservas.Items[i]).Telefono;
            gridVisualizacion.Cells[3,i+1] := TReserva(uDatos.Reservas.Items[i]).Email;
            gridVisualizacion.Cells[4,i+1] := LocalidadesToString(TReserva(uDatos.Reservas.Items[i]));
        end;
    end;
end;

procedure TfrmVerListaReservas.btnCerrarClick(Sender: TObject);
begin
    Self.Close;
end;

initialization
  {$I verlistareservas.lrs}

end.

