SELECT
  id,
  CASE
    WHEN total >= 1000 THEN 'gold'
    WHEN total >= 100 THEN 'silver'
    ELSE 'bronze'
  END AS tier,
  (SELECT COUNT(*) FROM orders o WHERE o.user_id = u.id) AS order_count
FROM users u;
