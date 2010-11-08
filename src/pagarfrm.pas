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
unit PagarFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls;

type

  { TfrmPagar }

  TfrmPagar = class(TForm)
      btnAceptar: TButton;
      btnCancelar: TButton;
      cbMetodo: TComboBox;
      eNumero: TEdit;
      eCCV: TEdit;
      Label1: TLabel;
      lbCantidad: TLabel;
      Label3: TLabel;
      Label4: TLabel;
      Label5: TLabel;
      pTarjeta: TPanel;
      procedure btnAceptarClick(Sender: TObject);
      procedure btnCancelarClick(Sender: TObject);
      procedure cbMetodoChange(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    PagoAceptado : boolean;
    Cantidad : integer;
  end; 

var
  frmPagar: TfrmPagar;

implementation

{ TfrmPagar }

procedure TfrmPagar.cbMetodoChange(Sender: TObject);
begin
    pTarjeta.Visible := (Sender as TComboBox).Text = 'Tarjeta';
end;

procedure TfrmPagar.FormCreate(Sender: TObject);
begin
    PagoAceptado := False;
end;

procedure TfrmPagar.FormShow(Sender: TObject);
begin
    lbCantidad.Caption := IntToStr(Self.Cantidad) + ' euros';
end;

procedure TfrmPagar.btnCancelarClick(Sender: TObject);
begin
    Self.Close;
end;

procedure TfrmPagar.btnAceptarClick(Sender: TObject);
begin
    if cbMetodo.Text = 'Tarjeta' then
        if (eNumero.Text <> '') and (eCCV.Text <> '') then
            PagoAceptado := True
        else
            ShowMessage('Es necesario indicar el número y el CCV')
    else if cbMetodo.Text = 'Efectivo' then
        PagoAceptado := True
    else
        ShowMessage('Es necesario indicar un método de pago');

    if PagoAceptado then
        Self.Close;
end;

initialization
  {$I pagarfrm.lrs}

end.

