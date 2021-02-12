program SIGES;



{$R *.dres}

uses
  Vcl.Forms,
  View.FormMain in 'src\forms\main\View.FormMain.pas' {FrmMain},
  Controler.SincGrid in 'src\core\class\Controler.SincGrid.pas',
  Model.TypedGeral in 'src\core\class\Model.TypedGeral.pas',
  Model.ConstantsGerais in 'src\core\class\Model.ConstantsGerais.pas',
  View.FrmBase in 'src\core\form\base\View.FrmBase.pas' {FrmBase},
  View.FrmListEntidade in 'src\forms\Entidade\View.FrmListEntidade.pas' {FrmListEntidade},
  View.FrmStatus in 'src\core\form\Status\View.FrmStatus.pas' {frmStatusMsm},
  Controler.ConsultaBD in 'src\core\class\Controler.ConsultaBD.pas',
  Controler.ConexaoFD in 'src\core\class\Controler.ConexaoFD.pas',
  Controler.TabSheetEx in 'src\core\class\Controler.TabSheetEx.pas',
  View.FrmCadEntidade in 'src\forms\Entidade\View.FrmCadEntidade.pas' {FrmCadEntidade},
  Controler.Functions in 'src\core\functions\Controler.Functions.pas',
  Controler.ViaCEP in 'src\core\class\Controler.ViaCEP.pas',
  View.ViaCEP in 'src\core\class\View.ViaCEP.pas',
  Model.ViaCEP in 'src\core\class\Model.ViaCEP.pas',
  Controler.Mail in 'src\forms\mail\Controler.Mail.pas',
  View.Mail in 'src\forms\mail\View.Mail.pas' {FormMail};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFormMail, FormMail);
  Application.Run;
end.
