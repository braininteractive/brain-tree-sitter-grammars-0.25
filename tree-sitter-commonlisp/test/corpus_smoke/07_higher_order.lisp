(mapcar #'(lambda (x) (* x x)) '(1 2 3 4))

(remove-if-not #'evenp '(1 2 3 4 5 6))

(reduce #'+ '(1 2 3) :initial-value 10)

(funcall (lambda (a b) (+ a b)) 1 2)

(apply #'max '(3 1 4 1 5))

(sort (copy-seq '(3 1 2)) #'<)
