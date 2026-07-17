UPDATE products
SET price = price * 1.1,
    updated_at = NOW()
WHERE category_id IN (SELECT id FROM categories WHERE name = 'books');

DELETE FROM sessions WHERE expires_at < NOW();
