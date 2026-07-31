let
  pkgs = { git = "git"; vim = "vim"; emacs = "emacs"; };
  version = "1.0";
in
with pkgs;
{
  inherit git vim;
  inherit (pkgs) emacs;
  inherit version;
  editors = [ vim emacs ];
}
