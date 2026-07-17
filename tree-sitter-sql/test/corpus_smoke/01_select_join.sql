SELECT u.id, u.name, o.total
FROM users u
INNER JOIN orders o ON o.user_id = u.id
LEFT JOIN addresses a ON a.user_id = u.id
WHERE o.total > 100 AND u.active = TRUE
ORDER BY o.total DESC
LIMIT 20 OFFSET 40;
