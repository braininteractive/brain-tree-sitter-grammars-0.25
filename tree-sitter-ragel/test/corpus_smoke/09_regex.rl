machine regexes;

ident = /[a-zA-Z_][a-zA-Z0-9_]*/;
spaces = / */;
anything = /.*/;
caseless = /select/i;
main := ident . spaces . anything . caseless;
