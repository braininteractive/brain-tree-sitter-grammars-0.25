procedure Expressions_Demo is

   type Int_Array is array (Positive range <>) of Integer;

   Data : constant Int_Array := (1, 2, 3, 4, 5);

   function Sign (X : Integer) return Integer is
     (if X > 0 then 1 elsif X < 0 then -1 else 0);

   All_Positive : constant Boolean :=
     (for all E of Data => E > 0);

   Any_Big : constant Boolean :=
     (for some E of Data => E > 4);

   Doubled : constant Int_Array :=
     (for I in Data'Range => Data (I) * 2);

   S : constant Integer := Sign (-5);

   Label : constant String :=
     (case S is
        when -1     => "negative",
        when 0      => "zero",
        when others => "positive");

   X : Integer := 16#FF# + 2#1010# + 1_000_000;
   Y : Float := 3.14_159E1;

begin
   X := (Data (1) + Data (2)) * abs S;
   Y := Y ** 2;
   pragma Assert (All_Positive and then Any_Big);
   pragma Assert (Doubled (1) = 2 or else Label'Length > 0);
end Expressions_Demo;
