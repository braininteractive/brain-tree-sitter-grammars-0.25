* NOTE: method calls are statements in this grammar; assigning a call
* result (lv = obj->meth( ... ).) is not supported (see README gaps).
REPORT zsmoke10.

DATA lo_calc TYPE REF TO lcl_calculator.
DATA lv_result TYPE i.

CREATE OBJECT lo_calc.

lo_calc->add( iv_a = 1 iv_b = 2 ).

lcl_calculator=>class_method( ).

helper( lv_result ).

CALL FUNCTION 'Z_SMOKE_FUNC'
  EXPORTING
    iv_input = lv_result
  IMPORTING
    ev_output = lv_result.
