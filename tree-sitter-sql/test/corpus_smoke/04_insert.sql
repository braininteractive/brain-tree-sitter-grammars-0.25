INSERT INTO users (name, email, created_at)
VALUES
  ('Alice', 'alice@example.com', NOW()),
  ('Bob', 'bob@example.com', NOW());

INSERT INTO audit_log (entity, action)
SELECT 'user', 'bulk_import' FROM users WHERE created_at > '2026-01-01';
