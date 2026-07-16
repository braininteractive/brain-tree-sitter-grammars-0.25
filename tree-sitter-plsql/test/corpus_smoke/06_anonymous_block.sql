DECLARE
  l_counter NUMBER := 0;
  l_name    VARCHAR2(50) := 'hello';
BEGIN
  l_counter := l_counter + 1;
  dbms_output.put_line('counter = ' || l_counter);
  dbms_output.put_line(l_name);
END;
