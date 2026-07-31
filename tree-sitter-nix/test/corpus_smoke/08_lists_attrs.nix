rec {
  simple = [ 1 2 3 ];
  nested = [ [ "a" ] [ "b" "c" ] ];
  mixed = [ true null 3.14 ./file.nix ];
  attrs = { a.b.c = 1; "quoted key" = 2; ${"dynamic"} = 3; };
  merged = attrs // { d = 4; };
  selected = attrs.a.b.c or 0;
  total = builtins.length simple;
}
