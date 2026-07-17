BEGIN;
UPDATE accounts SET balance = balance - 50 WHERE id = 1;
UPDATE accounts SET balance = balance + 50 WHERE id = 2;
COMMIT;

BEGIN;
DELETE FROM staging_rows;
ROLLBACK;
