CREATE OR REPLACE PROCEDURE log_message(
  p_level   IN NUMBER DEFAULT 1,
  p_message IN VARCHAR2
) AS
  l_now DATE := SYSDATE;
BEGIN
  INSERT INTO app_log (log_level, message, created_at)
  VALUES (p_level, p_message, l_now);
  COMMIT;
END log_message;
