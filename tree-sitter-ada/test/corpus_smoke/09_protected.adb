procedure Protected_Demo is

   protected Counter is
      procedure Increment;
      function Value return Natural;
      entry Wait_Nonzero;
   private
      Count : Natural := 0;
   end Counter;

   protected body Counter is
      procedure Increment is
      begin
         Count := Count + 1;
      end Increment;

      function Value return Natural is
      begin
         return Count;
      end Value;

      entry Wait_Nonzero when Count > 0 is
      begin
         null;
      end Wait_Nonzero;
   end Counter;

begin
   Counter.Increment;
   Counter.Wait_Nonzero;
end Protected_Demo;
