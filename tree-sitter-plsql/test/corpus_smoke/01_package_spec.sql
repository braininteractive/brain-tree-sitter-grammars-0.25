CREATE OR REPLACE PACKAGE pkg_orders AS
  gc_max_items CONSTANT NUMBER := 100;

  PROCEDURE add_order(p_id IN NUMBER, p_name IN VARCHAR2);

  FUNCTION order_count RETURN NUMBER;

  FUNCTION order_name(p_id IN NUMBER) RETURN VARCHAR2;
END pkg_orders;
