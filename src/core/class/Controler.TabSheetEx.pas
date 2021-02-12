unit Controler.TabSheetEx;

interface

uses
 Classes, Controls, ComCtrls, SysUtils, StdCtrls, Buttons, Types, Vcl.Graphics,
  Winapi.Windows, Vcl.Forms;

Type

  TCustumTabBtn  = class(TSpeedButton)
  private
    FbtnTab: TTabSheet;
    procedure SetbtnTab(const Value: TTabSheet);
  protected
  published
    public
      procedure Click; Override;
      property btnTab    :TTabSheet read FbtnTab write SetbtnTab;
  end;

 TBtnTabSheet  = class(TTabSheet)
    private
       FBtn: TCustumTabBtn;
       FFormNameIntance : string;
       procedure SetupInternalBtn;
       procedure SetBtnPosition;
   protected
      procedure SetParent(AParent: TWinControl); override;
      procedure DoShow; override;
      procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    public
      constructor Create(AOwner: TComponent); override;
      procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
      property FormNameIntance: string read FFormNameIntance write FFormNameIntance;

 end;

 procedure Register;

implementation

procedure Register;
begin
 // registar o componente em desingner
end;

{ TBtnTabSheet }

constructor TBtnTabSheet.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  //Chama a procedure que cria o BitBtn
  SetupInternalBtn;
end;

procedure TBtnTabSheet.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FBtn) and (Operation = opRemove) then
    FBtn := nil;
end;

procedure TBtnTabSheet.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  //Chama a procedure que ajusta a posi��o do BitBtn
  SetBtnPosition;
end;

procedure TBtnTabSheet.SetBtnPosition;
var
 rec: TRect;
begin
  if not Assigned(PageControl) then
    exit;
  //aqui pego o rect da aba (bem l� em cima o cabe�alho)
  Rec := self.PageControl.TabRect(self.PageIndex);
  Fbtn.SetBounds(rec.Right-FBtn.Width, rec.Top, Fbtn.Width, Fbtn.Height);
 end;

procedure TBtnTabSheet.SetParent(AParent: TWinControl);
begin
  inherited;
  inherited SetParent(AParent);
  if FBtn = nil then
     exit;

  FBtn.Parent  := AParent;
  FBtn.Visible := True;
end;

procedure TBtnTabSheet.SetupInternalBtn;
begin
 if Assigned(FBtn) then
   exit;
  FBtn := TCustumTabBtn.Create(Self);
  FBtn.FreeNotification(Self);
  FBtn.Caption :='';
  FBtn.Height  :=15;
  FBtn.Width   :=15;
  FBtn.Flat    :=True;
  FBtn.Transparent :=False;
  FBtn.btnTab  :=Self;
  FBtn.Glyph.Width := 10;
  FBtn.Glyph.Height := 10;
  FBtn.Glyph.SetSize(10,10);
  FBtn.Glyph.LoadFromResourceName(Hinstance,'img_close');
  FBtn.Glyph.PixelFormat := pf24bit;
  FBtn.Glyph.TransparentColor := clBlack;
  FBtn.Glyph.Transparent := True;


end;

procedure TBtnTabSheet.DoShow;
begin
  inherited;
  {Aqui colocao um espa�o no final do caption para o bot�o
  n�o sobreescrever o texto }
  if Pos('      ', Caption)=0 then
    Caption :=Caption+'      ';
  SetBtnPosition;
end;

{ TCustumTabBtn }
procedure TCustumTabBtn.Click;
begin
  inherited;
  if Assigned(FbtnTab) then
  begin
    if TBtnTabSheet(FbtnTab).FindChildControl(TBtnTabSheet(FbtnTab).FormNameIntance) is TForm then
    begin
      TForm(TBtnTabSheet(FbtnTab).FindChildControl(TBtnTabSheet(FbtnTab).FormNameIntance)).Close;
      TForm(TBtnTabSheet(FbtnTab).FindChildControl(TBtnTabSheet(FbtnTab).FormNameIntance)).FreeOnRelease;
      FbtnTab.Destroy;
    end;
  end;
end;

procedure TCustumTabBtn.SetbtnTab(const Value: TTabSheet);
begin
  FbtnTab := Value;
end;

end.
