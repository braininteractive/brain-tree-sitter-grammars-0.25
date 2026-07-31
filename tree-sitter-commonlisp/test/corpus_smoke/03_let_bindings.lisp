(let* ((x 10)
       (y (* x 2))
       (label "total"))
  (format t "~a: ~a~%" label (+ x y)))

(multiple-value-bind (quotient remainder)
    (floor 17 5)
  (list quotient remainder))

(destructuring-bind (a (b . c)) '(1 (2 . 3))
  (values a b c))
