unit View.FormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Imaging.pngimage, System.ImageList, Vcl.ImgList,
  System.Actions, Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan,
  Vcl.CategoryButtons, Vcl.AppEvnts, Vcl.StdCtrls,
  StrUtils, Vcl.WinXCtrls, Vcl.Controls, Controler.TabSheetEx;

type
  TFrmMain = class(TForm)
    pnl_top: TPanel;
    imgMenu: TImage;
    pnl1: TPanel;
    statusbar_main: TStatusBar;
    ApplicationEvents1: TApplicationEvents;
    edtUSERID: TEdit;
    SplitViewMenu: TSplitView;
    imlIcons: TImageList;
    ActionList1: TActionList;
    actHome: TAction;
    actClientes: TAction;
    catMenuItems: TCategoryButtons;
    pControlContainner: TPageControl;
    TabSheet1: TTabSheet;
    procedure imgMenuClick(Sender: TObject);
    procedure cxHintStyleController1ShowHintEx(Sender: TObject; var Caption,
      HintStr: string; var CanShow: Boolean; var HintInfo: THintInfo);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actClientesExecute(Sender: TObject);
    procedure SplitViewMenuMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function LoadFormSheetChild(Sender: TObject;TenantFormClass:TComponentClass;TenantFormObject:TForm;TenantFormTitle:string): Boolean;
    function GetIndexFormSheetChild(SheetForm:String): Integer;
  end;

var
  FrmMain: TFrmMain;

implementation

uses Registry, View.FrmBase, View.FrmListEntidade, Model.ConstantsGerais;


{$R *.dfm}

procedure TFrmMain.actClientesExecute(Sender: TObject);
begin
  LoadFormSheetChild(Sender,TFrmListEntidade,FrmListEntidade,'/CADASTRO /ENTIDADES');
end;

procedure TFrmMain.cxHintStyleController1ShowHintEx(Sender: TObject;
  var Caption, HintStr: string; var CanShow: Boolean; var HintInfo: THintInfo);
begin
  if Caption = '' then Caption := 'Orientações e Dicas';
  HintInfo.HintMaxWidth := 500;
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree ;
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var vlCodContrato : string;
begin
  try
    statusbar_main.Panels[0].Text := INFO_POWERED_SYS;
  except
    on E: Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      Application.Terminate;
    end;
  end;
end;

procedure TFrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key in [VK_RETURN] then
    keybd_event(VK_TAB,0,0,0)
   else
   if (Shift = [ssCtrl]) and (Key in [VK_RETURN]) then
    Perform(WM_NEXTDLGCTL, 1, 0);
end;

procedure TFrmMain.imgMenuClick(Sender: TObject);
begin
  SplitViewMenu.Opened := not SplitViewMenu.Opened;
end;

function TFrmMain.GetIndexFormSheetChild(SheetForm: String): Integer;
var
  Vl_I, Vl_X: integer;
  Vl_NameFrame : TFrame;
 begin
  try
    Result := -1;
    for Vl_I := 0 To pControlContainner.PageCount -1 do
    begin
      if pControlContainner.Pages[Vl_I].Name = SheetForm then
         Result := pControlContainner.Pages[Vl_I].PageIndex;
    end;
  finally

  end;
end;


function TFrmMain.LoadFormSheetChild(Sender: TObject;TenantFormClass:TComponentClass;
                                    TenantFormObject:TForm;TenantFormTitle:string): Boolean;
var
  TabSheet: TBtnTabSheet;
  ComponentName : TComponentName;
  FormSheetIndex : Integer;
  procedure AbreForm(aTabSheetForm: TBtnTabSheet;aClasseForm: TComponentClass; aFormObject: TForm;aTenantFormTitle:string);
  begin
    Application.CreateForm(aClasseForm, aFormObject);
    try
      with aFormObject do
      begin
        TForm(aFormObject).BorderStyle :=  bsNone;
        aFormObject.Parent := aTabSheetForm;
        aTabSheetForm.FormNameIntance := TForm(aFormObject).Name;
        aFormObject.Align := alClient;
        aFormObject.Show;
      end;
    finally
       // Necessita de Trattativas aqui ?
    end;
  end;
begin
  try
    try
      if Sender is TAction then
      Begin
        ComponentName  := 'TabSheet'+TAction(Sender).Name;
        FormSheetIndex := GetIndexFormSheetChild(ComponentName);
        if FormSheetIndex = -1 then
        begin
          try
            TabSheet := TBtnTabSheet.Create(pControlContainner);
            TabSheet.Name := ComponentName;
            TabSheet.PageControl := pControlContainner;
            TabSheet.Caption :=  TAction(Sender).Caption;
            TabSheet.ImageIndex := TAction(Sender).ImageIndex;
          finally
             AbreForm(TabSheet,TenantFormClass,TenantFormObject,TenantFormTitle);
             pControlContainner.ActivePageIndex := GetIndexFormSheetChild(ComponentName);
          end
        end
        else
        begin
          pControlContainner.ActivePageIndex := FormSheetIndex;
        end;
      end;
    finally
      if SplitViewMenu.Opened then SplitViewMenu.Close;
    end;
  except
    // Incluir tratativas aqui  ?
  end;
end;

procedure TFrmMain.SplitViewMenuMouseLeave(Sender: TObject);
begin
  Sleep(300);
  if SplitViewMenu.Opened then SplitViewMenu.Close;
end;

end.
