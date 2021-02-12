unit View.FrmWorkBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.FrmDefaultSat, Model.GridSearch,
  Model.PanelHorizontControlerEx, Vcl.ComCtrls, scControls, Vcl.OleCtrls,
  SHDocVw, scWebBrowser, Model.PanelHorizontalDbBtnOperation, Model.FrameGeral,
  Model.PanelReportHorizont, Model.RelatoriosGeral, Data.DB, MemDS, DBAccess,
  uni, Model.BarraTituloGeral, Model.FmBarra, ACBrValidador, EComponent,
  DXC.UC.DatasetMonitor, System.IniFiles, Vcl.StdCtrls, System.Win.Registry,
  DBGridEh, Math, System.StrUtils, scGPExtControls, scGPDBControls,
  satup_db, scDBControls, Vcl.Mask, MyDataTypeMapUni, Model.DmBase,
  Model.PcnTyped, Model.Classe, DbUtilsEh, Model.ConstantsSQL, PrViewEh, Printers,
  Model.Constants, DBGridEhImpExp, PrnDbgeh;

type

  TFrmWorkBase = class(TFrmDefaultSystemSat)
    FmBarraTitulo: TFmBarra;
    PgCtrlFormEvents: TscPageControl;
    TabsEventList: TscTabSheet;
    TabsEventEdit: TscTabSheet;
    TabsEventReport: TscTabSheet;
    scWebBrowser: TscWebBrowser;
    Fm_GridSearch: TFm_GridSearch;
    Fm_PanelSelectionHorizont: TFm_PanelSelectionHorizont;
    FmPanelGeral: TFmPanelGeral;
    Fm_PanelButtonHorizont: TFm_PanelButtonHorizont;
    Fm_PanelReportHorizont: TFm_PanelReportHorizont;
    FmPanelRelarorio: TFmPanelRelarorio;
    DsUQryEdition: TDataSource;
    DsUQryReport: TDataSource;
    PgCtrlFormInfo: TscPageControl;
    tbsEventEditGeral: TscTabSheet;
    UQryEdition: TUniQuery;
    UQryReport: TUniQuery;
    SaveDialog1: TSaveDialog;
    procedure TFm_PanelSelectionHorizont1BtnReportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Fm_PanelSelectionHorizont1BtnReportClick(Sender: TObject);
    procedure Fm_PanelSelectionHorizont1BtnNewClick(Sender: TObject);
    procedure TFm_PanelReportHorizont1BtnExitClick(Sender: TObject);
    procedure TFm_PanelReportHorizont1SatUpGPButton1Click(Sender: TObject);
    procedure Fm_PanelSelectionHorizont1BtnExitClick(Sender: TObject);
    procedure TFm_PanelButtonHorizont1BtnVoltarClick(Sender: TObject);
    procedure Fm_PanelSelectionHorizont1BtnEditClick(Sender: TObject);
    procedure TabsEventListShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure UQryEditionBeforePost(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure tbsEventEditGeralShow(Sender: TObject);
    procedure tbsEventEditGeralHide(Sender: TObject);
    procedure UQryEditionAfterCancel(DataSet: TDataSet);
    procedure Fm_GridSearchUQryListAfterCancel(DataSet: TDataSet);
    procedure Fm_GridSearchUQryListAfterDelete(DataSet: TDataSet);
    procedure Fm_GridSearchUQryListAfterInsert(DataSet: TDataSet);
    procedure Fm_GridSearchUQryListAfterPost(DataSet: TDataSet);
    procedure Fm_GridSearchUQryListAfterRefresh(DataSet: TDataSet);
    procedure Fm_GridSearchDBGridListDblClick(Sender: TObject);
    procedure Fm_GridSearchDBGridListSortMarkingChanged(Sender: TObject);
    procedure Fm_PanelSelectionHorizontBtnFastPrintClick(Sender: TObject);
    procedure Fm_PanelSelectionHorizontBtnExportFileClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    vg_id_grid : string;
    vgSQLGETCONTAINER : string;
    vg_ini_gridlist_config : TCustomIniFile;


  procedure LoadListGridEx(vfDBGRID: TDBGridEh;
                         vfQryList: TUniQuery;
                         vfArrayFieldsShow, vfArrayFieldsTitles : TArrayofString;
                         vfArrayWidthunms: TArrayofInteger;
                         vfArrayFieldType: TArrayFieldType); overload;

   procedure LoadListGrid(vf_scriptsqlobjectview,vf_scriptsqlcondiction: string;
                           vfArrayAllFields, vfArrayInvisibleColunms: TArrayofString;
                           vfArrayWidthunms:TArrayofInteger;
                           vfArrayFieldType:TArrayFieldType); overload;

    procedure LoadListGrid(vf_scriptsqlobjectview,vf_scriptsqlcondiction: string;
                           vfArrayAllFields, vfArrayInvisibleColunms: TArrayofString;
                           vfArrayWidthunms:TArrayofInteger); overload;

    procedure CancelActionTables;
    function CloseTablesWithoutSave:Boolean;
    function CheckTablesIsInsertOrEdit:Boolean;
    function CheckFieldsRequerids(vfDataSource:TDataSource) :Boolean;
    function ValidFieldRequerid(vfField: TField;vfOptionsSatUP: TOptionsSatUP): string;

    procedure CheckStatusButtonManage();
  end;

const
  RaizList: string = 'SOFTWARE\SAMDI\SYSTEM\SATUP\CUSTONS\USER\%s\CFGGRID\%s';

var
  FrmWorkBase: TFrmWorkBase;

implementation

uses
  satup_std;

{$R *.dfm}



procedure TFrmWorkBase.CheckStatusButtonManage;
begin
  Fm_PanelSelectionHorizont.BtnReport.Enabled :=   Boolean( IfThen((Fm_GridSearch.UQryList.RecordCount = 0),0,1) );
  Fm_PanelSelectionHorizont.BtnEdit.Enabled   :=   Boolean( IfThen(Fm_GridSearch.UQryList.RecordCount = 0,0,1) );
  Fm_PanelSelectionHorizont.BtnCopiar.Enabled :=   Boolean( IfThen(Fm_GridSearch.UQryList.RecordCount = 0,0,1) );
  Fm_PanelSelectionHorizont.BtnSelect.Enabled :=   Boolean( IfThen(Fm_GridSearch.UQryList.RecordCount = 0,0,1) );
  Fm_PanelSelectionHorizont.BtnImport.Enabled :=   Boolean( IfThen(Fm_GridSearch.UQryList.RecordCount = 0,0,1) );
end;

function TFrmWorkBase.CheckTablesIsInsertOrEdit: Boolean;
var i : Integer;
begin
  Result := False;
  for i := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[i] is TUniQuery then
    begin
      if TUniQuery(Self.Components[i]).State in [dsEdit, dsInsert] then Result := True;

    end;

    if Self.Components[i] is TUniTable then
    Begin
      if TUniTable(Self.Components[i]).State in [dsEdit, dsInsert] then Result := True;
    End;
  end;
end;

procedure TFrmWorkBase.Fm_GridSearchDBGridListDblClick(Sender: TObject);
begin
  inherited;
  if Self.Fm_GridSearch.UQryList.RecordCount >  0 then
  begin
    if Self.Fm_GridSearch.UQryList.FieldByName('ID').AsInteger > 0 then
    begin
      Fm_PanelSelectionHorizont.BtnEdit.OnClick(Sender);
    end;
  end;
end;

procedure TFrmWorkBase.Fm_GridSearchDBGridListSortMarkingChanged(
  Sender: TObject);
begin
  inherited;
  Fm_GridSearch.DBGridListSortMarkingChanged(Sender);
end;

procedure TFrmWorkBase.Fm_GridSearchUQryListAfterCancel(DataSet: TDataSet);
begin
  inherited;
  CheckStatusButtonManage;
end;

procedure TFrmWorkBase.Fm_GridSearchUQryListAfterDelete(DataSet: TDataSet);
begin
  inherited;
  CheckStatusButtonManage;
end;

procedure TFrmWorkBase.Fm_GridSearchUQryListAfterInsert(DataSet: TDataSet);
begin
  inherited;
  CheckStatusButtonManage;
end;

procedure TFrmWorkBase.Fm_GridSearchUQryListAfterPost(DataSet: TDataSet);
begin
  inherited;
  CheckStatusButtonManage;
end;

procedure TFrmWorkBase.Fm_GridSearchUQryListAfterRefresh(DataSet: TDataSet);
begin
  inherited;
  CheckStatusButtonManage;
end;

procedure TFrmWorkBase.Fm_PanelSelectionHorizont1BtnEditClick(Sender: TObject);
begin
  inherited;
  if Fm_GridSearch.UQryList.FieldByName('ID').AsInteger > 0 then
  begin
    PgCtrlFormEvents.ActivePageIndex := 1;
    if UQryEdition.Active then UQryEdition.Close;
    UQryEdition.ParamByName('VCP00').AsInteger :=  Fm_GridSearch.UQryList.FieldByName('ID').AsInteger;
    if not UQryEdition.Prepared then UQryEdition.Prepare;
    UQryEdition.Open;
    UQryEdition.Edit;
  end;

end;

procedure TFrmWorkBase.Fm_PanelSelectionHorizont1BtnExitClick(
  Sender: TObject);
begin
  inherited;
  Self.Close;
  Fm_PanelSelectionHorizont.BtnExitClick(Sender);
end;

procedure TFrmWorkBase.Fm_PanelSelectionHorizont1BtnNewClick(
  Sender: TObject);
begin
  inherited;
  PgCtrlFormEvents.ActivePageIndex := 1;
end;

procedure TFrmWorkBase.Fm_PanelSelectionHorizont1BtnReportClick(
  Sender: TObject);
begin
  inherited;
  PgCtrlFormEvents.ActivePageIndex := 2;
end;

procedure TFrmWorkBase.Fm_PanelSelectionHorizontBtnExportFileClick(
  Sender: TObject);
var ExpClass:TDBGridEhExportClass;
    Ext:String;
begin
  SaveDialog1.FileName := 'NewFile';
  //if (ActiveControl is TDBGridEh) then
    if SaveDialog1.Execute then
    begin
      case SaveDialog1.FilterIndex of
        1: begin ExpClass := TDBGridEhExportAsText; Ext := 'txt'; end;
        2: begin ExpClass := TDBGridEhExportAsCSV; Ext := 'csv'; end;
        3: begin ExpClass := TDBGridEhExportAsHTML; Ext := 'htm'; end;
        4: begin ExpClass := TDBGridEhExportAsRTF; Ext := 'rtf'; end;
        5: begin ExpClass := TDBGridEhExportAsXLS; Ext := 'xls'; end;
        6: begin ExpClass := TDBGridEhExportAsXlsx; Ext := 'xlsx'; end;
        7: begin ExpClass := TDBGridEhExportAsOLEXLS; Ext := 'xls'; end;
      else
        ExpClass := nil; Ext := '';
      end;
      if ExpClass <> nil then
      begin
        if UpperCase(Copy(SaveDialog1.FileName,Length(SaveDialog1.FileName)-2,3)) <>
           UpperCase(Ext) then
          SaveDialog1.FileName := SaveDialog1.FileName + '.' + Ext;
        SaveDBGridEhToExportFile(ExpClass,TDBGridEh(Fm_GridSearch.DBGridList),
             SaveDialog1.FileName,True);
      end;
    end;
end;

procedure TFrmWorkBase.Fm_PanelSelectionHorizontBtnFastPrintClick(
  Sender: TObject);
var vlEND1, vlEND2 : string;
begin
  inherited;

  PrinterPreview.Previewer.ViewMode := VmPageWidth;
  PrinterPreview.Orientation := poLandscape;
  Fm_GridSearch.PrintDBGrid.PrintFontName := 'Courier New';
  Fm_GridSearch.PrintDBGrid.PageFooter.Font.Name := 'Courier New';
  Fm_GridSearch.PrintDBGrid.PageHeader.Font.Name := 'Courier New';
  Fm_GridSearch.PrintDBGrid.Page.BottomMargin := 1;
  Fm_GridSearch.PrintDBGrid.Page.LeftMargin   := 1;
  Fm_GridSearch.PrintDBGrid.Page.RightMargin  := 1;
  Fm_GridSearch.PrintDBGrid.Page.TopMargin    := 1;
  Fm_GridSearch.PrintDBGrid.Options := [pghFitGridToPageWidth,pghColored,pghOptimalColWidths];
  Fm_GridSearch.PrintDBGrid.AfterGridText.Clear;
  Fm_GridSearch.PrintDBGrid.BeforeGridText.Clear;

  vlEND1 := DmBase.SatTools.EmpresaEmitente.END_LOGRADOURO+', '+
            DmBase.SatTools.EmpresaEmitente.END_NUMERO+', '+
            DmBase.SatTools.EmpresaEmitente.END_COMPLEMENTO;
  vlEND2 := DmBase.SatTools.EmpresaEmitente.END_BAIRRO+' - '+
            DmBase.SatTools.EmpresaEmitente.END_CEP+' '+
            DmBase.SatTools.EmpresaEmitente.END_UF;


  {Fm_GridSearch.PrintDBGridEh.PageHeader.CenterText.Text := 'AQUI 1';
  Fm_GridSearch.PrintDBGridEh.PageHeader.LeftText.Text := 'AQUI 2';
   'AQUI 3';

  }

  Fm_GridSearch.PrintDBGrid.PageHeader.RightText.Text := 'Pag. &[Page] de &[Pages]';
  Fm_GridSearch.PrintDBGrid.PageFooter.LeftText.Text := 'Impressão: &[Date] as &[Time]';
  Fm_GridSearch.PrintDBGrid.PageFooter.RightText.Text := SATDESCICAORODAPELONGO;

  {Fm_GridSearch.PrintDBGrid.BeforeGridText.Add('Empresa   : '+DmBase.SatTools.EmpresaEmitente.IDENT_RAZAOSOCIAL);
  Fm_GridSearch.PrintDBGrid.BeforeGridText.Add('Endereço  : '+vlEND1+vlEND2);
  Fm_GridSearch.PrintDBGrid.BeforeGridText.Add('Telefones : '+DmBase.SatTools.EmpresaEmitente.CONTATO_TELEFONE1);
  Fm_GridSearch.PrintDBGrid.BeforeGridText.Add('E-mail    : '+DmBase.SatTools.EmpresaEmitente.CONTATO_EMAIL);}

  Fm_GridSearch.PrintDBGrid.PageHeader.LeftText.Add('Empresa   : '+DmBase.SatTools.EmpresaEmitente.IDENT_RAZAOSOCIAL);
  Fm_GridSearch.PrintDBGrid.PageHeader.LeftText.Add('Endereço  : '+vlEND1+vlEND2);
  Fm_GridSearch.PrintDBGrid.PageHeader.LeftText.Add('Telefones : '+DmBase.SatTools.EmpresaEmitente.CONTATO_TELEFONE1);
  Fm_GridSearch.PrintDBGrid.PageHeader.LeftText.Add('E-mail    : '+DmBase.SatTools.EmpresaEmitente.CONTATO_EMAIL);

  //Fm_GridSearch.PrintDBGrid.AfterGridText.Text := SATDESCICAORODAPELONGO;
  //Fm_GridSearch.PrintDBGrid.SetSubstitutes(['%[SAMDIPROMO]',SATDESCICAORODAPELONGO]);

  Fm_GridSearch.PrintDBGrid.Preview;
end;

procedure TFrmWorkBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Self.UQryEdition.Active then Self.UQryEdition.Close;
  Self.Fm_GridSearch.DBGridList.SaveColumnsLayout(Self.vg_ini_gridlist_config,'COLUMNS');
  Self.Fm_GridSearch.DBGridList.SaveGridLayout(Self.vg_ini_gridlist_config,'GRIDS');
  Self.vg_ini_gridlist_config.Free;

end;

procedure TFrmWorkBase.FormCreate(Sender: TObject);
var I : Integer;
    vl_i : Integer;
    vl_cod_usu, vl_raiz : string;
    OwnForm : TForm;
    x: Integer;
begin
  inherited;

  vg_id_grid := Self.Name+'00';
  vgSQLGETCONTAINER := '';
  PgCtrlFormEvents.ActivePageIndex :=  0;
  PgCtrlFormInfo.ActivePageIndex :=  0;
  PgCtrlFormEvents.HideBorder := True;
  PgCtrlFormEvents.HideTabs := True;

  Fm_GridSearch.UQryList.DataTypeMap.AddDBTypeRule(myText,ftString,true);
  Fm_GridSearch.UQryList.DataTypeMap.AddDBTypeRule(myChar,ftString,true);
  Fm_GridSearch.UQryList.DataTypeMap.AddDBTypeRule(myVarchar,ftString,true);

  Fm_GridSearch.UQryList.DataTypeMap.AddDBTypeRule(myTinyText,ftString,true);
  Fm_GridSearch.UQryList.DataTypeMap.AddDBTypeRule(myText,ftString,true);

  Fm_GridSearch.UQryList.DataTypeMap.AddDBTypeRule(myTinyBlob,ftString,true);
  Fm_GridSearch.UQryList.DataTypeMap.AddDBTypeRule(myBlob,ftString,true);



  {for I := 0 to Fm_GridSearch.UQryList.DataTypeMap.Count-1 do
  begin
    if Fm_GridSearch.UQryList.DataTypeMap.Items[I].FieldType in [ftString] then
    begin
      Fm_GridSearch.UQryList.DataTypeMap.Items[I].FieldLength := 500;
    end;
  end;}


  for i := 0 to Application.ComponentCount - 1 do
  begin
    if Application.Components[i] is TForm then
      if TForm(Application.Components[i]).Name = 'FrmMain' then
      begin
        OwnForm := TForm(Application.Components[i]);
        for x := 0 to OwnForm.ComponentCount -1 do
        begin
          if OwnForm.Components[x] is TEdit then
          begin
            if TEdit(OwnForm.Components[x]).Name = 'edtUSERID' then
            begin
              vl_cod_usu := ifthen(TEdit(OwnForm.Components[x]).Text <> '',TEdit(OwnForm.Components[x]).Text,'0');

              //Break;
            end;
          end;
        end;
      end;
  end;

  vl_raiz := format(RaizList, [vl_cod_usu,vg_id_grid]);
  Self.vg_ini_gridLIST_config :=  TRegistryIniFile.Create(vl_raiz);

  Fm_GridSearch.DBGridList.SortLocal := True;
  DbUtilsEh.SQLFilterMarker := ' 1=1 AND';
end;

procedure TFrmWorkBase.FormShow(Sender: TObject);
begin
  inherited;
  if UQryEdition.Active then UQryEdition.Close;
  UQryEdition.SQL.Clear;

{  if Pos('WHERE',vgSQLGETCONTAINER) <> 0 then
  begin
    // O SQL CONTEM WHERE

  end
  else
  begin

  end;}

  UQryEdition.SQL.Add(vgSQLGETCONTAINER+' AND `ID`=:VCP00');
  Fm_GridSearch.DBGridList.RestoreColumnsLayout(vg_ini_gridlist_config,'COLUMNS',[crpColIndexEh,crpColWidthsEh,crpSortMarkerEh,crpColVisibleEh,crpDropDownRowsEh,crpDropDownWidthEh,crpRowPanelColPlacementEh]);
  Fm_GridSearch.DBGridList.RestoreGridLayout(vg_ini_gridlist_config,'GRIDS',[grpColIndexEh,grpColWidthsEh,grpSortMarkerEh,grpColVisibleEh,grpRowHeightEh,grpDropDownRowsEh,grpDropDownWidthEh,grpRowPanelColPlacementEh]);
  CheckStatusButtonManage;
end;

procedure TFrmWorkBase.TabsEventListShow(Sender: TObject);
begin
  inherited;
  if Fm_GridSearch.UQryList.Active then  Fm_GridSearch.UQryList.Refresh;
end;

procedure TFrmWorkBase.tbsEventEditGeralHide(Sender: TObject);
begin
  inherited;
  Fm_PanelButtonHorizont.Visible := False;
end;

procedure TFrmWorkBase.tbsEventEditGeralShow(Sender: TObject);
begin
  inherited;
  Fm_PanelButtonHorizont.Visible := True;
end;

procedure TFrmWorkBase.TFm_PanelButtonHorizont1BtnVoltarClick(Sender: TObject);
var i : Integer;
begin
  if CloseTablesWithoutSave then
  begin
    CancelActionTables;
  end;
  inherited;
  PgCtrlFormEvents.ActivePageIndex := 0;
end;

procedure TFrmWorkBase.TFm_PanelReportHorizont1BtnExitClick(
  Sender: TObject);
begin
  inherited;
  Fm_PanelReportHorizont.BtnExitClick(Sender);
end;

procedure TFrmWorkBase.TFm_PanelReportHorizont1SatUpGPButton1Click(
  Sender: TObject);
begin
  inherited;
  PgCtrlFormEvents.ActivePageIndex := 0;
end;

procedure TFrmWorkBase.TFm_PanelSelectionHorizont1BtnReportClick(Sender: TObject);
begin
  inherited;
  Self.Hide;
end;

procedure TFrmWorkBase.UQryEditionAfterCancel(DataSet: TDataSet);
begin
  inherited;
  //Fm_PanelButtonHorizont.BtnVoltar.OnClick(Self);
end;

procedure TFrmWorkBase.UQryEditionBeforePost(DataSet: TDataSet);
begin
  inherited;
  //PgCtrlFormInfo.ActivePageIndex := 0;
end;

function TFrmWorkBase.ValidFieldRequerid(vfField: TField;vfOptionsSatUP: TOptionsSatUP): string;
begin
  try
    Result := '';
    case vfField.DataType of
      ftString,
      ftMemo,
      ftFmtMemo,
      ftFixedChar,
      ftWideString,
      ftFixedWideChar,
      ftWideMemo       :begin
                        if (vfField.AsString = '') or
                         (vfField.IsNull) then
                          Result  := vfOptionsSatUP.FocusLabeCaption.Caption;
                       end;

      ftSmallint,
      ftInteger,
      ftWord      :begin
                      if (vfField.AsInteger = 0) or
                         (vfField.IsNull) then
                          Result  := vfOptionsSatUP.FocusLabeCaption.Caption;
                   end;


      ftFloat,
      ftExtended,
      ftCurrency  :begin
                      if (vfField.AsFloat = 0.0) or
                         (vfField.IsNull) then
                          Result  := vfOptionsSatUP.FocusLabeCaption.Caption;
                   end;



      ftDate,
      ftTime,
      ftDateTime  :begin
                      if (vfField.AsInteger = 0) or
                         (vfField.AsString = '30/12/1899 00:00:00') or
                         (vfField.AsString = '30/12/1899') or
                         (vfField.AsString = '00:00:00') or
                         (vfField.IsNull) then
                          Result  := vfOptionsSatUP.FocusLabeCaption.Caption;
                   end;

      ftBoolean   :begin
                      if (vfField.IsNull) then
                          Result  := vfOptionsSatUP.FocusLabeCaption.Caption;
                   end;

    else
      Result := '';
    end;
  finally
    if Result <> '' then
    begin
      Result := '"'+Result+'"';
    end;
  end;

end;

procedure TFrmWorkBase.LoadListGrid(vf_scriptsqlobjectview,vf_scriptsqlcondiction: string;
                                    vfArrayAllFields, vfArrayInvisibleColunms: TArrayofString;
                                    vfArrayWidthunms:TArrayofInteger);
var vl_totalfield, I,Z, ColumnWidth : Integer;
    vl_nomefield : string;
begin
  with Fm_GridSearch do
  begin
    DBGridList.AutoFitColWidths := False;
    vl_totalfield := Length(vfArrayAllFields);
    try
      if UQryList.Active then  UQrylist.Close;
      UQryList.SQL.Clear;
      UQryList.SQL.Add('select * from '+vf_scriptsqlobjectview+' '+vf_scriptsqlcondiction);
      if not UQryList.Prepared then UQryList.Prepare;
      UQryList.Execute;
    finally
      for I := 0 to vl_totalfield-1 do
      begin
        vl_nomefield := vfArrayAllFields[I];
        DBGridList.Columns[I].Title.Caption := vl_nomefield;
      end;

      for I := 0 to Length(vfArrayInvisibleColunms)-1 do
      begin
          for Z := 0 to DBGridList.Columns.Count-1 do
          Begin
            if (vfArrayWidthunms[Z] > 0 ) then DBGridList.Columns[Z].Width := vfArrayWidthunms[Z];
            if DBGridList.Columns[Z].FieldName = vfArrayInvisibleColunms[I] then
            begin
              DBGridList.Columns[Z].Visible := False;
            end;
          End;
      end;

      for Z := 0 to DBGridList.Columns.Count-1 do
      Begin
        if DBGridList.Columns[Z].Visible then
        begin
         { ColumnWidth := DBGridList.Columns[Z].Width + vfArrayWidthunms[Z];
          if (vfArrayWidthunms[Z] > 0 ) then DBGridList.Columns[Z].Width := ColumnWidth;}
          DBGridList.Columns[Z].MinWidth := IfThen(vfArrayWidthunms[Z]>0,vfArrayWidthunms[Z],0);
        end
        else
        begin
          DBGridList.Columns[Z].Width := 0;
        end;
      End;

    end;
    DBGridList.Repaint;
    DBGridList.AutoFitColWidths := True;
  end;
end;

procedure TFrmWorkBase.LoadListGridEx(vfDBGRID: TDBGridEh;
                                    vfQryList: TUniQuery;
                                    vfArrayFieldsShow, vfArrayFieldsTitles : TArrayofString;
                                    vfArrayWidthunms: TArrayofInteger;
                                    vfArrayFieldType: TArrayFieldType);
var vl_totalfield, I,Z,X, ColumnWidth : Integer;
    vl_nomefield : string;
begin
  with Fm_GridSearch do
  begin
    DBGridList.AutoFitColWidths := False;
    try
      vl_totalfield := Length(vfArrayFieldsTitles);
      vfDBGRID.Columns.Clear;
      if not vfQryList.Active then  vfQryList.Open;
    finally
      for I := 0 to Length(vfArrayFieldsShow)-1 do
      begin
         with vfDBGRID.Columns.Add do
         begin
           FieldName := vfArrayFieldsShow[I];
         end;
      end;

      for I := 0 to vl_totalfield-1 do
      begin
        vl_nomefield := vfArrayFieldsTitles[I];
        vfDBGRID.Columns[I].Title.Caption := vl_nomefield;
      end;

      for Z := 0 to vfDBGRID.Columns.Count-1 do
      Begin
        if vfDBGRID.Columns[Z].Visible then
        begin
          {ColumnWidth := vfDBGRID.Columns[Z].Width + vfArrayWidthunms[Z];
          if (vfArrayWidthunms[Z] > 0 ) then vfDBGRID.Columns[Z].Width := ColumnWidth;}
          DBGridList.Columns[Z].MinWidth := IfThen(vfArrayWidthunms[Z]>0,vfArrayWidthunms[Z],0);
        end
        else
        begin
          vfDBGRID.Columns[Z].Width := 0;
        end;
      End;

      for X := 0 to vl_totalfield-1 do
      Begin
        case vfArrayFieldType[X] of

          ftString    :begin
                        TStringField(vfQryList.FieldByName(vfArrayFieldsShow[X])).AsString;
                        //vfQryList.FieldByName(vfArrayFieldsShow[X]).AsString;
                       end;

          ftSmallint,
          ftInteger,
          ftWord      :begin
                        TIntegerField(vfQryList.FieldByName(vfArrayFieldsShow[X])).AsInteger;
                        TIntegerField(vfQryList.FieldByName(vfArrayFieldsShow[X])).Alignment := taLeftJustify;
                        //vfQryList.FieldByName(vfArrayFieldsShow[X]).AsInteger;
                       end;


          ftFloat     :begin
                        TFloatField(vfQryList.FieldByName(vfArrayFieldsShow[X])).DisplayFormat := '#,##0.00 %';
                        TFloatField(vfQryList.FieldByName(vfArrayFieldsShow[X])).EditFormat := '#,##0.00';
                        TFloatField(vfQryList.FieldByName(vfArrayFieldsShow[X])).Alignment := taCenter;
                       end;

          ftExtended  :begin
                        TFloatField(vfQryList.FieldByName(vfArrayFieldsShow[X])).DisplayFormat := '#,##0.000';
                        TFloatField(vfQryList.FieldByName(vfArrayFieldsShow[X])).EditFormat := '#,##0.000';
                        TFloatField(vfQryList.FieldByName(vfArrayFieldsShow[X])).Alignment := taCenter;
                       end;

          ftCurrency  :begin
                        TFloatField(vfQryList.FieldByName(vfArrayFieldsShow[X])).currency := True;
                        //vfQryList.FieldByName(vfArrayFieldsShow[X]).AsCurrency;
                        TFloatField(vfQryList.FieldByName(vfArrayFieldsShow[X])).Alignment := taRightJustify;
                       end;

          ftDate      :begin
                        TDateField(vfQryList.FieldByName(vfArrayFieldsShow[X])).DisplayFormat := 'dd/mm/yyyy';
                        TDateField(vfQryList.FieldByName(vfArrayFieldsShow[X])).Alignment := taCenter;
                       end;

          ftTime      :begin
                        TTimeField(vfQryList.FieldByName(vfArrayFieldsShow[X])).DisplayFormat := 'hh:nn:ss';
                        TTimeField(vfQryList.FieldByName(vfArrayFieldsShow[X])).Alignment := taCenter;
                       end;

          ftDateTime  :begin
                        TDateTimeField(vfQryList.FieldByName(vfArrayFieldsShow[X])).DisplayFormat := 'dd/mm/yyyy hh:nn:ss';
                        TDateTimeField(vfQryList.FieldByName(vfArrayFieldsShow[X])).Alignment := taCenter;
                       end;

          ftBoolean   :begin
                        TBooleanField(vfQryList.FieldByName(vfArrayFieldsShow[X])).AsBoolean;
                        TBooleanField(vfQryList.FieldByName(vfArrayFieldsShow[X])).Alignment := taCenter;
                        //vfQryList.FieldByName(vfArrayFieldsShow[X]).AsBoolean;
                       end;
        end;
      End;
    end;
    vfDBGRID.Repaint;
    vfDBGRID.AutoFitColWidths := True;
  end;
end;

procedure TFrmWorkBase.LoadListGrid(vf_scriptsqlobjectview,vf_scriptsqlcondiction: string;
                                    vfArrayAllFields, vfArrayInvisibleColunms: TArrayofString;
                                    vfArrayWidthunms:TArrayofInteger;
                                    vfArrayFieldType:TArrayFieldType);
var vl_totalfield, I,Z,X, ColumnWidth : Integer;
    vl_nomefield : string;
begin
  with Fm_GridSearch do
  begin
    DBGridList.AutoFitColWidths := False;
    vl_totalfield := Length(vfArrayAllFields);
    try
      if UQryList.Active then  UQrylist.Close;
      UQryList.SQL.Clear;
      UQryList.SQL.Add('select * from '+vf_scriptsqlobjectview+' '+vf_scriptsqlcondiction);
      if not UQryList.Prepared then UQryList.Prepare;
      UQryList.Execute;
    finally
      for I := 0 to vl_totalfield-1 do
      begin
        vl_nomefield := vfArrayAllFields[I];
        DBGridList.Columns[I].Title.Caption := vl_nomefield;
      end;

      for I := 0 to Length(vfArrayInvisibleColunms)-1 do
      begin
        for Z := 0 to DBGridList.Columns.Count-1 do
        Begin
          if (vfArrayWidthunms[Z] > 0 ) then DBGridList.Columns[Z].Width := vfArrayWidthunms[Z];
          if DBGridList.Columns[Z].FieldName = vfArrayInvisibleColunms[I] then
          begin
            DBGridList.Columns[Z].Visible := False;
          end;
        End;
      end;

      for Z := 0 to DBGridList.Columns.Count-1 do
      Begin
        if DBGridList.Columns[Z].Visible then
        begin
          {ColumnWidth := DBGridList.Columns[Z].Width + vfArrayWidthunms[Z];
          if (vfArrayWidthunms[Z] > 0 ) then DBGridList.Columns[Z].Width := ColumnWidth;}
          DBGridList.Columns[Z].MinWidth := IfThen(vfArrayWidthunms[Z]>0,vfArrayWidthunms[Z],0);
        end
        else
        begin
          DBGridList.Columns[Z].MinWidth := 0;
        end;
      End;

      for X := 0 to UQryList.Fields.Count-1 do
      Begin
        case vfArrayFieldType[X] of

          ftString    :begin
                        TStringField(UQryList.Fields[X]).AsString;
                        //UQryList.Fields[X].AsString;
                       end;

          ftSmallint,
          ftInteger,
          ftWord      :begin
                        TIntegerField(UQryList.Fields[X]).AsInteger;
                        TIntegerField(UQryList.Fields[X]).Alignment := taCenter;
                        //UQryList.Fields[X].AsInteger;
                       end;


          ftFloat     :begin
                        TFloatField(UQryList.Fields[X]).DisplayFormat := '#,##0.00 %';
                        TFloatField(UQryList.Fields[X]).EditFormat := '#,##0.00';
                        TFloatField(UQryList.Fields[X]).Alignment := taCenter;
                       end;

          ftExtended  :begin
                        TFloatField(UQryList.Fields[X]).DisplayFormat := '#,##0.000';
                        TFloatField(UQryList.Fields[X]).EditFormat := '#,##0.000';
                        TFloatField(UQryList.Fields[X]).Alignment := taCenter;
                       end;

          ftCurrency  :begin
                        TFloatField(UQryList.Fields[X]).currency := True;
                        //UQryList.Fields[X].AsCurrency;
                        TFloatField(UQryList.Fields[X]).Alignment := taRightJustify;
                       end;

          ftDate      :begin
                        TDateField(UQryList.Fields[X]).DisplayFormat := 'dd/mm/yyyy';
                        TDateField(UQryList.Fields[X]).Alignment := taCenter;
                       end;

          ftTime      :begin
                        TTimeField(UQryList.Fields[X]).DisplayFormat := 'hh:nn:ss';
                        TTimeField(UQryList.Fields[X]).Alignment := taCenter;
                       end;

          ftDateTime  :begin
                        TDateTimeField(UQryList.Fields[X]).DisplayFormat := 'dd/mm/yyyy hh:nn:ss';
                        TDateTimeField(UQryList.Fields[X]).Alignment := taCenter;
                       end;

          ftBoolean   :begin
                        TBooleanField(UQryList.Fields[X]).AsBoolean;
                        TBooleanField(UQryList.Fields[X]).Alignment := taCenter;
                        //UQryList.Fields[X].AsBoolean;
                       end;
        end;
      End;
    end;
    DBGridList.Repaint;
    DBGridList.AutoFitColWidths := True;
  end;
end;

procedure TFrmWorkBase.CancelActionTables;
var i : Integer;
begin
  for i := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[i] is TUniQuery then
    begin
      if TUniQuery(Self.Components[i]).State in [dsEdit, dsInsert] then TUniQuery(Self.Components[i]).Cancel;

    end;

    if Self.Components[i] is TUniTable then
    Begin
      if TUniTable(Self.Components[i]).State in [dsEdit, dsInsert] then TUniQuery(Self.Components[i]).Cancel;
    End;
  end;
end;

function TFrmWorkBase.CheckFieldsRequerids(vfDataSource:TDataSource): Boolean;
var
  I: Integer;
  vlmsn, vlmsnContainer : string;
  AownerClasse : TClass;
  AownerComponents : TComponent;

begin
  try
    vlmsn := '';
    vlmsnContainer := '';
    for I := 0 to Self.ComponentCount-1 do
    begin
      AownerClasse     := Self.Components[I].ClassType;
      AownerComponents := Self.Components[I];
      if  (AownerClasse.ClassName = 'TSatUpGPEdit') or
          (AownerClasse.ClassName = 'TSatUpGPComboEdit') or
          (AownerClasse.ClassName = 'TSatUpGPNumericEdit') or
          (AownerClasse.ClassName = 'TSatUpGPTimeEdit') or
          (AownerClasse.ClassName = 'TSatUpGPPasswordEdit') or
          (AownerClasse.ClassName = 'TSatUpGPDateEdit') or
          (AownerClasse.ClassName = 'TSatUpGPSpinEdit') or
          (AownerClasse.ClassName = 'TSatUpGPMemo') or
          (AownerClasse.ClassName = 'TSatUpGPComboBox') or
          (AownerClasse.ClassName = 'TSatUpGPButton')  or

          (AownerClasse.ClassName = 'TSatUpGPDBEdit') or
          (AownerClasse.ClassName = 'TSatUpGPDBComboEdit') or
          (AownerClasse.ClassName = 'TSatUpGPDBNumericEdit') or
          (AownerClasse.ClassName = 'TSatUpGPDBTimeEdit') or
          (AownerClasse.ClassName = 'TSatUpGPDBPasswordEdit') or
          (AownerClasse.ClassName = 'TSatUpGPDBDateEdit') or
          (AownerClasse.ClassName = 'TSatUpGPDBSpinEdit') or
          (AownerClasse.ClassName = 'TSatUpGPDBMemo') or
          (AownerClasse.ClassName = 'TSatUpGPDBComboBox') or
          (AownerClasse.ClassName = 'TSatUpGPDBButton') or
          (AownerClasse.ClassName = 'TSatUpDBLookUpComboBox')
          then
      Begin
        //TSatUpDBLookUpComboBox
        if AownerClasse.ClassName = 'TSatUpGPDBEdit'then
        begin
          if vfDataSource =  TSatUpGPDBEdit(AownerComponents).DataSource then
          Begin
            if TSatUpGPDBEdit(AownerComponents).SatUPOptions.InputRequired then
            Begin
              vlmsnContainer := ValidFieldRequerid(TSatUpGPDBEdit(AownerComponents).Field,
                                                   TSatUpGPDBEdit(AownerComponents).SatUPOptions
                                                  );
              if vlmsnContainer <> '' then
                 vlmsn := vlmsn +  vlmsnContainer +#13#10;

            End;
          End;
        end;

        if AownerClasse.ClassName = 'TSatUpDBLookUpComboBox'then
        begin
          if vfDataSource =  TSatUpDBLookUpComboBox(AownerComponents).DataSource then
          Begin
            if TSatUpDBLookUpComboBox(AownerComponents).SatUPOptions.InputRequired then
            Begin
              vlmsnContainer := ValidFieldRequerid(TSatUpDBLookUpComboBox(AownerComponents).Field,
                                                   TSatUpDBLookUpComboBox(AownerComponents).SatUPOptions
                                                  );
              if vlmsnContainer <> '' then
                 vlmsn := vlmsn +  vlmsnContainer +#13#10;

            End;
          End;
        end;


      End;
    end;
  finally
    if vlmsn <> '' then
    begin
      Result := False;
      DmBase.SatTools.Utilities.ShowMessageEx('Atenção',
                                              'Os seguintes campos são obrigatórios:'+#13#10+#13#10+vlmsn,
                                              msStop
                                             );
    end
    else
      Result := True;
  end;
end;

function TFrmWorkBase.CloseTablesWithoutSave:Boolean;
begin
  Result := False;
  if CheckTablesIsInsertOrEdit then
  begin
    if Application.MessageBox('Existem dados não salvo, deseja sair sem salvar ?',
      'ATENÇÃO', MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2) = IDYES then
    begin
      Result := True;
    end
    else
      Abort;
  end;
end;

end.
