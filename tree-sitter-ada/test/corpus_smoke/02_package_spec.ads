--  A small stack package specification.
package Stacks is

   Capacity : constant := 100;

   type Stack is private;

   procedure Push (S : in out Stack; Item : Integer);
   procedure Pop (S : in out Stack; Item : out Integer);
   function Is_Empty (S : Stack) return Boolean;
   function Top (S : Stack) return Integer
     with Pre => not Is_Empty (S);

private

   type Int_Array is array (1 .. Capacity) of Integer;

   type Stack is record
      Items : Int_Array;
      Count : Natural := 0;
   end record;

end Stacks;
