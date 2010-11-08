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

