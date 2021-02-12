unit View.FrmCadEntidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.FrmBase, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, System.ImageList, Vcl.ImgList,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls,  Model.TypedGeral, Controler.ConexaoFD,
  Controler.ConsultaBD, System.StrUtils, Vcl.WinXCtrls, Controler.SincGrid;

type
  TFrmCadEntidade = class(TFrmBase)
    Pnl_control: TPanel;
    btn_save: TSpeedButton;
    btn_close: TSpeedButton;
    QryEntidade: TFDQuery;
    dsEntidade: TDataSource;
    Connectiondef1Connection: TFDConnection;
    EntidadeTable: TFDQuery;
    Entidade_enderecoTable: TFDQuery;
    Tipo_enderecoTable: TFDQuery;
    Tipo_entidadeTable: TFDQuery;
    Tipo_pessoaTable: TFDQuery;
    EntidadeTableID: TIntegerField;
    EntidadeTableCOD_TIPO_ENTIDADE: TIntegerField;
    EntidadeTableCOD_TIPO_PESSOA: TIntegerField;
    EntidadeTableNOME: TWideStringField;
    EntidadeTableCPF_CNPJ: TWideStringField;
    EntidadeTableIDENTIDADE: TWideStringField;
    EntidadeTableEMAIL: TWideStringField;
    EntidadeTableCOD_ENTIDADE_ENDERECO: TIntegerField;
    Entidade_enderecoTableID: TIntegerField;
    Entidade_enderecoTableCOD_ENTIDADE: TIntegerField;
    Entidade_enderecoTableCOD_TIPO_ENDERECO: TIntegerField;
    Entidade_enderecoTableCEP: TWideStringField;
    Entidade_enderecoTableLOGRADOURO: TWideStringField;
    Entidade_enderecoTableNUMERO: TIntegerField;
    Entidade_enderecoTableFLG_SEM_NUMERO: TSmallintField;
    Entidade_enderecoTableCOMPLEMENTO: TWideStringField;
    Entidade_enderecoTableBAIRRO: TWideStringField;
    Entidade_enderecoTableCIDADE: TWideStringField;
    Entidade_enderecoTableESTADO: TWideStringField;
    Entidade_enderecoTablePAIS: TWideStringField;
    Tipo_enderecoTableID: TIntegerField;
    Tipo_enderecoTableDSC_ENDERECO: TWideStringField;
    Tipo_entidadeTableID: TIntegerField;
    Tipo_entidadeTableDSC_ENTIDADE: TWideStringField;
    Tipo_pessoaTableID: TIntegerField;
    Tipo_pessoaTableDSC_PESSOA: TWideStringField;
    dsEntidadeTable: TDataSource;
    pgctrl_entidade: TPageControl;
    tabs_entidade: TTabSheet;
    tabs_endereco: TTabSheet;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    lbl_cpfcnpj: TLabel;
    dbedt_cpfcnpj: TDBEdit;
    Label6: TLabel;
    edt_ident: TDBEdit;
    Label7: TLabel;
    dbedt_mail: TDBEdit;
    Label8: TLabel;
    DBEdit2: TDBLookupComboBox;
    DBEdit3: TDBLookupComboBox;
    DBEdit8: TDBLookupComboBox;
    dsEntidade_enderecoTable: TDataSource;
    dsTipo_enderecoTable: TDataSource;
    dsTipo_entidadeTable: TDataSource;
    dsTipo_pessoaTable: TDataSource;
    Label5: TLabel;
    pgctrl_enderecos: TPageControl;
    tabs_end_list: TTabSheet;
    tabs_end_edt: TTabSheet;
    DBGridListEntidadeEndereco: TDBGrid;
    Label9: TLabel;
    Label12: TLabel;
    Label20: TLabel;
    DBEdit5: TDBEdit;
    Label10: TLabel;
    DBEdit6: TDBEdit;
    Label11: TLabel;
    dbedt_cep: TDBEdit;
    Label13: TLabel;
    DBEdit10: TDBEdit;
    Label14: TLabel;
    dbedt_numero: TDBEdit;
    Label15: TLabel;
    Label16: TLabel;
    DBEdit13: TDBEdit;
    Label17: TLabel;
    DBEdit14: TDBEdit;
    Label18: TLabel;
    DBEdit15: TDBEdit;
    Label19: TLabel;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    PnlBtn_list_end: TPanel;
    btn_refresh: TSpeedButton;
    btn_add: TSpeedButton;
    btn_edt: TSpeedButton;
    btn_del: TSpeedButton;
    PnlBtn_edt_end: TPanel;
    btn_edt_close: TSpeedButton;
    btn_edt_save: TSpeedButton;
    DBEdit7: TDBLookupComboBox;
    dbchk_semnum: TDBCheckBox;
    btn_pesq_cep: TBitBtn;
    QryListEnderecos: TFDQuery;
    dsQryListEnderecos: TDataSource;
    QryListEnderecosID: TIntegerField;
    QryListEnderecosNOME: TWideStringField;
    QryListEnderecosDSC_ENDERECO: TWideStringField;
    QryListEnderecosCEP: TWideStringField;
    QryListEnderecosLOGRADOURO: TWideStringField;
    QryListEnderecosNUMERO: TIntegerField;
    QryListEnderecosBAIRRO: TWideStringField;
    QryListEnderecosCIDADE: TWideStringField;
    QryListEnderecosESTADO: TWideStringField;
    QryListEnderecosENTIDADE_ID: TIntegerField;
    QryEndPrincipal: TFDQuery;
    dsQryEndPrincipal: TDataSource;
    QryEndPrincipalID: TIntegerField;
    QryEndPrincipalCOD_ENTIDADE: TIntegerField;
    QryEndPrincipalEND_FULL: TWideStringField;
    procedure dbedt_cpfcnpjEnter(Sender: TObject);
    procedure dbedt_cpfcnpjExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbedt_mailExit(Sender: TObject);
    procedure dsEntidadeTableDataChange(Sender: TObject; Field: TField);
    procedure EntidadeTableAfterInsert(DataSet: TDataSet);
    procedure EntidadeTableBeforePost(DataSet: TDataSet);
    procedure btn_closeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tabs_entidadeShow(Sender: TObject);
    procedure tabs_enderecoShow(Sender: TObject);
    procedure DBGridListEntidadeEnderecoDblClick(Sender: TObject);
    procedure tabs_end_listShow(Sender: TObject);
    procedure tabs_end_edtShow(Sender: TObject);
    procedure btn_edt_closeClick(Sender: TObject);
    procedure btn_addClick(Sender: TObject);
    procedure btn_edtClick(Sender: TObject);
    procedure btn_delClick(Sender: TObject);
    procedure btn_refreshClick(Sender: TObject);
    procedure btn_saveClick(Sender: TObject);
    procedure btn_edt_saveClick(Sender: TObject);
    procedure Entidade_enderecoTableAfterInsert(DataSet: TDataSet);
    procedure dsEntidade_enderecoTableDataChange(Sender: TObject;
      Field: TField);
    procedure dbchk_semnumClick(Sender: TObject);
    procedure btn_pesq_cepClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    SincGrid2    : TSincGrid;
    procedure AjustarCampos;
    procedure CarregaDados(Acao: TAcao;ID: Integer = 0);
    procedure TratarAcoesEntidadeEnderecos(Acao: TAcao);
  end;

