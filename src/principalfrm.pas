unit PrincipalFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs; 

type
  TfrmPrincipal = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmPrincipal: TfrmPrincipal;

implementation

initialization
  {$I principalfrm.lrs}

end.

