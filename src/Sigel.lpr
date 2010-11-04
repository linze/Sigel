program Sigel;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, PrincipalFrm, LResources, CEstadoLocalidad, CLocalidad, CSala,
  ComprarFrm, ReservaFrm, CEspera, CReserva, CTipoLocalidad, LoginFrm, FechaFrm,
  SeleccionButacaFrm, uDatos, AnularReservaFrm, AnularCompraFrm,
  DatosReservaFrm, CreditosFrm;

{$IFDEF WINDOWS}{$R Sigel.rc}{$ENDIF}

begin
    {$I Sigel.lrs}
    Application.Initialize;
    Application.CreateForm(TfrmPrincipal, frmPrincipal);
    Application.CreateForm(TfrmSeleccionButacas, frmSeleccionButacas);
    Application.CreateForm(TfrmAnularReserva, frmAnularReserva);
    Application.CreateForm(TfrmAnularCompra, frmAnularCompra);
  Application.CreateForm(TfrmDatosReserva, frmDatosReserva);
  Application.CreateForm(TfrmCreditos, frmCreditos);
    Application.Run;
end.

