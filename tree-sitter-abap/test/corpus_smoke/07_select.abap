* Uses the obsolete SELECT ... INTO TABLE form; the modern
* comma-separated SELECT syntax is not in the grammar (see README).
REPORT zsmoke07.

DATA gt_bkpf TYPE TABLE OF string.
DATA gt_bseg TYPE TABLE OF string.

SELECT *
  FROM bkpf
  INTO TABLE gt_bkpf.

SELECT * UP TO 100 ROWS
  FROM bseg
  INTO TABLE gt_bseg
  WHERE bukrs = gs_bkpf-bukrs
    AND gjahr = gs_bkpf-gjahr.
