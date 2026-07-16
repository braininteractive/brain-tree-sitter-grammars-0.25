CREATE OR REPLACE PACKAGE BODY pkg_orders AS

  g_count NUMBER := 0;

  PROCEDURE add_order(p_id IN NUMBER, p_name IN VARCHAR2) IS
  BEGIN
    INSERT INTO orders (id, name) VALUES (p_id, p_name);
    g_count := g_count + 1;
  END add_order;

  FUNCTION order_count RETURN NUMBER IS
  BEGIN
    RETURN g_count;
  END order_count;

  FUNCTION order_name(p_id IN NUMBER) RETURN VARCHAR2 IS
    l_name VARCHAR2(200);
  BEGIN
    SELECT name INTO l_name FROM orders WHERE id = p_id;
    RETURN l_name;
  END order_name;

END pkg_orders;
