(format t "Hello, world!~%")

(defun greet (name)
  (format nil "hi ~a" name))

(print (greet "lisp"))
