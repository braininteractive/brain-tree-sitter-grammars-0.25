REPORT zsmoke08.

DATA gt_names TYPE TABLE OF string.
DATA gs_name TYPE string.
DATA gs_found TYPE string.

gs_name = 'alice'.
APPEND gs_name TO gt_names.
gs_name = 'bob'.
APPEND gs_name TO gt_names.

READ TABLE gt_names INTO gs_found WITH KEY table_line = 'bob'.

CLEAR gs_name.
