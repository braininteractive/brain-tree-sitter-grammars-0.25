* NOTE: string templates |...| are not in the grammar; literal
* character strings '...' are used instead (see README gaps section).
REPORT zsmoke09.

DATA lv_total TYPE i.

lv_total = 7.

WRITE 'plain literal'.
WRITE lv_total.
WRITE: 'a', lv_total, 'b'.
