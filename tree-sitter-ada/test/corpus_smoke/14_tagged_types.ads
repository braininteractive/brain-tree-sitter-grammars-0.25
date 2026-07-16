package Shapes is

   type Shape is abstract tagged record
      Name : String (1 .. 10);
   end record;

   function Area (S : Shape) return Float is abstract;
   procedure Describe (S : Shape'Class);

   type Circle is new Shape with record
      Radius : Float;
   end record;

   overriding function Area (S : Circle) return Float;

   type Square is new Shape with record
      Side : Float;
   end record;

   overriding function Area (S : Square) return Float;

   type Shape_Access is access all Shape'Class;

   type Drawable is interface;
   procedure Draw (D : Drawable) is abstract;

   type Sprite is new Circle and Drawable with null record;
   overriding procedure Draw (D : Sprite);

end Shapes;
