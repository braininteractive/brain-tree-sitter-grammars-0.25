WITH recent AS (
  SELECT user_id, MAX(created_at) AS last_seen
  FROM sessions
  GROUP BY user_id
),
active AS (
  SELECT * FROM recent WHERE last_seen > '2026-01-01'
)
SELECT u.name, a.last_seen
FROM users u
JOIN active a ON a.user_id = u.id;
