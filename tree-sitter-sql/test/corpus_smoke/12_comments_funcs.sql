-- daily rollup, keep in sync with the reporting job
SELECT
  DATE_TRUNC('day', created_at) AS day,
  COUNT(DISTINCT user_id) AS dau,
  COALESCE(SUM(amount), 0) AS revenue
FROM events
/* only billable events */
WHERE kind IN ('purchase', 'renewal')
GROUP BY 1
ORDER BY 1 DESC;
