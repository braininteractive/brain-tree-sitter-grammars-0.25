(defparameter *config*
  '((:host . "localhost")
    (:port . 8080)))

(defvar *cache* (make-hash-table :test #'equal))

(setf (gethash "key" *cache*) '(1 2 3))

(defconstant +limit+ 100)

(let ((vec #(1 2 3))
      (assoc-val (cdr (assoc :port *config*))))
  (aref vec 0)
  assoc-val)
