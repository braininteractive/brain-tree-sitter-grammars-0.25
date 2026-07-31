let
  fib = n: if n < 2 then n else fib (n - 1) + fib (n - 2);
  map' = f: xs: if xs == [ ] then [ ] else [ (f (builtins.head xs)) ] ++ map' f (builtins.tail xs);
in
{
  fib10 = fib 10;
  doubled = map' (x: x * 2) [ 1 2 3 ];
}
