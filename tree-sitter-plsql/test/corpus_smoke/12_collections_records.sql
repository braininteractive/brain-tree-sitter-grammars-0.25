DECLARE
  TYPE t_num_list IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
  TYPE t_name_tab IS TABLE OF VARCHAR2(100);
  TYPE t_point IS RECORD (
    x NUMBER,
    y NUMBER
  );
  l_nums  t_num_list;
  l_names t_name_tab := t_name_tab('ada', 'grace');
  l_point t_point;
BEGIN
  l_point.x := 1;
  l_point.y := l_point.x + 1;
  dbms_output.put_line(l_names(1) || ' ' || l_names(2));
  dbms_output.put_line(l_nums.count);
END;
