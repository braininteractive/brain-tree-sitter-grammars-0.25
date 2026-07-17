SELECT id, name FROM customers
UNION
SELECT id, name FROM suppliers
UNION ALL
SELECT id, name FROM partners
EXCEPT
SELECT id, name FROM blocked_entities;
