* Classic procedural ABAP: FORM ... ENDFORM subroutines and PERFORM
* calls (added in this fork on top of upstream c7604df).
REPORT zsmoke13.

DATA lv_total TYPE i.
DATA lv_factor TYPE i.
DATA lt_items TYPE STANDARD TABLE OF zitem.

lv_factor = 2.

PERFORM init_totals.
PERFORM calc_total TABLES lt_items USING lv_factor 'X' CHANGING lv_total.
PERFORM show_result USING lv_total.
PERFORM external_helper(zutil_prog) IF FOUND.
PERFORM shared_helper IN PROGRAM zutil_prog IF FOUND USING lv_total.

FORM init_totals.
  CLEAR lv_total.
ENDFORM.

FORM calc_total TABLES it_items STRUCTURE zitem
                USING iv_factor TYPE i VALUE(iv_mode)
                CHANGING cv_total TYPE i.
  DATA lv_line_value TYPE i.
  LOOP AT it_items INTO lv_line_value.
    cv_total = cv_total + lv_line_value * iv_factor.
  ENDLOOP.
ENDFORM.

FORM show_result USING p_total.
  WRITE p_total.
ENDFORM.
