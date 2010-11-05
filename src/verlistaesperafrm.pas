unit VerListaEsperaFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, uDatos, CEspera;

type

  { TfrmVerListaEspera }

  TfrmVerListaEspera = class(TForm)
      Button1: TButton;
      ListBox1: TListBox;
      procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmVerListaEspera: TfrmVerListaEspera;

implementation

{ TfrmVerListaEspera }

procedure TfrmVerListaEspera.FormCreate(Sender: TObject);
var
    i: boolean;
begin
    for i:=0 to uDatos.Esperas.Count -1 do
    begin
        ListBox1.Items.Add(TEspera(uDatos.Esperas.Items).Nombre + '   ' +
                            TEspera(uDatos.Esperas.Items).Telefono + '  ' +
                            TEspera(uDatos.Esperas.Items).Email);
    end;
end;

initialization
  {$I verlistaesperafrm.lrs}

end.