var
  FrmCadEntidade: TFrmCadEntidade;

implementation

uses Controler.Functions, Controler.ViaCEP, View.ViaCEP, Model.ViaCEP, 
  Model.ConstantsGerais ;

{$R *.dfm}

procedure TFrmCadEntidade.AjustarCampos;
begin
  case EntidadeTable.FieldByName('COD_TIPO_PESSOA').AsInteger of
    1: begin
          lbl_cpfcnpj.Caption := 'CPF';
          edt_ident.Enabled := True;
       end;

    2: begin
          lbl_cpfcnpj.Caption := 'CNPJ';
          edt_ident.Enabled := False;
          if dsEntidade.State in [dsInsert,dsEdit] then
            EntidadeTable.FieldByName('IDENTIDADE').AsString := '';
       end;
  end;
end;

procedure TFrmCadEntidade.btn_addClick(Sender: TObject);
begin
  inherited;
  TratarAcoesEntidadeEnderecos(aAdd);
end;

procedure TFrmCadEntidade.btn_closeClick(Sender: TObject);
begin
  inherited;
  if dsEntidadeTable.State in [dsInsert,dsEdit] then 
  begin
    if (MessageBox(0, PChar('Exsite dados não salvos, Deseja continuar?'), 
                   PChar('ATENÇÃO !!!'), MB_ICONWARNING or MB_YESNO) = idYes) then
    begin
      EntidadeTable.Cancel;
      EntidadeTable.Connection.Rollback;
      Close;
    end;               
  end
  else
  Close;
