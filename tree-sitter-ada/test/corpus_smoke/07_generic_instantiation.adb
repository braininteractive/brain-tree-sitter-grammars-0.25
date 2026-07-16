with Ada.Text_IO;
with Ada.Containers.Vectors;

procedure Generic_Instantiation is

   package Integer_Vectors is new Ada.Containers.Vectors
     (Index_Type => Positive, Element_Type => Integer);

   package Int_IO is new Ada.Text_IO.Integer_IO (Integer);

   use Integer_Vectors;

   V : Vector;

begin
   V.Append (1);
   V.Append (2);
   for E of V loop
      Int_IO.Put (E);
   end loop;
end Generic_Instantiation;
