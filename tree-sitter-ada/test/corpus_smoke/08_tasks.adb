procedure Tasks_Demo is

   task type Worker (Id : Natural) is
      entry Start (Work : Integer);
      entry Stop;
   end Worker;

   task body Worker is
      Amount : Integer := 0;
      Done   : Boolean := False;
   begin
      loop
         select
            accept Start (Work : Integer) do
               Amount := Work;
            end Start;
         or
            accept Stop;
            Done := True;
         or
            delay 1.0;
         end select;
         exit when Done;
      end loop;
   end Worker;

   W : Worker (Id => 1);

begin
   W.Start (10);
   W.Stop;
end Tasks_Demo;
