let
  name = "world";
  single = "hello ${name}";
  indented = ''
    multi line
    with ${name} interpolation
    and 'quotes'
  '';
  path = ./relative/path.nix;
  url = https://example.com;
in
{ inherit single indented path; }
