unit View.FrmListEntidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.FrmBase, Vcl.StdCtrls, Vcl.ComCtrls,
  Data.DB, FireDAC.Stan.Intf,FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Menus,
  Controler.SincGrid, Vcl.DBCtrls, Controler.Functions, Model.TypedGeral, Controler.ConsultaBD,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, System.Math, System.StrUtils,
  System.ImageList, Vcl.ImgList, System.Generics.Collections;

type
  TFrmListEntidade = class(TFrmBase)
    DBGridListEntidade: TDBGrid;
    QryListEntidade: TFDQuery;
    dsQryListEntidade: TDataSource;
    Panel1: TPanel;
    btn_refresh: TSpeedButton;
    btn_add: TSpeedButton;
    btn_edt: TSpeedButton;
    btn_del: TSpeedButton;
    GroupBox1: TGroupBox;
    ListField: TComboBoxEx;
    BtnEdt_source: TButtonedEdit;
    ImageList1: TImageList;
    cboxCondicoes: TComboBox;
    btn_mail: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure BtnEdt_sourceRightButtonClick(Sender: TObject);
    procedure preparar_pesquisa(Grid: TDBGrid;Lista:TComboBoxEx);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListFieldChange(Sender: TObject);
    procedure BtnEdt_sourceExit(Sender: TObject);
    procedure btn_addClick(Sender: TObject);
    procedure btn_edtClick(Sender: TObject);
    procedure btn_delClick(Sender: TObject);
    procedure btn_refreshClick(Sender: TObject);
    procedure DBGridListEntidadeDblClick(Sender: TObject);
    procedure btn_mailClick(Sender: TObject);
  private
    { Private declarations }
    procedure TratarAcoesEntidade(Acao: TAcao);
  public
    { Public declarations }
    SincGrid    : TSincGrid;
    FieldSource : TList<TFieldSource>;
  end;

var
  FrmListEntidade: TFrmListEntidade;

implementation

uses  Model.ConstantsGerais,View.FrmCadEntidade, View.Mail;

{$R *.dfm}

procedure TFrmListEntidade.TratarAcoesEntidade(Acao: TAcao);
var DataList : IFDDataSetReference;
begin
  try
    if Acao = aAdd then
    begin
      Application.CreateForm(TFrmCadEntidade, FrmCadEntidade);
      FrmCadEntidade.CarregaDados(Acao);
      FrmCadEntidade.ShowModal;
    end
    else
    if Acao = aEdit then
    begin
      if QryListEntidade.FieldByName('ID').AsInteger > 0 then
      Begin
        Application.CreateForm(TFrmCadEntidade, FrmCadEntidade);
        FrmCadEntidade.CarregaDados(Acao,QryListEntidade.FieldByName('ID').AsInteger);
        FrmCadEntidade.ShowModal;
      end
      else
        ShowMessage('Não há registros para editar.');
    end
    else
    if Acao = aDel then
    begin
      if QryListEntidade.FieldByName('ID').AsInteger > 0 then
      Begin

        DataList :=  Controler.ConsultaBD.TConsultaBD.GetDataOpenSQL(SQL_LIST_ENDERECO,
                                                         TParamList.Create
                                                         .Adiciona('VCP00',ftInteger,QryListEntidade.FieldByName('ID').AsInteger)
                                                        );
        if DataList.DataView.Rows.Count > 0  then
        begin
          ShowMessage('Ação não permitida por existir registros filhos do registro atual.');
        end
        else
        Begin
            Try
               QryListEntidade.Connection.StartTransaction;
               QryListEntidade.Delete;
               QryListEntidade.Connection.Commit;
               ShowMessage('Exclusão realizada com sucesso.');
            Except
               QryListEntidade.Connection.Rollback;
               ShowMessage('Erro ao tentar excluir.');
            End;
        end;

      End;
    end
    else
    if Acao = aRefresh then
    begin
      QryListEntidade.Refresh;
    end;
  finally
    if FrmCadEntidade <> nil then FreeAndNil(FrmCadEntidade);
    QryListEntidade.Refresh;
  end;
end;

procedure TFrmListEntidade.BtnEdt_sourceExit(Sender: TObject);
begin
  inherited;
  if Trim(BtnEdt_source.Text) = '' then
  Begin
    ListField.ItemIndex := -1;
    QryListEntidade.Filtered := False;
    QryListEntidade.Refresh;
  End;
end;

procedure TFrmListEntidade.BtnEdt_sourceRightButtonClick(Sender: TObject);
var lSQL_LIST_CLIENT,
    lCONDICOES, lSINAL, lVALUE : string;
