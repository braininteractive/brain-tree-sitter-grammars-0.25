REPORT zsmoke06.

DATA gt_items TYPE TABLE OF string.
DATA gs_item TYPE string.

LOOP AT gt_items INTO gs_item.
  IF gs_item = 'skip'.
    CONTINUE.
  ENDIF.
  IF gs_item = 'stop'.
    EXIT.
  ENDIF.
  WRITE gs_item.
ENDLOOP.

LOOP AT gt_items ASSIGNING <fs_item>.
  WRITE <fs_item>.
ENDLOOP.