end;

procedure TFrmCadEntidade.btn_delClick(Sender: TObject);
begin
  inherited;
  TratarAcoesEntidadeEnderecos(aDel);
end;

procedure TFrmCadEntidade.btn_edtClick(Sender: TObject);
begin
  inherited;
  TratarAcoesEntidadeEnderecos(aEdit);
end;

procedure TFrmCadEntidade.btn_edt_closeClick(Sender: TObject);
begin
  inherited;
  TratarAcoesEntidadeEnderecos(aClose);
end;

procedure TFrmCadEntidade.btn_edt_saveClick(Sender: TObject);
begin
  inherited;
  TratarAcoesEntidadeEnderecos(aSave);  
end;

procedure TFrmCadEntidade.btn_pesq_cepClick(Sender: TObject);
var
  ViaCEP: IViaCEP;
  CEP: TViaCEPClass;
begin
  ViaCEP := TViaCEP.Create;

  if ViaCEP.Validate(OnlyNumber(dbedt_cep.Text)) then
  Begin  
    btn_pesq_cep.Caption := 'PESQUISANDO...';
    
    CEP := ViaCEP.Get(OnlyNumber(dbedt_cep.Text));
    
    if not Assigned(CEP) then
    Begin
      btn_pesq_cep.Caption := 'PESQUISAR CEP';
      ShowMessage('Cep não encontrado.');
      Exit; 
    End;
    try
      { dados não necessários no momento
      edtJSON.Lines.Text := CEP.ToJSONString;
      }
      
      Entidade_enderecoTable.FieldByName('CEP').AsString := CEP.CEP;
      Entidade_enderecoTable.FieldByName('LOGRADOURO').AsString := CEP.Logradouro;
      Entidade_enderecoTable.FieldByName('COMPLEMENTO').AsString := CEP.Complemento;
      Entidade_enderecoTable.FieldByName('BAIRRO').AsString := CEP.Bairro;
      Entidade_enderecoTable.FieldByName('CIDADE').AsString := CEP.Localidade;
      Entidade_enderecoTable.FieldByName('ESTADO').AsString := CEP.UF;
      Entidade_enderecoTable.FieldByName('PAIS').AsString := 'BR';
      { dados não necessários no momento
      Entidade_enderecoTable.FieldByName('').AsString := CEP.DDD;
      Entidade_enderecoTable.FieldByName('').AsString := CEP.IBGE;
      Entidade_enderecoTable.FieldByName('').AsString := CEP.GIA;
      }
    finally
      btn_pesq_cep.Caption := 'PESQUISAR CEP';
      if Assigned(CEP) then CEP.Free;
    end;
  End
  else
    ShowMessage('CEP inválido');
end;

procedure TFrmCadEntidade.btn_refreshClick(Sender: TObject);
begin
  inherited;
  TratarAcoesEntidadeEnderecos(aRefresh);
end;

procedure TFrmCadEntidade.btn_saveClick(Sender: TObject);
begin
  inherited;
  if dsEntidadeTable.State in [dsInsert,dsEdit] then
  Begin
    EntidadeTable.Post;
    EntidadeTable.Connection.Commit;
  End;
end;

