CREATE OR REPLACE FUNCTION fn_area(p_width IN NUMBER, p_height IN NUMBER)
RETURN NUMBER
DETERMINISTIC
IS
  l_area NUMBER;
BEGIN
  l_area := p_width * p_height;
  IF l_area < 0 THEN
    l_area := 0;
  END IF;
  RETURN l_area;
END fn_area;
