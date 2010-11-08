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
unit LoginFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TfrmLogin }

  TfrmLogin = class(TForm)
      btnAceptar: TButton;
      btnCancelar: TButton;
      ePassword: TEdit;
      Label1: TLabel;
      procedure btnAceptarClick(Sender: TObject);
      procedure btnCancelarClick(Sender: TObject);
      procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    ValidPassword : boolean;
  end; 

var
  frmLogin: TfrmLogin;

implementation

{ TfrmLogin }

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
    ValidPassword := False;
end;

procedure TfrmLogin.btnCancelarClick(Sender: TObject);
begin
    Self.Close;
end;

procedure TfrmLogin.btnAceptarClick(Sender: TObject);
begin
    if ePassword.Text = 'eacmsm1o' then
    begin
        ValidPassword := True;
        Close;
    end
    else
        ShowMessage ('Contraseña incorrecta');
end;

initialization
  {$I loginfrm.lrs}

end.

