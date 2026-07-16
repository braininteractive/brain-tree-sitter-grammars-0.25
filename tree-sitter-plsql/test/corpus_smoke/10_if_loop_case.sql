DECLARE
  l_i     NUMBER := 0;
  l_grade VARCHAR2(1) := 'B';
  l_label VARCHAR2(20);
BEGIN
  IF l_i = 0 THEN
    l_label := 'zero';
  ELSIF l_i > 0 THEN
    l_label := 'positive';
  ELSE
    l_label := 'negative';
  END IF;

  FOR i IN 1..10 LOOP
    l_i := l_i + i;
  END LOOP;

  WHILE l_i > 0 LOOP
    l_i := l_i - 1;
  END LOOP;

  LOOP
    l_i := l_i + 1;
    EXIT WHEN l_i > 5;
  END LOOP;

  CASE l_grade
    WHEN 'A' THEN l_label := 'excellent';
    WHEN 'B' THEN l_label := 'good';
    ELSE l_label := 'other';
  END CASE;
END;
