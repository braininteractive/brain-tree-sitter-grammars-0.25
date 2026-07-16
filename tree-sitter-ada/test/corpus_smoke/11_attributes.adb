procedure Attributes_Demo is

   type Day is (Mon, Tue, Wed, Thu, Fri, Sat, Sun);

   Table : array (1 .. 10) of Integer := (others => 0);

   First_Day : constant Day := Day'First;
   Last_Day  : constant Day := Day'Last;
   Next_Day  : constant Day := Day'Succ (Mon);
   Name      : constant String := Day'Image (Wed);
   Size_Bits : constant Integer := Integer'Size;

begin
   for I in Table'Range loop
      Table (I) := Table'First + Table'Last - I;
   end loop;

   for D in Day'Range loop
      exit when D = Day'Val (3);
   end loop;

   pragma Assert (Table'Length = 10);
end Attributes_Demo;
