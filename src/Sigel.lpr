program Sigel;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, PrincipalFrm, LResources, CTipoLocalidad, CEstadoLocalidad, CLocalidad,
CFecha
  { you can add units after this };

{$IFDEF WINDOWS}{$R Sigel.rc}{$ENDIF}

begin
  {$I Sigel.lrs}
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.

