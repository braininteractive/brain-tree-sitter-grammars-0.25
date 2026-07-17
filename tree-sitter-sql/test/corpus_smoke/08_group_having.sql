SELECT category_id, COUNT(*) AS n, SUM(price) AS revenue
FROM products
GROUP BY category_id
HAVING COUNT(*) > 5 AND SUM(price) > 1000;
