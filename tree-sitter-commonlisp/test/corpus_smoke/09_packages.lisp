(defpackage :geometry
  (:use :common-lisp)
  (:export #:area #:circle))

(in-package :geometry)

(defun area (r)
  (* pi r r))

(in-package :common-lisp-user)

(geometry:area 2.0)
