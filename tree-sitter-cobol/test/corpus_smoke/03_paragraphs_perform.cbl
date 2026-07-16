       identification division.
       program-id. paras.
       procedure division.
       main-para.
       perform init-para.
       perform work-para thru work-exit.
       perform work-para 3 times.
       stop run.
       init-para.
       display "INIT".
       work-para.
       display "WORK".
       work-exit.
       exit.
