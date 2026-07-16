package Aspects_Demo
  with Pure
is

   type Speed is new Float
     with Default_Value => 0.0;

   type Percent is range 0 .. 100
     with Size => 8;

   Max_Items : constant := 64;

   type Buffer_Index is mod Max_Items;

   function Clamp (X : Integer) return Percent
     with
       Inline,
       Post => Clamp'Result in 0 .. 100;

   procedure Reset (P : out Percent)
     with Global => null, Depends => (P => null);

   Flag : Boolean := False
     with Atomic, Volatile;

end Aspects_Demo;
