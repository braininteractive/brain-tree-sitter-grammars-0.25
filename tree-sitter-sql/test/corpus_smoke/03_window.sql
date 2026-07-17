SELECT
  department,
  employee,
  salary,
  RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_rank,
  AVG(salary) OVER (PARTITION BY department) AS dept_avg
FROM employees;
