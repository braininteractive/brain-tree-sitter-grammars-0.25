* Branching constructs added in this fork: IF with ELSEIF/ELSE,
* CASE/WHEN/ENDCASE, and the ordering comparison operators
* (> < >= <= GT LT GE LE).
REPORT zsmoke14.

DATA lv_count TYPE i.
DATA lv_status TYPE c.

lv_count = 7.
lv_status = 'B'.

IF lv_count > 10.
  WRITE 'big'.
ELSEIF lv_count >= 5 AND lv_count < 10.
  WRITE 'medium'.
ELSEIF lv_count GE 2 OR lv_count LE 1.
  WRITE 'edge'.
ELSE.
  WRITE 'small'.
ENDIF.

CASE lv_status.
  WHEN 'A'.
    WRITE 'active'.
  WHEN 'B' OR 'C'.
    WRITE 'blocked'.
  WHEN OTHERS.
    WRITE 'unknown'.
ENDCASE.

CHECK lv_count GT 0.
CHECK lv_count <= 100.
