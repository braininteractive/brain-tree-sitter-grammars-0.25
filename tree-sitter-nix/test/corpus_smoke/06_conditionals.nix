{ lib, stdenv, enableFoo ? false }:

let
  suffix = if enableFoo then "-foo" else "";
  flags = lib.optionals stdenv.isLinux [ "--linux" ]
    ++ lib.optional enableFoo "--enable-foo";
in
{
  name = "pkg${suffix}";
  configureFlags = flags;
  assertion = assert enableFoo -> stdenv.isLinux; true;
}
