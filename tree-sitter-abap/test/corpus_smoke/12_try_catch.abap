REPORT zsmoke12.

DATA lv_value TYPE i.

TRY.
    lv_value = 1.
  CATCH cx_sy_zerodivide.
    CLEAR lv_value.
  CATCH cx_root.
    lv_value = 0.
ENDTRY.

RETURN.
