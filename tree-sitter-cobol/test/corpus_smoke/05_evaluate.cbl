       identification division.
       program-id. evaltest.
       data division.
       working-storage section.
       01  ws-grade  pic x value "B".
       procedure division.
       evaluate ws-grade
         when "A"
           display "EXCELLENT"
         when "B"
           display "GOOD"
         when other
           display "UNKNOWN"
       end-evaluate.
       stop run.
