       identification division.
       program-id. wstest.
       data division.
       working-storage section.
       01  ws-customer.
           05  ws-name        pic x(30).
           05  ws-age         pic 99.
           05  ws-balance     pic s9(7)v99.
       01  ws-counter         pic 9(4) value zero.
       77  ws-flag            pic x value "N".
       procedure division.
       display ws-name.
       stop run.
