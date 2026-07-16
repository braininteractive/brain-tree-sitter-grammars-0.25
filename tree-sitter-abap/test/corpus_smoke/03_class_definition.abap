REPORT zsmoke03.

CLASS lcl_calculator DEFINITION.
  PUBLIC SECTION.
    METHODS constructor.
    METHODS add
      IMPORTING iv_a TYPE i
                iv_b TYPE i
      RETURNING VALUE(rv_sum) TYPE i.
  PROTECTED SECTION.
    DATA mv_last TYPE i.
  PRIVATE SECTION.
    DATA mv_calls TYPE i.
ENDCLASS.
