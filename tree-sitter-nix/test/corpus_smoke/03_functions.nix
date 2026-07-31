{ pkgs, lib ? pkgs.lib, ... }:

let
  add = a: b: a + b;
  apply = f: x: f x;
in
{
  three = add 1 2;
  four = apply (n: n + 1) 3;
}
