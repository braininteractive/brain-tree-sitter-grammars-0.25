DECLARE
  l_total NUMBER := 0;

  FUNCTION double_it(p_x IN NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN p_x * 2;
  END double_it;

  PROCEDURE bump(p_by IN NUMBER) IS
  BEGIN
    l_total := l_total + p_by;
  END bump;
BEGIN
  bump(double_it(21));
  dbms_output.put_line(l_total);
END;
