       identification division.
       program-id. loops.
       data division.
       working-storage section.
       01  ws-i    pic 9(3).
       01  ws-sum  pic 9(6) value zero.
       procedure division.
       perform varying ws-i from 1 by 1 until ws-i > 10
         add ws-i to ws-sum
       end-perform.
       perform show-sum.
       stop run.
       show-sum.
       display ws-sum.
