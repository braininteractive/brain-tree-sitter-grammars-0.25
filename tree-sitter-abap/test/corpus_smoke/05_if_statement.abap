* Plain IF blocks and =/EQ/<>/NE comparisons; ELSE/ELSEIF, CASE/WHEN
* and the ordering operators added in this fork are exercised in
* 14_case_branching.abap.
REPORT zsmoke05.

DATA lv_grade TYPE c.
DATA lv_done TYPE c.

lv_grade = 'B'.

IF lv_grade = 'A'.
  WRITE 'excellent'.
ENDIF.

IF lv_grade <> 'A' AND lv_done IS INITIAL.
  IF lv_grade = 'B' OR lv_grade = 'C'.
    WRITE 'good'.
  ENDIF.
ENDIF.

IF NOT lv_grade = 'F'.
  WRITE 'passed'.
ENDIF.

CHECK lv_done IS INITIAL.