procedure TFrmCadEntidade.CarregaDados(Acao: TAcao;ID: Integer = 0);
var 
  I: Integer;
  procedure AbrirTabelas;
  begin
    if not EntidadeTable.Active then EntidadeTable.Open;
    if not Tipo_enderecoTable.Active then Tipo_enderecoTable.Open;
    if not Tipo_entidadeTable.Active then Tipo_entidadeTable.Open;
    if not Tipo_pessoaTable.Active then Tipo_pessoaTable.Open;
    if not QryListEnderecos.Active then QryListEnderecos.Open;
    if not QryEndPrincipal.Active then QryEndPrincipal.Open;
  end;
begin
  
  for i := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[i] is TFDQuery then
    begin
      if TFDQuery(Self.Components[i]).Active then TFDQuery(Self.Components[i]).Close;
      TFDQuery(Self.Components[i]).ConnectionName := 'bd_dac';
      TFDQuery(Self.Components[i]).UpdateOptions.AutoCommitUpdates := False;
      TFDQuery(Self.Components[i]).UpdateOptions.FastUpdates := True;
    end;
  end;

  if Acao = aEdit then
  begin
    if ID > 0 then
    begin
      EntidadeTable.SQL.Clear;
      EntidadeTable.SQL.Add('SELECT * FROM ENTIDADE WHERE ID = '+IntToStr(ID));
      AbrirTabelas;
      EntidadeTable.Edit;
      EntidadeTable.Connection.StartTransaction;
    end;
  end
  else
  begin
    AbrirTabelas;
    EntidadeTable.Insert;    
    EntidadeTable.Connection.StartTransaction;
  end;
  
  
end;

procedure TFrmCadEntidade.dbchk_semnumClick(Sender: TObject);
begin
  inherited;
  if dbchk_semnum.Checked then
  Begin
    Entidade_enderecoTable.FieldByName('NUMERO').Clear;
  End
  
  
end;

procedure TFrmCadEntidade.dbedt_cpfcnpjEnter(Sender: TObject);
var
    I: integer;
    S, Texto: string;
begin
    S := '';
   Texto := dbedt_cpfcnpj.Text;

    for I := 1 to Length(Texto) do
    begin
        if (Texto[I] in ['0'..'9']) then
        begin
            S := S + Copy(Texto, I, 1);
        end;
    end;

    dbedt_cpfcnpj.Text := S;
end;

procedure TFrmCadEntidade.dbedt_cpfcnpjExit(Sender: TObject);
begin
  inherited;
  if Trim(dbedt_cpfcnpj.Text) <> '' then
  Begin
    if not ValidaCnpjCeiCpf(dbedt_cpfcnpj.Text) then
    begin
      ShowMessage('Favor informar um '+ifthen(EntidadeTable.FieldByName('COD_TIPO_PESSOA').AsInteger = 1,'CPF','CNPJ')+' válido.');
    end
    else
    Begin
      EntidadeTable.FieldByName('CPF_CNPJ').AsString := FormataDocumento(dbedt_cpfcnpj.Text);
    End;
  End;
end;

procedure TFrmCadEntidade.dbedt_mailExit(Sender: TObject);
begin
  inherited;
  if dbedt_mail.Text <> '' then
  Begin
    if not ValidarEMail(Trim(dbedt_mail.Text)) then
    begin
      ShowMessage('Informe um e-mail válido.');
    end;
  End;
end;

procedure TFrmCadEntidade.DBGridListEntidadeEnderecoDblClick(Sender: TObject);
begin
  inherited;
  if Pnl_control.Visible then
  begin
    
  end;
end;

procedure TFrmCadEntidade.dsEntidadeTableDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  AjustarCampos;
end;

procedure TFrmCadEntidade.dsEntidade_enderecoTableDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if Entidade_enderecoTable.FieldByName('FLG_SEM_NUMERO').AsInteger = 1 then
  begin
    dbedt_numero.Enabled := False;
  end
  else
  begin
    dbedt_numero.Enabled := True;
  end;
  
end;

procedure TFrmCadEntidade.EntidadeTableAfterInsert(DataSet: TDataSet);
begin
  inherited;
  EntidadeTable.FieldByName('COD_TIPO_PESSOA').AsInteger := 1;
  EntidadeTable.FieldByName('COD_TIPO_ENTIDADE').AsInteger := 1;
  EntidadeTable.FieldByName('COD_ENTIDADE_ENDERECO').Clear; 
