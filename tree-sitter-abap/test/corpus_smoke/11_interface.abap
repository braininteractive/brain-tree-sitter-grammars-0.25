* NOTE: implementing an interface inside a class via the INTERFACES
* statement is not supported by the grammar; only standalone
* INTERFACE ... ENDINTERFACE declarations parse (see README gaps).
REPORT zsmoke11.

INTERFACE lif_printer.
  METHODS print
    IMPORTING iv_text TYPE string.
  DATA mv_lines TYPE i.
ENDINTERFACE.

CLASS lcl_console DEFINITION.
  PUBLIC SECTION.
    METHODS print_line
      IMPORTING iv_text TYPE string.
ENDCLASS.
