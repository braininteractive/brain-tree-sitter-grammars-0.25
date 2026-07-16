WAITFOR DELAY '00:00:05';
GOTO retry;
retry:
PRINT 'retrying';
