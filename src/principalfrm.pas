unit PrincipalFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls;

type

  { TfrmPrincipal }

  TfrmPrincipal = class(TForm)
      Button1: TButton;
      Button2: TButton;
      Button3: TButton;
      Button4: TButton;
      Image1: TImage;
      Image2: TImage;
      StaticText1: TStaticText;
      StaticText2: TStaticText;
      StaticText3: TStaticText;
      procedure FormCreate(Sender: TObject);
      procedure Image2Click(Sender: TObject);
      procedure StaticText1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmPrincipal: TfrmPrincipal;

implementation

{ TfrmPrincipal }

procedure TfrmPrincipal.StaticText1Click(Sender: TObject);
begin

end;

procedure TfrmPrincipal.Image2Click(Sender: TObject);
begin

end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin

end;

initialization
  {$I principalfrm.lrs}

end.

