{    This file is part of Sigel.

    Sigel is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Sigel is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Sigel.  If not, see <http://www.gnu.org/licenses/>. }
unit frmDatosCompra;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, Spin, uDatos;

type

  { TfrmDatosCompra }

  TfrmDatosCompra = class(TForm)
      Button1: TButton;
      Button2: TButton;
      cbTipo: TComboBox;
      Label1: TLabel;
      Label2: TLabel;
      Label3: TLabel;
      Label4: TLabel;
      seFila: TSpinEdit;
      seNumero: TSpinEdit;
      procedure Button1Click(Sender: TObject);
      procedure Button2Click(Sender: TObject);
      procedure cbTipoChange(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure Label1Click(Sender: TObject);
      procedure Label2Click(Sender: TObject);
  private
    { private declarations }
  public
  end;

var
  frmDatosCompra: TfrmDatosCompra;

implementation

{ TfrmDatosCompra }

procedure TfrmDatosCompra.cbTipoChange(Sender: TObject);
begin

end;

procedure TfrmDatosCompra.Button1Click(Sender: TObject);
var
    i: integer;
    Found : boolean;
begin
    Found := False;
    for i:=1 to uDatos.

end;

procedure TfrmDatosCompra.Button2Click(Sender: TObject);
begin
    Self.Close;
end;

procedure TfrmDatosCompra.FormCreate(Sender: TObject);
begin

end;

procedure TfrmDatosCompra.Label1Click(Sender: TObject);
begin

end;

procedure TfrmDatosCompra.Label2Click(Sender: TObject);
begin

end;

initialization
  {$I frmdatoscompra.lrs}

end.

