unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Generics.Collections, System.RegularExpressions, Unit2;

type
  TForm1 = class(TForm)
    Label2: TLabel;
    EditSheetWidth: TEdit;
    Label3: TLabel;
    EditSheetHigh: TEdit;
    Button1: TButton;
    Label4: TLabel;
    Button2: TButton;
    Button3: TButton;
    MemoDots: TMemo;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure ClearAll();
    procedure Button2Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure PaintPolyline();
    procedure LoadDotsFromList();
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure PaintFrame(x0, y0, xRight, yTop: Integer);
  private
    { Private declarations }
  public
   // procedure AssignCoordinates(I: Integer);

    { Public declarations }

  end;

var
  Form1: TForm1;
  Lines:Array[1..10, 1..2] of Integer;
  x1, y1, x2, y2, MaxY, MinY, I, SheetHigh, SheetWidth: Integer;
  x0, y0: Integer;//Координаты левого нижнего угла рамки
  yTop, xRight: Integer; //Координаты правого верхнего угла рамки
  DotsOnTopRegionSide, XDots, YDots: TList<Real>;
  XDotsInRegion: TList<Real>; //Список абсцисс концов линий и точек пересечения линий с нижней границей области
  k, b, MinX, MaxX: Real;
  xp: Real; //Абсцисса точки пересечения отрезка со стороной рамки (верхней или нижней)
  yp: Real; //Ордината точки пересечения отрезка со стороной рамки (левой или правой)
  RightCross, OtherLinesInRegion: Boolean;
  RemoveSpases: TRegEx;
  PolylineCurve: TPolylineCurve;
implementation

{$R *.dfm}



  procedure TForm1.LoadDotsFromList();
  var
    C: Integer;
    S: String;
  begin
    XDots:=TList<Real>.Create;
    YDots:=TList<Real>.Create;
    with MemoDots do
    begin
      for I := 0 to Lines.Count-1 do
      begin
        if Lines[I]<>'' then
        begin
          C:=0;
          for S in RemoveSpases.Split(Lines[I], ';') do
          begin
            if C=0 then XDots.Add(StrToFloat(Trim(S))) else YDots.Add(StrToFloat
            (Trim(S)));
            C:=C+1;
          end;
        end;
      end;
    end;
  end;

procedure TForm1.PaintFrame(x0, y0, xRight, yTop: Integer);
  begin
    with Canvas do
    begin
      MoveTo(x0, y0);
      LineTo(x0, yTop);
      LineTo(xRight, yTop);
      LineTo(xRight, y0);
      LineTo(x0,y0);
    end;
  end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ClearAll();
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ClearAll();
  PaintPolyline();
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  selectedFile: string;
  dlg: TOpenDialog;
begin
  selectedFile := '';
  dlg := TOpenDialog.Create(nil);
  try
    dlg.InitialDir := 'C:\';
    dlg.Filter := 'Text files (*.txt)|*.txt';
    if dlg.Execute(Handle) then
      selectedFile := dlg.FileName;
  finally
    dlg.Free;
  end;
  if selectedFile <> '' then
  begin
    MemoDots.Lines.LoadFromFile(selectedFile);
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  SaveDialog1: TSaveDialog;
  FileName: String;
begin
  FileName:='';
  SaveDialog1:=TSaveDialog.Create(nil);
  SaveDialog1.InitialDir := 'C:\';
  SaveDialog1.Filter := 'Text files (*.txt)|*.txt';
    { Execute a save file dialog. }
  if SaveDialog1.Execute then
      { First check if the file exists. }
      if FileExists(SaveDialog1.FileName) then
        { If it exists, raise an exception. }
        raise Exception.Create('File already exists. Cannot overwrite.')
      else
      begin
        { Otherwise, save the memo box lines into the file. }
        MemoDots.Lines.SaveToFile(SaveDialog1.FileName);
      end;
end;



procedure TForm1.ClearAll();
begin
  with Canvas do
  begin
    Rectangle(0,0,350,350);
  end;
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  ClearAll();
end;

procedure TForm1.PaintPolyline ();

begin
  with Canvas do
  begin
    MoveTo(Trunc(XDots.Items[0]), Trunc(YDots.Items[0]));
    for I := 1 to XDots.Count-1 do
    begin
      LineTo(Trunc(XDots.Items[I]), Trunc(YDots.Items[I]));
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  R: Real;
  PolylineCurve: TPolylineCurve;
begin
  LoadDotsFromList();
  PaintPolyline();
  SheetWidth:=StrToInt(EditSheetWidth.Text);
  SheetHigh:=StrToInt(EditSheetHigh.Text);
  //Определяем ординату самой верхней и нижней точек
  MaxY:=Trunc(YDots.Items[0]);
  MinY:=Trunc(YDots.Items[0]);
  for R in YDots do
  begin
    if Trunc(R)<MaxY then MaxY:=Trunc(R);
    if Trunc(R)>MinY then MinY:=Trunc(R);
  end;
  //Определяем минимальную абсциссу в верхней области высотой с рамку
  y0:=MaxY+SheetHigh;
  yTop:=MaxY;
  //Добавляем в массив абсциссы точек, лежащих внутри области
  XDotsInRegion:=TList<Real>.Create;
  DotsOnTopRegionSide:=TList<Real>.Create;
  PolylineCurve:=TPolylineCurve.Create;
  PolylineCurve.Calculation(XDots, YDots, XDotsInRegion, DotsOnTopRegionSide,
    y0, yTop, SheetWidth, xRight);
  while y0<MinY do
  begin
    y0:=y0+SheetHigh;
    yTop:=yTop+SheetHigh;
    XDotsInRegion.Clear;
    XDotsInRegion.AddRange(DotsOnTopRegionSide);
    DotsOnTopRegionSide.Clear;
    PolylineCurve.Calculation(XDots, YDots, XDotsInRegion, DotsOnTopRegionSide,
      y0, yTop, SheetWidth, xRight);
  end;
end;
end.
