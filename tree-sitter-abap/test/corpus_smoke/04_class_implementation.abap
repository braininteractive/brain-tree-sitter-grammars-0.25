REPORT zsmoke04.

CLASS lcl_greeter DEFINITION.
  PUBLIC SECTION.
    METHODS greet.
ENDCLASS.

CLASS lcl_greeter IMPLEMENTATION.

  METHOD greet.
    WRITE 'hello from method'.
  ENDMETHOD.

ENDCLASS.
