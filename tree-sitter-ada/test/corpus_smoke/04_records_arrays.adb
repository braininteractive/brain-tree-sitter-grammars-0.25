procedure Records_Arrays is

   type Point is record
      X, Y : Float := 0.0;
   end record;

   type Shape_Kind is (Circle, Square, Triangle);

   type Shape (Kind : Shape_Kind := Circle) is record
      Origin : Point;
      case Kind is
         when Circle =>
            Radius : Float;
         when Square =>
            Side : Float;
         when Triangle =>
            Base, Height : Float;
      end case;
   end record;

   type Matrix is array (Positive range <>, Positive range <>) of Float;

   Identity : constant Matrix (1 .. 2, 1 .. 2) :=
     ((1.0, 0.0), (0.0, 1.0));

   P : Point := (X => 1.5, Y => 2.5);
   S : Shape := (Kind => Square, Origin => P, Side => 3.0);

begin
   P.X := Identity (1, 1) + S.Side;
end Records_Arrays;
