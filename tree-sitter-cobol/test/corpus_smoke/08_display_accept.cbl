       identification division.
       program-id. dispacc.
       data division.
       working-storage section.
       01  ws-name  pic x(20).
       01  ws-date  pic 9(8).
       procedure division.
       display "ENTER YOUR NAME:".
       accept ws-name.
       display "HELLO " ws-name.
       accept ws-date from date.
       display ws-date.
       stop run.