end;

procedure TFrmCadEntidade.EntidadeTableBeforePost(DataSet: TDataSet);
begin
  inherited;
  if Trim(EntidadeTable.FieldByName('NOME').AsString) = '' then
  begin
    ShowMessage('Favor informar um nome.');
    Abort;
  end;

  if Trim(EntidadeTable.FieldByName('CPF_CNPJ').AsString) = '' then
  begin
    ShowMessage('Favor informar o '+ ifthen(EntidadeTable.FieldByName('COD_TIPO_PESSOA').AsInteger = 1,'CPF.','CNPJ.'));
    Abort;
  end
  else
  begin
    if not ValidaCnpjCeiCpf(EntidadeTable.FieldByName('CPF_CNPJ').AsString) then
    begin
      ShowMessage('Favor informar um '+ ifthen(EntidadeTable.FieldByName('COD_TIPO_PESSOA').AsInteger = 1,'CPF.','CNPJ.')+' válido.');    
      Abort;
    end;
  end;
  
  if Trim(EntidadeTable.FieldByName('EMAIL').AsString) <> '' then
  begin
    if not ValidarEMail(Trim(dbedt_mail.Text)) then
    begin
      ShowMessage('Informe um e-mail válido.');
      Abort;
    end;
  end;

end;

procedure TFrmCadEntidade.Entidade_enderecoTableAfterInsert(DataSet: TDataSet);
begin
  inherited;
  Entidade_enderecoTable.FieldByName('COD_ENTIDADE').AsInteger  := 
    EntidadeTable.FieldByName('ID').AsInteger;

  if EntidadeTable.FieldByName('COD_TIPO_PESSOA').AsInteger = 1 then
    Entidade_enderecoTable.FieldByName('COD_TIPO_ENDERECO').AsInteger  := 2
  else
    Entidade_enderecoTable.FieldByName('COD_TIPO_ENDERECO').AsInteger  := 1;
      
  Entidade_enderecoTable.FieldByName('FLG_SEM_NUMERO').AsInteger  := 0;  

end;

procedure TFrmCadEntidade.FormCreate(Sender: TObject);
begin
  inherited;
  SincGrid2 := TSincGrid.Create;
  pgctrl_entidade.ActivePageIndex := 0;
  pgctrl_enderecos.ActivePageIndex := 0;
  pgctrl_enderecos.Pages[1].TabVisible := False;
  SincGrid2.SetGrid(DBGridListEntidadeEndereco,dsQryListEnderecos);
end;

procedure TFrmCadEntidade.FormResize(Sender: TObject);
begin
  inherited;
  SincGrid2.SetGrid(DBGridListEntidadeEndereco,dsQryListEnderecos);
end;

procedure TFrmCadEntidade.FormShow(Sender: TObject);
begin
  inherited;
  AjustarCampos;
end;

procedure TFrmCadEntidade.tabs_enderecoShow(Sender: TObject);
begin
  inherited;
  
  if dsEntidadeTable.State in [dsInsert, dsEdit] then
  begin
    Pnl_control.Visible := False;  
    PnlBtn_edt_end.Visible := True;
    PnlBtn_list_end.Visible := True;
    //ShowMessage('Salve primeiro o cadatro pessoa antes de cadastra os endereços.');}
    EntidadeTable.Post;
    EntidadeTable.Connection.Commit;  
    
  end
  else
  Begin
    Pnl_control.Visible := False;  
    PnlBtn_edt_end.Visible := True;
    PnlBtn_list_end.Visible := True;
  End;
end;

procedure TFrmCadEntidade.tabs_end_edtShow(Sender: TObject);
begin
  inherited;
  pgctrl_enderecos.Pages[0].TabVisible := False;
end;

procedure TFrmCadEntidade.tabs_end_listShow(Sender: TObject);
begin
  inherited;
  pgctrl_enderecos.Pages[1].TabVisible := False;
end;

