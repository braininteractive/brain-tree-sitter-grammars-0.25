CREATE VIEW active_users AS
SELECT id, name FROM users WHERE active = TRUE;

ALTER TABLE orders ADD COLUMN shipped_at TIMESTAMP;
ALTER TABLE orders DROP COLUMN legacy_flag;
