unit Controler.SincGrid;

interface

uses Messages, SysUtils, Variants, Classes, Controls,
  Dialogs, ExtCtrls, Graphics, DB, Model.ConstantsGerais, Contnrs, Vcl.DBGrids,
  Vcl.Grids,
  Winapi.Windows;

type

  TItemGrid = class
    fGrid: TDBGrid;
  public
    property Grid: TDBGrid read fGrid write fGrid;
  end;

  TItemsGrids = Class(TObjectList)
  private
    function GetItems(Index: Integer): TItemGrid;
    procedure SetItems(Index: Integer; const Value: TItemGrid);
  public
    function Add(AObject: TItemGrid): Integer;
    property Items[Index: Integer]: TItemGrid read GetItems
      write SetItems; default;
  End;

  TSincGrid = class(TObject)
  private
    FGrid: TDBGrid;
    fItemsGrids: TItemsGrids;
    procedure SetItens(const Value: TItemsGrids);
  public
    constructor Create;
    destructor Destroy; override;
    procedure FormataColunas;
    procedure SetGrid(ImputGrid: TDBGrid; ImputDataSource: TDataSource);
    procedure AjustaTituloNomeColuna;
    procedure AjustaLarguraColunaGrid_V1;
    procedure AjustaLarguraColunaGrid_V2;
    procedure GridCustomDrawCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    function RetornaLarguraCampo(Campo: String) : Integer;
    property Grid: TDBGrid read FGrid write FGrid;
    property ItemsGrids: TItemsGrids read fItemsGrids write SetItens;
  end;

implementation

{ TSincGrid }

procedure TSincGrid.AjustaTituloNomeColuna;
var
  I, x: Integer;
begin
  for I := 0 to Self.FGrid.Columns.Count - 1 do
  Begin
    for x := Low(FIELDNAMEDEF) to High(FIELDNAMEDEF) do
    Begin
      if FIELDNAMEDEF[x].FieldName = Self.FGrid.Columns[I].FieldName then
      Begin
        Self.FGrid.Columns[I].Title.Caption := FIELDNAMEDEF[x].FieldReName;
      end;
    end;
  end;

end;

constructor TSincGrid.Create;
begin
  Self.FGrid := nil;
  // Definir aqui as cores padrões do grid
end;

destructor TSincGrid.Destroy;
begin

  inherited;
end;

procedure TSincGrid.SetGrid(ImputGrid: TDBGrid; ImputDataSource: TDataSource);
begin
  if ImputDataSource.DataSet.Active then
  Begin
    Self.FGrid := ImputGrid;
    Self.FGrid.DataSource := ImputDataSource;
    Self.FGrid.OnDrawColumnCell := GridCustomDrawCell;
    Self.FormataColunas;
  End;
end;

procedure TSincGrid.FormataColunas;
var
  I: Integer;
  ABestWidth, AActualWidth: Integer;
begin
  Self.FGrid.Columns.Clear;
  Self.FGrid.Options := Self.FGrid.Options - [dgEditing];
  Self.FGrid.Options := Self.FGrid.Options + [dgRowSelect];

  { Colunas dinâmicas }
  for I := 0 to Self.FGrid.Columns.Count - 1 do
  begin
    // Default para todos
    Self.FGrid.Columns[I].ReadOnly := False;

    // Aplica Formatação padrão as colunas
    case Self.FGrid.Columns[I].Field.DataType of
      ftDate, ftDateTime:
        begin
          Self.FGrid.Columns[I].Alignment := taCenter;
          TDateField(Self.FGrid.Columns[I].Field).DisplayFormat := 'dd/mm/yyyy';
        end;

      ftfloat:
        begin
          Self.FGrid.Columns[I].Alignment := taRightJustify;
          TFloatField(Self.FGrid.Columns[I].Field).DisplayFormat :=
            ',0.00;-,0.00';
        end;

      ftCurrency:
        begin
          Self.FGrid.Columns[I].Alignment := taRightJustify;
          TCurrencyField(Self.FGrid.Columns[I].Field).DisplayFormat :=
            'R$ #,##0.00';
        end;

    else
      Self.FGrid.Columns[I].Alignment := taLeftJustify;
    end;

    with Self.FGrid do
    begin
      if Columns[I].Visible then
      Begin
        // Implementar outras tratativas
      End;
    end;
    Self.AjustaTituloNomeColuna;
    AjustaLarguraColunaGrid_V2;
  end;
end;

procedure TSincGrid.GridCustomDrawCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

  // Define a formatação do texto e layout do grid pardrão
  if (gdSelected in State) or (gdFocused in State) then
    TDBGrid(Sender).Canvas.Brush.Color := clGradientInactiveCaption
  else
    TDBGrid(Sender).Canvas.Brush.Color := clWindow;
  {
  if DataCol = 0 then
    TDBGrid(Sender).Canvas.Font.Color := clGreen;

  if DataCol = 2 then
    TDBGrid(Sender).Canvas.Brush.Color := clAqua;
  }
  Grid.Canvas.FillRect(Rect);
  TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

function TSincGrid.RetornaLarguraCampo(Campo: String): Integer;
var
  I, x: Integer;
