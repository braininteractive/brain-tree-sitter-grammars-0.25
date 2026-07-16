DECLARE
  CURSOR c_orders(p_min IN NUMBER) IS
    SELECT id, name FROM orders WHERE id > p_min;
  l_id   NUMBER;
  l_name VARCHAR2(200);
BEGIN
  OPEN c_orders(10);
  LOOP
    FETCH c_orders INTO l_id, l_name;
    EXIT WHEN c_orders%NOTFOUND;
    dbms_output.put_line(l_id || ' ' || l_name);
  END LOOP;
  CLOSE c_orders;
END;
