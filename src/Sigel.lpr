program Sigel;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, PrincipalFrm, LResources, CEstadoLocalidad, CLocalidad, CSala, ComprarFrm, ReservaFrm, CEspera, CListareservas,
    CListaEspera, CRepresentacion, CReserva, CTipoLocalidad, CObjectList, 
CObjectListItem, LoginFrm, FechaFrm;

{$IFDEF WINDOWS}{$R Sigel.rc}{$ENDIF}

begin
    {$I Sigel.lrs}
    Application.Initialize;
    Application.CreateForm(TfrmPrincipal, frmPrincipal);
    Application.CreateForm(TfrmComprar, frmComprar);
    Application.CreateForm(TfrmReserva, frmReserva);
    Application.CreateForm(TfrmLogin, frmLogin);
    Application.CreateForm(TfrmFecha, frmFecha);
    Application.Run;
end.

