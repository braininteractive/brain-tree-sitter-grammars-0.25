with Ada.Text_IO;
with Ada.Exceptions;

procedure Exceptions_Demo is

   Overflow : exception;

   procedure Risky (X : Integer) is
   begin
      if X > 100 then
         raise Overflow with "value too large";
      elsif X < 0 then
         raise Constraint_Error;
      end if;
   end Risky;

begin
   Risky (150);
exception
   when Overflow =>
      Ada.Text_IO.Put_Line ("overflow caught");
   when E : others =>
      Ada.Text_IO.Put_Line (Ada.Exceptions.Exception_Message (E));
      raise;
end Exceptions_Demo;
