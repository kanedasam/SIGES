unit View.FrmBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  Vcl.StdCtrls, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls;

type
  TFrmBase = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    Vg_IntParm1, Vg_IntParm2, Vg_IntParm3, Vg_IntParm4, Vg_IntParm5 : string;
    Vg_StrParm1, Vg_StrParm2, Vg_StrParm3, Vg_StrParm4, Vg_StrParm5 : Integer;
    class function ColumnByFieldName(Grid: TDBGrid; fieldName: string): TColumn;
  public
    { Public declarations }
    procedure CloseAllDataSets(vp_NameForm: TForm);
  end;

var
  FrmBase: TFrmBase;
  Conexao: TFDConnection; // Conexão global que será extraída do Principal

  implementation

{uses
  Model.VariableSystem;}

{$R *.dfm}

class function TFrmBase.ColumnByFieldName(Grid:TDBGrid;  fieldName:string):TColumn;
var
  i:Integer;
begin
  fieldName := LowerCase(fieldName);
  Result := nil;
  for i := 0 to Grid.Columns.Count - 1 do
      if LowerCase(Grid.Columns[i].FieldName) = fieldName then
      begin
        Result := Grid.Columns[i];
        Break;
      end;
end;

procedure TFrmBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAllDataSets(Self);
  Action := caFree ;
end;

procedure TFrmBase.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;
end;

procedure TFrmBase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) then
  begin
    if Key = Ord('H') then
    begin
      {try

      finally

      end;}

    end;
  end;
end;

procedure TFrmBase.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #27 Then Close;
end;

procedure TFrmBase.FormShow(Sender: TObject);
begin
  //CreateDataSetMonitor;
end;

procedure ImportarConexao(Con: TFDConnection);
begin
    Conexao := Con; // Atribui ao objeto global Conexão a referência da Conexão Con, passada como parâmetro
end;

procedure TFrmBase.CloseAllDataSets(vp_NameForm: TForm);
var
  i: integer;
begin
  for i := 0 to vp_NameForm.ComponentCount - 1 do
  begin
    if vp_NameForm.Components[i] is TFDTable then
      if TFDTable(vp_NameForm.Components[i]).Active then TFDTable(vp_NameForm.Components[i]).Close;

    if vp_NameForm.Components[i] is TFDQuery then
      if TFDQuery(vp_NameForm.Components[i]).Active then TFDQuery(vp_NameForm.Components[i]).Close;

    if vp_NameForm.Components[i] is TFDMemTable then
      if TFDMemTable(vp_NameForm.Components[i]).Active then TFDMemTable(vp_NameForm.Components[i]).Close;
  end;
end;

end.
