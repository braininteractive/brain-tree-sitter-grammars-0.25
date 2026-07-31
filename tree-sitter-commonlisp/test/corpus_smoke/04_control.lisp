(defun classify (n)
  (cond ((< n 0) :negative)
        ((zerop n) :zero)
        (t :positive)))

(dotimes (i 5)
  (when (evenp i)
    (print i)))

(dolist (item '(a b c))
  (unless (eq item 'b)
    (print item)))

(loop for i from 1 to 10
      when (oddp i)
        collect (* i i) into squares
      finally (return squares))

(case (classify 3)
  (:positive "yes")
  ((:negative :zero) "no")
  (otherwise "?"))
