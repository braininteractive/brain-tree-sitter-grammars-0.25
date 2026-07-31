;; line comment
#| block
   comment |#

(list #\a #\Space)

(let ((str "with \"escaped\" quotes")
      (ratio 1/3)
      (float 3.14e2)
      (complex #c(1 2))
      (bits #b1010)
      (hex #xff))
  `(quasi ,str ,@(list ratio float) ,complex ,bits ,hex))

'(quoted list)
#'function-ref
