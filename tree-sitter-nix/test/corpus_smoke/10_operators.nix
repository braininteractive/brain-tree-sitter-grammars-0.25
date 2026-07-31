let
  a = 10;
  b = 3;
in
{
  sum = a + b;
  diff = a - b;
  prod = a * b;
  quot = a / b;
  neg = -a;
  not = !false;
  impl = true -> false;
  and = true && false;
  or = true || false;
  eq = a == b;
  ne = a != b;
  lt = a < b;
  ge = a >= b;
  concat = [ 1 ] ++ [ 2 ];
  update = { x = 1; } // { y = 2; };
  has = { x = 1; } ? x;
}
