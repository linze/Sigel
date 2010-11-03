unit uDatos;

{$mode objfpc}{$H+}

interface

uses
  Classes, CSala, CEspera, CReserva, Sysutils, CListaSalas, CListaEspera,
  CListaReservas, DateUtils;

var
    ListaSalas : TListaSalas;
    ListaEspera : TListaEspera;
    ListaReservas : TListaReservas;


implementation

procedure CrearMes (Desde: TDateTime);
var
    FechaTope : TDateTime;
    TmpFecha  : TDateTime;

    Sala      : TSala;
    Reserva   : TReserva;
    // TODO: Añadir
    //Espera    : TEspera;
begin
    FechaTope := IncMonth(DateOf(Now));
    TmpFecha := DateOf(Desde);
    while (TmpFecha <> FechaTope) do
    begin
        Sala := TSala.Create;
        Sala.Fecha := TmpFecha;
        ListaSalas.Add(Sala);

        Reserva := TReserva.Create;
        Reserva.Fecha := TmpFecha;
        ListaReservas.Add(Reserva);
    end;
end;

procedure CargaInicial;
begin
    ListaSalas := TListaSalas.Create;
    ListaReservas := TListaReservas.Create;
    // TODO: Añadir
    //ListaEspera := TListaEspera.Create;
    if not FileExists('salas.bin') then
    begin
        CrearMes(Now);
    end
    else
    begin
        ListaSalas.LoadFromFile('salas.bin');
        ListaReservas.LoadFromFile('reservas.bin');

        // Rellenamos el mes con los huecos que faltan.
        if ListaSalas.Count <> 0 then
            CrearMes(TSala(ListaSalas.Items[ListaSalas.Count-1]).Fecha)
        else
            CrearMes(Now);
    end;
end;

end.

