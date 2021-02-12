unit View.FrmStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, Buttons, Vcl.ComCtrls;

type
  TfrmStatusMsm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    lblStatus: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStatusMsm: TfrmStatusMsm;

implementation

{$R *.dfm}

end.
