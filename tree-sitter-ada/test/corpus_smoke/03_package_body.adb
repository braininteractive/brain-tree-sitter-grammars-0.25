package body Stacks is

   procedure Push (S : in out Stack; Item : Integer) is
   begin
      S.Count := S.Count + 1;
      S.Items (S.Count) := Item;
   end Push;

   procedure Pop (S : in out Stack; Item : out Integer) is
   begin
      Item := S.Items (S.Count);
      S.Count := S.Count - 1;
   end Pop;

   function Is_Empty (S : Stack) return Boolean is
   begin
      return S.Count = 0;
   end Is_Empty;

   function Top (S : Stack) return Integer is
     (S.Items (S.Count));

end Stacks;
