(defun factorial (n)
  "Compute n! recursively."
  (if (<= n 1)
      1
      (* n (factorial (- n 1)))))

(defun clamp (x lo hi)
  (max lo (min x hi)))

(defmacro with-timing (&body body)
  `(let ((start (get-internal-real-time)))
     (prog1 (progn ,@body)
       (format t "took ~a~%" (- (get-internal-real-time) start)))))
