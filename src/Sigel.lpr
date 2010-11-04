program Sigel;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, PrincipalFrm, LResources, CEstadoLocalidad, CLocalidad, CSala, ComprarFrm, ReservaFrm, CEspera, CListareservas,
    CListaEspera, CReserva, CTipoLocalidad, CObjectList, 
    CObjectListItem, LoginFrm, FechaFrm, SeleccionButacaFrm, uDatos, 
CListaSalas, AnularReservaFrm, AnularCompraFrm, CObjectListList, 
CGestionListaEspera, Unit1;

{$IFDEF WINDOWS}{$R Sigel.rc}{$ENDIF}

begin
    {$I Sigel.lrs}
    Application.Initialize;
    Application.CreateForm(TfrmPrincipal, frmPrincipal);
    Application.CreateForm(TfrmSeleccionButacas, frmSeleccionButacas);
    Application.CreateForm(TfrmAnularReserva, frmAnularReserva);
    Application.CreateForm(TfrmAnularCompra, frmAnularCompra);
    Application.Run;
end.

