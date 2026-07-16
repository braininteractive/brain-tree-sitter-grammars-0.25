REPORT zsmoke02.

DATA lv_count TYPE i.
DATA lv_name TYPE string.
DATA: lv_first TYPE c,
      lv_second TYPE n,
      lv_amount TYPE p.

DATA: BEGIN OF gs_address,
        street TYPE string,
        city TYPE string,
        zip TYPE n,
      END OF gs_address.

lv_count = 42.
lv_name = 'smoke'.
