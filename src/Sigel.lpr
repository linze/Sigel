program Sigel;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, PrincipalFrm, LResources, CEstadoLocalidad, CLocalidad,
    CFecha, CSala, ComprarFrm, ReservaFrm, CEspera, CListareservas,
    CListaEspera, CRepresentacion, CReserva, CTipoLocalidad, CObjectList, 
CObjectListItem
  { you can add units after this };

{$IFDEF WINDOWS}{$R Sigel.rc}{$ENDIF}

begin
    {$I Sigel.lrs}
    Application.Initialize;
    Application.CreateForm(TfrmPrincipal, frmPrincipal);
    Application.CreateForm(TfrmComprar, frmComprar);
    Application.CreateForm(TfrmReserva, frmReserva);
    Application.Run;
end.

