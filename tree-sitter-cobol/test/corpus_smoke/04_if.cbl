       identification division.
       program-id. iftest.
       data division.
       working-storage section.
       01  ws-num  pic 9(3) value 42.
       procedure division.
       if ws-num > 100
         display "BIG"
       else
         if ws-num = 42
           display "ANSWER"
         else
           display "SMALL"
         end-if
       end-if.
       stop run.
