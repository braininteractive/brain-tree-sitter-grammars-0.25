      * Full four-division sample program.
       identification division.
       program-id. fullprog.
       author. smoke-test.
       environment division.
       configuration section.
       input-output section.
       file-control.
       select log-file assign to "run.log".
       data division.
       file section.
       fd  log-file.
       01  log-rec  pic x(132).
       working-storage section.
       01  ws-state.
           05  ws-code   pic 9(2) value 0.
           05  ws-msg    pic x(40).
       procedure division.
       main-para.
       open output log-file.
       perform build-msg.
       if ws-code = 0
         move ws-msg to log-rec
         write log-rec
       end-if.
       close log-file.
       stop run.
       build-msg.
      * classic comment line in column 7
       evaluate ws-code
         when 0
           move "OK" to ws-msg
         when other
           move "FAIL" to ws-msg
       end-evaluate.
