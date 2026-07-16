       identification division.
       program-id. unstrtest.
       data division.
       working-storage section.
       01  ws-input  pic x(30) value "AAA,BBB,CCC".
       01  ws-part1  pic x(10).
       01  ws-part2  pic x(10).
       01  ws-part3  pic x(10).
       01  ws-count  pic 9(2).
       procedure division.
       unstring ws-input delimited by ","
           into ws-part1 ws-part2 ws-part3
           tallying in ws-count
       end-unstring.
       display ws-part1.
       stop run.
