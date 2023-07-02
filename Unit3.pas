unit Unit3;

interface

type
  TFrame=class
  procedure PaintTheFrame(x0, y0, xRight, yTop: Integer);

  end;

implementation
  uses
    Unit1;
  procedure TFrame.PaintTheFrame(x0, y0, xRight, yTop: Integer);
  begin
    Form1.PaintFrame(x0, y0, xRight, yTop);
  end;


end.