begin
  Result := 0;
  for I := 0 to Self.FGrid.Columns.Count - 1 do
  Begin
    for x := Low(FIELDNAMEDEF) to High(FIELDNAMEDEF) do
    Begin
      if FIELDNAMEDEF[x].FieldName = Campo then
      Begin
        Result := FIELDNAMEDEF[x].FieldWith;
        Break;
      end;
    end;
  end;
end;

{ TItemsGrids }

function TItemsGrids.GetItems(Index: Integer): TItemGrid;
begin
  Result := TItemGrid(inherited Items[Index]);
end;

procedure TItemsGrids.SetItems(Index: Integer; const Value: TItemGrid);
begin
  inherited Items[Index] := Value;
end;

function TItemsGrids.Add(AObject: TItemGrid): Integer;
begin
  Result := inherited Add(AObject);
end;

procedure TSincGrid.SetItens(const Value: TItemsGrids);
begin
  fItemsGrids := Value;
end;

procedure TSincGrid.AjustaLarguraColunaGrid_V1;
var
  I, TotalWidht, VarWidth, QtdTotalColuna: Integer;
  xColumn: TColumn;
begin
  // Largura total de todas as colunas antes de redimensionar
  TotalWidht := 0;
  // Como dividir todo o espaço extra na grade
  VarWidth := 0;
  // Quantas colunas devem ser auto-redimensionamento
  QtdTotalColuna := 0;

  for I := 0 to -1 + Self.FGrid.Columns.Count do
  begin
    TotalWidht := TotalWidht + Self.FGrid.Columns[I].Width;
    if RetornaLarguraCampo(Self.FGrid.Columns[I].FieldName) <> 0 then
      Inc(QtdTotalColuna);
  end;

  // Adiciona 1px para a linha de separador de coluna
  if dgColLines in Self.FGrid.Options then
    TotalWidht := TotalWidht + Self.FGrid.Columns.Count;

  // Adiciona a largura da coluna indicadora
  if dgIndicator in Self.FGrid.Options then
    TotalWidht := TotalWidht + IndicatorWidth;

  // width vale "Left"
  VarWidth := Self.FGrid.ClientWidth - TotalWidht;

  // Da mesma forma distribuir VarWidth para todas as colunas auto-resizable
  if QtdTotalColuna > 0 then
    VarWidth := VarWidth div QtdTotalColuna;


  for I := 0 to -1 + Self.FGrid.Columns.Count do
  begin
    xColumn := Self.FGrid.Columns[I];

    if RetornaLarguraCampo(xColumn.FieldName) <> 0 then
    begin
      xColumn.Width := xColumn.Width + VarWidth;
      if xColumn.Width < RetornaLarguraCampo(xColumn.FieldName) then
        xColumn.Width := RetornaLarguraCampo(xColumn.FieldName);
    end;
  end;
end;

procedure TSincGrid.AjustaLarguraColunaGrid_V2;
type
  TArray = Array of Integer;
  procedure AjustarColumns(Swidth, TSize: Integer; Asize: TArray);
  var
    idx: Integer;
  begin
    if TSize = 0 then
    begin
      TSize := Self.FGrid.Columns.count;
      for idx := 0 to Self.FGrid.Columns.count - 1 do
        Self.FGrid.Columns[idx].Width := (Self.FGrid.Width - Self.FGrid.Canvas.TextWidth('AAAAAA')
          ) div TSize
    end
    else
      for idx := 0 to Self.FGrid.Columns.count - 1 do
        Self.FGrid.Columns[idx].Width := Self.FGrid.Columns[idx].Width +
          (Swidth * Asize[idx] div TSize);
  end;

var
  idx, Twidth, TSize, Swidth: Integer;
  AWidth: TArray;
  Asize: TArray;
  NomeColuna: String;
begin
  SetLength(AWidth, Self.FGrid.Columns.count);
  SetLength(Asize, Self.FGrid.Columns.count);
  Twidth := 0;
  TSize := 0;
  for idx := 0 to Self.FGrid.Columns.count - 1 do
  begin
    NomeColuna := Self.FGrid.Columns[idx].Title.Caption;
    Self.FGrid.Columns[idx].Width := Self.FGrid.Canvas.TextWidth
      (Self.FGrid.Columns[idx].Title.Caption + 'A');
    AWidth[idx] := Self.FGrid.Columns[idx].Width;
    Twidth := Twidth + AWidth[idx];

    if Assigned(Self.FGrid.Columns[idx].Field) then
      Asize[idx] := Self.FGrid.Columns[idx].Field.Size
    else
      Asize[idx] := 1;

    TSize := TSize + Asize[idx];
  end;
  if TDBGridOption.dgColLines in Self.FGrid.Options then
    Twidth := Twidth + Self.FGrid.Columns.count;

  // adiciona a largura da coluna indicada do cursor
  if TDBGridOption.dgIndicator in Self.FGrid.Options then
    Twidth := Twidth + IndicatorWidth;

  Swidth := Self.FGrid.ClientWidth - Twidth;
  AjustarColumns(Swidth, TSize, Asize);
end;

end.
