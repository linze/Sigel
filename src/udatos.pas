unit uDatos;

{$mode objfpc}{$H+}

interface

uses
  Classes, CSala, CEspera, CReserva, Sysutils, CListaSalas, CListaEspera,
  CListaReservas, DateUtils, CGestionListaEspera, CGestionListaReserva, Dialogs;

  procedure CargaInicial;
  procedure Guardado;

var
    ListaSalas : TListaSalas;
    GestionListaEspera : TGestionListaEspera;
    GEstionListaReserva : TGestionListaReserva;


implementation

procedure CrearMes (Desde: TDateTime);
var
    FechaTope : TDateTime;
    TmpFecha  : TDateTime;

    Sala           : TSala;
    ListaReserva   : TListaReservas;
    ListaEspera    : TListaEspera;
begin
    FechaTope := IncMonth(DateOf(Now));
    TmpFecha := DateOf(Desde);
    ShowMessage(DateToStr(TmpFecha) + '--' + DateToStr(FechaTope));
    while (TmpFecha <> FechaTope) do
    begin
        Sala := TSala.Create;
        Sala.Fecha := TmpFecha;
        ListaSalas.Add(Sala);

        ListaReserva := TListaReservas.Create;
        ListaReserva.Fecha := TmpFecha;
        GestionListaReserva.Add(ListaReserva);

        ListaEspera := TListaEspera.Create;
        ListaEspera.Fecha := TmpFecha;
        GestionListaEspera.Add(ListaEspera);

        TmpFecha := IncDay(TmpFecha);
    end;
end;

procedure CargaInicial;
begin
    ListaSalas := TListaSalas.Create;
    GestionListaReserva := TGestionListaReserva.Create;
    GestionListaEspera := TGestionListaEspera.Create;
    if not FileExists('salas.bin') then
    begin
        CrearMes(Now);
    end
    else
    begin
        ListaSalas.LoadFromFile('salas.bin');
        GestionListaReserva.LoadFromFile('reservas.bin');
        GestionListaEspera.LoadFromFile('esperas.bin');

        // Rellenamos el mes con los huecos que faltan.
        if ListaSalas.Count <> 0 then
            CrearMes(TSala(ListaSalas.Items[ListaSalas.Count-1]).Fecha)
        else
            CrearMes(Now);
    end;
end;

procedure Guardado;
begin
    ListaSalas.SaveToFile('salas.bin');
    GestionListaReserva.SaveToFile('reservas.bin');
    GestionListaEspera.SaveToFile('esperas.bin');
end;

end.

