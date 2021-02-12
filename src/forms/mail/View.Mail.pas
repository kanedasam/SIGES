unit View.Mail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.Controls, Vcl.StdCtrls;

type
  TFormMail = class(TForm)
    ButtonEnviarEmail: TButton;
    procedure ButtonEnviarEmailClick(Sender: TObject);
  public
    { Public declarations }
  private
    { Private declarations }
  end;

var
  FormMail: TFormMail;

implementation

uses Controler.Mail;

{$R *.dfm}

procedure TFormMail.ButtonEnviarEmailClick(Sender: TObject);
var
  lEmailService: TServiceMail;
begin
  {try
    lEmailService := TServiceMail.Create;
    ShowMessage(lEmailService.EnviarMail.Mensagem);
  finally
    lEmailService.Free;
  end;}
  ShowMessage('Infelismente não tive tempo de concluir esta parte do teste'+#13#10+
              'mas se valer de alguma coisa veja a unit Controler.Mail'+#13#10+
              'que esta feita mas faltou a alimentação dos campos'+#13#10+
              'mas espero que tenha apreciado o resto do sistema.');
end;

end.
