CREATE OR REPLACE TRIGGER trg_orders_audit
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
  INSERT INTO orders_audit (action, changed_at)
  VALUES ('INSERT', SYSDATE);
  IF USER = 'BATCH' THEN
    log_message(1, 'batch insert');
  END IF;
END trg_orders_audit;
