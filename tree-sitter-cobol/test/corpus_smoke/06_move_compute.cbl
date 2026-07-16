       identification division.
       program-id. arith.
       data division.
       working-storage section.
       01  ws-a      pic 9(4) value 10.
       01  ws-b      pic 9(4) value 20.
       01  ws-total  pic 9(6).
       procedure division.
       move 5 to ws-a.
       move ws-a to ws-b.
       compute ws-total = ws-a + ws-b * 2.
       compute ws-total = (ws-a + ws-b) / 3.
       add 1 to ws-a.
       subtract 2 from ws-b.
       stop run.
