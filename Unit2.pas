unit Unit2;
interface
  uses
    Generics.Collections, Unit3;
type
  TPolylineCurve=class
  procedure Calculation(XDots, YDots, XDotsInRegion,
    DotsOnTopRegionSide: TList<Real>; y0, yTop, SheetWidth, xRight :Integer);
  procedure AssignCoordinates(XDots, YDots: TList<Real>; I: Integer);
  end;

var
  I, x1, y1, x2, y2, x0: Integer;
  k, b, xp, MinX, MaxX: Real;
implementation
  uses
    Unit1;
   //ѕроцедура присвоени€ координат по номеру отрезка
  procedure TPolylineCurve.AssignCoordinates(XDots, YDots: TList<Real>;
    I: Integer);
  begin
    x1:=Trunc(XDots.Items[I]);
    y1:=Trunc(YDots.Items[I]);
    x2:=Trunc(XDots.Items[I+1]);
    y2:=Trunc(YDots.Items[I+1]);
  end;

  procedure TPolylineCurve.Calculation(XDots, YDots, XDotsInRegion,
  DotsOnTopRegionSide: TList<Real>; y0, yTop, SheetWidth, xRight :Integer);
  var
    Frame: TFrame;
  begin
    Frame:=TFrame.Create;
    for I:=0 to XDots.Count-1 do
    begin
      x1:=Trunc(XDots.Items[I]);
      y1:=Trunc(YDots.Items[I]);
      if (y1<=y0) and (y1>=yTop) then
      begin
        XDotsInRegion.Add(x1);
      end;
    end;
    //ƒобавл€ем в массив абсциссы точек пересечени€ отрезков нижней границы области
    for I := 0 to xDots.Count-2 do
    begin
      AssignCoordinates(XDots, YDots, I);
      k:=(y2-y1)/(x2-x1);
      b:=y2-(k*x2);
      //ѕровер€ем имеет ли отрезок точку пересечени€ с нижней стороной области
      //ѕровер€ем имеетс€ ли пересечение с пр€мой нижней стороны области
      if ((y1>y0) and (y2<y0)) or ((y1<y0) and (y2>y0)) then
          begin
            //ѕровер€ем принадлежит ли точка пересечени€ нижней стороне области
            xp:=(y0-b)/k;
            DotsOnTopRegionSide.Add(xp);
            XDotsInRegion.Add(xp);
          end;
    end;
    XDotsInRegion.Sort;
    MinX:=XDotsInRegion.First;
    //ќпредел€ем максимальную абсциссу в верхней области высотой с рамку
    MaxX:=XDotsInRegion.Last;
    x0:=Trunc(MinX);
    xRight:=x0+SheetWidth;
    Frame.PaintTheFrame(x0, y0, xRight, yTop);
    Repeat
    begin
      //ќпределим пересекает ли правую границу рамки какой-либо отрезок
      RightCross:=False;
      for I := 0 to XDots.Count-2 do
      begin
        AssignCoordinates(XDots, YDots, I);
          if ((xRight<x1) and (xRight>x2)) or ((xRight>x1) and (xRight<x2)) then
          begin
            k:=(y2-y1)/(x2-x1);
            b:=y2-(k*x2);
            yp:=k*xRight+b;
            if (yp<y0) and (yp>yTop) then
            begin
              RightCross:=True;
              x0:=xRight;
              xRight:=xRight+SheetWidth;
              Frame.PaintTheFrame(x0, y0, xRight, yTop);
              Break;
            end;
          end;
      end;
      if Not RightCross then
      begin
        OtherLinesInRegion:=False;
        for I := 0 to XDotsInRegion.Count-1 do
        begin
          if XDotsInRegion.Items[I]>xRight then    //
          begin
            XDotsInRegion.DeleteRange(0, I);
            OtherLinesInRegion:=True;
            Break;
          end;
        end;
        if OtherLinesInRegion then
        begin
          x0:=Trunc(XDotsInRegion.Items[0]);
          xRight:=x0+SheetWidth;
          Frame.PaintTheFrame(x0, y0, xRight, yTop);
        end;
    end;
    end;
    Until (RightCross or OtherLinesInRegion)=False;
  end;


end.
