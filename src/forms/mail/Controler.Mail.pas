unit Controler.Mail;

interface

type
  TMensagemMail = class
  private
    FMensagem: String;
  public
    property Mensagem: String read FMensagem write FMensagem;
  end;

  TServiceMail = class
  public
    function EnviarMail: TMensagemMail;
  end;

implementation

uses
  System.SysUtils, Vcl.Forms, IdSMTP, IdSSLOpenSSL, IdMessage, IdText, IdAttachmentFile, IdExplicitTLSClientServerBase;

{ TEnvioEmail }

function TServiceMail.EnviarMail: TMensagemMail;
var
  lSSL: TIdSSLIOHandlerSocketOpenSSL;
  lSMTP: TIdSMTP;
  lMessage: TIdMessage;
  lText: TIdText;
  lAnexo: string;
begin
  Result := TMensagemMail.Create;
  lSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    lSMTP := TIdSMTP.Create(nil);
    try
      lMessage := TIdMessage.Create(nil);
      try
        lSSL.SSLOptions.Method := sslvSSLv23;
        lSSL.SSLOptions.Mode := sslmClient;
        { Associa ao SMTP a configuraÁ„o para seguranÁa }
        lSMTP.IOHandler := lSSL;
        lSMTP.AuthType := satDefault;
        lSMTP.UseTLS := utUseImplicitTLS;
        lSMTP.Host := 'smtp.gmail.com';
        lSMTP.Port := 465;
        if True then begin
          lSMTP.Username := 'a.ana.paulanovello@gmail.com';
          lSMTP.Password := 'SenhaEmail';
        end;
        {TIdMessage}
        lMessage.From.Address := 'a.ana.paulanovello@gmail.com';
        lMessage.From.Name := 'Nome do Remetente';
        lMessage.ReplyTo.EMailAddresses := lMessage.From.Address;
        lMessage.Recipients.Add.Text := 'ana.paulanovello@hotmail.com';
        lMessage.Recipients.Add.Text := 'a.ana.paulanovello@gmail.com';
        lMessage.Subject := 'Assunto no envio de e-mail';
        lMessage.Encoding := meMIME;
        {TIdText}
        if False then begin
          lText := TIdText.Create(lMessage.MessageParts);
          lText.Body.Add('Corpo do e-mail');
          lText.ContentType := 'text/plain; charset=iso-8859-1';
        end else begin
          lText := TIdText.Create(lMessage.MessageParts);
          lText.Body.Add('<html><head><meta http-equiv="content-type" content="text/html; charset=UTF-8"></head>');
          lText.Body.Add('<body text="#000000" bgcolor="#FFFFFF">');
          lText.Body.Add('<h1>Texto - HTML.</h1><br>');
          lText.Body.Add('<p>Texto de envio com caracteres especiais ¡…Õ”⁄«Á·ÈÌ˙Û ›Õ√„ı’</p><br>');
          lText.Body.Add('<img src=''cid:NomeImagem''>');
          lText.Body.Add('</body></html>');
          lText.ContentType := 'text/html; charset=iso-8859-1';
        end;

        TIdAttachmentFile.Create(lMessage.MessageParts, ExtractFilePath(Application.ExeName) + 'NomeImagem.jpg');
        {TIdAttachmentFile}
        lAnexo := ExtractFilePath(Application.ExeName) + 'Anexo.pdf';
        if FileExists(lAnexo) then begin
          TIdAttachmentFile.Create(lMessage.MessageParts, lAnexo);
        end;
        lAnexo := ExtractFilePath(Application.ExeName) + 'Anexo02.pdf';
        if FileExists(lAnexo) then begin
          TIdAttachmentFile.Create(lMessage.MessageParts, lAnexo);
        end;
        try
          lSMTP.Connect;
          lSMTP.Authenticate;
        except
          on E:Exception do begin
            Result.Mensagem := E.Message;
            Exit;
          end;
        end;
        try
          lSMTP.Send(lMessage);
          Result.Mensagem := 'Mensagem enviada com sucesso!';
        except
          On E:Exception do begin
            Result.Mensagem := E.Message;
          end;
        end;
      finally
        lMessage.Free;
      end;
    finally
      lSMTP.Free;
    end;
  finally
    lSSL.Free;
    UnLoadOpenSSLLibrary;
  end;
end;

end.
