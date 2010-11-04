unit DatosReservaFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TfrmDatosReserva }

  TfrmDatosReserva = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Intro: TLabel;
    NombreCompleto: TLabel;
    DNI: TLabel;
    Contacto: TLabel;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmDatosReserva: TfrmDatosReserva;

implementation

initialization
  {$I datorreservafrm.lrs}

end.

