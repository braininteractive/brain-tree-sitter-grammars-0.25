(define-condition invalid-age (error)
  ((value :initarg :value :reader invalid-age-value))
  (:report (lambda (condition stream)
             (format stream "bad age: ~a" (invalid-age-value condition)))))

(defun parse-age (n)
  (when (minusp n)
    (error 'invalid-age :value n))
  n)

(handler-case (parse-age -1)
  (invalid-age (e)
    (format t "caught: ~a~%" e))
  (error (e)
    (declare (ignore e))
    nil))

(unwind-protect
    (parse-age 42)
  (format t "cleanup~%"))
