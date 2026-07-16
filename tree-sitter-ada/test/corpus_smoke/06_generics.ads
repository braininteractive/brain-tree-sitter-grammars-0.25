generic
   type Element is private;
   type Index is (<>);
   type Element_Array is array (Index range <>) of Element;
   with function "<" (Left, Right : Element) return Boolean is <>;
package Generic_Sorting is

   procedure Sort (Data : in out Element_Array);

   generic
      with procedure Visit (E : Element);
   procedure Iterate (Data : Element_Array);

end Generic_Sorting;
