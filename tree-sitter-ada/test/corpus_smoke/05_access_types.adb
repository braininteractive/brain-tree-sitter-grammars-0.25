procedure Access_Types is

   type Node;
   type Node_Access is access Node;

   type Node is record
      Value : Integer;
      Next  : Node_Access;
   end record;

   type Callback is access procedure (X : Integer);
   type Reader is access function return Integer;

   Head : Node_Access := null;

   procedure Prepend (Value : Integer) is
   begin
      Head := new Node'(Value => Value, Next => Head);
   end Prepend;

begin
   Prepend (42);
   if Head /= null then
      Head.all.Value := Head.Value + 1;
   end if;
end Access_Types;
