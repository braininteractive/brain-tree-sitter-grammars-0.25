       identification division.
       program-id. fileio.
       environment division.
       input-output section.
       file-control.
       select in-file assign to "input.dat".
       select out-file assign to "output.dat".
       data division.
       file section.
       fd  in-file.
       01  in-rec   pic x(80).
       fd  out-file.
       01  out-rec  pic x(80).
       working-storage section.
       01  ws-eof   pic x value "N".
       procedure division.
       open input in-file.
       open output out-file.
       read in-file
         at end move "Y" to ws-eof
       end-read.
       move in-rec to out-rec.
       write out-rec.
       close in-file.
       close out-file.
       stop run.
