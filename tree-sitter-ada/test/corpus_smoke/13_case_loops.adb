with Ada.Text_IO; use Ada.Text_IO;

procedure Case_Loops is
   N      : Integer := 17;
   Result : Integer := 0;
begin
   case N is
      when 0 =>
         Result := 1;
      when 1 .. 9 =>
         Result := 2;
      when 10 | 20 | 30 =>
         Result := 3;
      when others =>
         Result := 4;
   end case;

   while N > 0 loop
      N := N / 2;
      Result := Result + 1;
   end loop;

   for I in reverse 1 .. 10 loop
      if I mod 2 = 0 then
         Result := Result + I;
      end if;
   end loop;

   Outer :
   loop
      Result := Result - 1;
      exit Outer when Result <= 0;
   end loop Outer;

   declare
      Message : constant String := Integer'Image (Result);
   begin
      Put_Line (Message);
   end;
end Case_Loops;
