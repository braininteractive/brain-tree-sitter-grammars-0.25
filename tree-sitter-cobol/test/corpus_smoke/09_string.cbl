       identification division.
       program-id. strtest.
       data division.
       working-storage section.
       01  ws-first   pic x(10) value "JOHN".
       01  ws-last    pic x(10) value "SMITH".
       01  ws-full    pic x(21).
       procedure division.
       string ws-first delimited by space
              " " delimited by size
              ws-last delimited by space
              into ws-full
       end-string.
       display ws-full.
       stop run.