procedure TFrmCadEntidade.tabs_entidadeShow(Sender: TObject);
begin
  inherited;
  Pnl_control.Visible := True;  
end;

procedure TFrmCadEntidade.TratarAcoesEntidadeEnderecos(Acao: TAcao);
begin
  try
    if Acao = aAdd then
    begin
      pgctrl_enderecos.Pages[0].TabVisible := False;
      pgctrl_enderecos.Pages[1].TabVisible := True;
      {if Entidade_enderecoTable.Active then Entidade_enderecoTable.Close;
      Entidade_enderecoTable.SQL.Clear;
      Entidade_enderecoTable.SQL.Add(SQL_INSERT_ENDERECO);
      Entidade_enderecoTable.Open;}

      Controler.ConsultaBD.TConsultaBD.QueryOpen( Entidade_enderecoTable,
                                                  SQL_INSERT_ENDERECO                                                     
                                                );
      Entidade_enderecoTable.Connection.StartTransaction;
      Entidade_enderecoTable.Insert;                                              
      
    end
    else
    if Acao = aEdit then
    begin
      if QryListEnderecos.FieldByName('ID').AsInteger > 0 then
      Begin
        pgctrl_enderecos.Pages[0].TabVisible := False;
        pgctrl_enderecos.Pages[1].TabVisible := True;  

        Controler.ConsultaBD.TConsultaBD.QueryOpen(  Entidade_enderecoTable,
                                                     SQL_LIST_ENDERECO,
                                                     TParamList.Create
                                                     .Adiciona('VCP00',ftInteger,QryListEnderecos.FieldByName('ID').AsInteger)
                                                    );
        
        Entidade_enderecoTable.Connection.StartTransaction;
        Entidade_enderecoTable.Edit;
      end
      else
        ShowMessage('Não há registros para editar.');
    end
    else
    if Acao = aDel then
    begin
      if QryListEnderecos.FieldByName('ID').AsInteger > 0 then
      Begin
        if (MessageBox(0, PChar('Deseja realmente deletar este registo?'), 
          PChar(''), MB_ICONQUESTION or MB_YESNO) = idYes) then
        Begin  
          Try
            QryListEnderecos.Connection.StartTransaction;
            QryListEnderecos.Delete;
            QryListEnderecos.Connection.Commit;
            QryEndPrincipal.Refresh;
            QryListEnderecos.Refresh;
            ShowMessage('Exclusão realizada com sucesso.');
          Except
            QryListEnderecos.Connection.Rollback;
            ShowMessage('Erro ao tentar excluir.');
          End;
        End;

      End;
    end
    else
    if Acao = aRefresh then
    begin
      //Entidade_enderecoTable.Refresh;
      QryEndPrincipal.Refresh;
      QryListEnderecos.Refresh;
    end
    else
    if Acao = aSave then
    begin
      if dsEntidade_enderecoTable.State in [dsInsert,dsEdit] then 
      Entidade_enderecoTable.Post;
      Entidade_enderecoTable.Connection.Commit;
      QryEndPrincipal.Refresh;
      QryListEnderecos.Refresh;
    end
    else
    if Acao = aClose then
    begin
      if dsEntidade_enderecoTable.State in [dsInsert,dsEdit] then
      begin
        if (MessageBox(0, PChar('Existe dados não salvo, deseja continuar?'), 
        PChar(''), MB_ICONQUESTION or MB_YESNO) = idYes) then
        Begin  
          Entidade_enderecoTable.Cancel;
          Entidade_enderecoTable.Connection.Rollback;
          pgctrl_enderecos.Pages[0].TabVisible := True;
          pgctrl_enderecos.Pages[1].TabVisible := False;
        End;
      end
      else
      begin
        pgctrl_enderecos.Pages[0].TabVisible := True;
        pgctrl_enderecos.Pages[1].TabVisible := False;      
      end;
      QryEndPrincipal.Refresh;
      QryListEnderecos.Refresh;
    end;
  finally
    //Entidade_enderecoTable.Refresh;
    QryEndPrincipal.Refresh;
    QryListEnderecos.Refresh;
  end;
end;

end.
