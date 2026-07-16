DECLARE
  e_custom EXCEPTION;
  l_value  NUMBER;
BEGIN
  BEGIN
    SELECT id INTO l_value FROM orders WHERE id = 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      l_value := 0;
    WHEN TOO_MANY_ROWS THEN
      l_value := -1;
  END;

  IF l_value = 0 THEN
    RAISE e_custom;
  END IF;
EXCEPTION
  WHEN e_custom THEN
    dbms_output.put_line('custom error');
  WHEN OTHERS THEN
    dbms_output.put_line('unexpected');
END;
