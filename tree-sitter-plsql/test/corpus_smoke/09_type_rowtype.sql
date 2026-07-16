DECLARE
  l_id    orders.id%TYPE;
  l_row   orders%ROWTYPE;
  l_other l_id%TYPE;
BEGIN
  SELECT id INTO l_id FROM orders WHERE name = 'first';
  SELECT * INTO l_row FROM orders WHERE id = l_id;
  l_other := l_id;
  dbms_output.put_line(l_row.name);
END;
