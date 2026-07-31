(defclass shape ()
  ((name :initarg :name :accessor shape-name)))

(defclass circle (shape)
  ((radius :initarg :radius :reader circle-radius :initform 1.0)))

(defgeneric area (shape))

(defmethod area ((c circle))
  (* pi (expt (circle-radius c) 2)))

(defmethod print-object ((c circle) stream)
  (format stream "#<circle r=~a>" (circle-radius c)))

(area (make-instance 'circle :radius 2.0))