begin
  inherited;
  {
    adendo1 = Implementação futura para consultas gerando uma nova consulta ao banco de dados
              atualmente alguns campo podem ser tornar ambiguos ou terem erros no sql tipo :
              1 - Devido ao alias nas consultas com join ex: EA.ID (ID - Campo autoincreental presente em todas as tabelas)
              2 - Devido a campos virtuais "ENDERECO+' '+CIDADE as ENDERECO_COMPLETO" gerão erros claramente
                  Deve-se melhorar o algoritimo para incluir tais campos nas consultas online.

     possiveis soluções:
     1 - Utilizar o metadatainfo para obeter o nome do campo original juntamente
         com o alias das tabelas (EA.ID) e não o atual real ou virtual (ID) presente no script

     2 - Agregate ?

  lSQL_LIST_CLIENT := SQL_LIST_CLIENT;
  }


  if BtnEdt_source.Text <> '' then
  begin
    if ListField.ItemIndex = -1 then
    begin
       ShowMessage('Favor selecionar um campo para a pesquisa');
       Exit;
    end;

    case cboxCondicoes.ItemIndex of
      0 : lSINAL := ' = ';
      1 : lSINAL := ' <> ';
      2 : lSINAL := ' > ';
      3 : lSINAL := ' >= ';
      4 : lSINAL := ' < ';
      5 : lSINAL := ' <= ';
      6 : lSINAL := ' LIKE ';
    end;

    lVALUE := BtnEdt_source.Text;
    {
     Permite fazer o tratamento conforme o tipo de dado, alem da tipagem mas também o formato se for necessário
     Quando a condição é "contem" pode-se aplicar tratamentos como "inicia com", "termina com"
     mas isso fica para futuras implementações
    }
    Case FieldSource.Items[ListField.ItemIndex].DataType of
      ftUnknown,
      ftString,
      ftWideString,
      ftBoolean : lVALUE := QuotedStr(IfThen(cboxCondicoes.ItemIndex <> 6, lVALUE, '%'+lVALUE+'%' ));

      ftSmallint,
      ftInteger,
      ftWord,
      ftFloat,
      ftCurrency  : lVALUE := IfThen(cboxCondicoes.ItemIndex <> 6, lVALUE,  QuotedStr('%'+lVALUE+'%'));

      ftDate,
      ftTime,
      ftDateTime : lVALUE := QuotedStr(IfThen(cboxCondicoes.ItemIndex <> 6, lVALUE, '%'+lVALUE+'%' ));

    End;


    lCONDICOES := FieldSource.Items[ListField.ItemIndex].FieldName+
                  lSINAL+
                  lVALUE;

    QryListEntidade.Filtered := False;
    QryListEntidade.Filter :=  lCONDICOES;
    QryListEntidade.Filtered := True;
    {
    * - adendo1
    lSQL_LIST_CLIENT := ReplaceStr(lSQL_LIST_CLIENT, 'WHERE 1=1','WHERE '+lCONDICOES);
    uClasse.ConsultaBD.TConsultaBD.QueryOpen(QryListClient,lSQL_LIST_CLIENT);
    SincGrid.SetGrid(DBGridListCli,dsQryListClient);
    }
  end
  else
  Begin
    ListField.ItemIndex := -1;
    QryListEntidade.Filtered := False;
    QryListEntidade.Refresh;
  End;
end;

procedure TFrmListEntidade.btn_addClick(Sender: TObject);
begin
  inherited;
  TratarAcoesEntidade(aAdd);
end;

procedure TFrmListEntidade.btn_delClick(Sender: TObject);
begin
  inherited;
  TratarAcoesEntidade(aDel);
end;

procedure TFrmListEntidade.btn_edtClick(Sender: TObject);
begin
  inherited;
  TratarAcoesEntidade(aEdit);
end;

procedure TFrmListEntidade.btn_mailClick(Sender: TObject);
begin
  inherited;
  Try
    Application.CreateForm(TFormMail, FormMail);
    FormMail.ShowModal;
  Finally
    FreeAndNil(FormMail);
  End;
end;

procedure TFrmListEntidade.btn_refreshClick(Sender: TObject);
begin
  inherited;
  TratarAcoesEntidade(aRefresh);
end;

procedure TFrmListEntidade.DBGridListEntidadeDblClick(Sender: TObject);
begin
  inherited;
  TratarAcoesEntidade(aEdit);
end;

procedure TFrmListEntidade.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(FieldSource);
end;

procedure TFrmListEntidade.FormCreate(Sender: TObject);
begin
  inherited;
  SincGrid := TSincGrid.Create;
  FieldSource := TList<TFieldSource>.Create;
  Controler.ConsultaBD.TConsultaBD.QueryOpen(QryListEntidade,SQL_LIST_ENTIDADE);
  preparar_pesquisa(DBGridListEntidade,ListField);
  SincGrid.SetGrid(DBGridListEntidade,dsQryListEntidade);
end;

procedure TFrmListEntidade.FormResize(Sender: TObject);
begin
  inherited;
  SincGrid.SetGrid(DBGridListEntidade,dsQryListEntidade);
end;

procedure TFrmListEntidade.ListFieldChange(Sender: TObject);
begin
  inherited;
  //BtnEdt_source.Text := FieldSource.Items[ListField.ItemIndex].FullName;
end;

procedure TFrmListEntidade.preparar_pesquisa(Grid: TDBGrid; Lista: TComboBoxEx);
var
  I: Integer;
  Item : TFieldSource;
begin
  Lista.Items.Clear;
  //Lista.Items.Add('');

  FieldSource.Clear;

  for I := 0 to Grid.Columns.Count-1 do
  begin
    with Item do
    begin
      TitleName := Grid.Columns[I].Title.Caption;
      FieldName := Grid.Columns[I].FieldName;
      OriginalName :=  Grid.Columns[I].FieldName;  {irá conter a especificação do adendo1}
      DataType := Grid.Columns[I].Field.DataType;
      IndexField := I;
    end;


    FieldSource.Add(Item);
    Lista.Items.Add(Grid.Columns[I].Title.Caption);
  end;

  Lista.ItemIndex := -1;
end;

end.
