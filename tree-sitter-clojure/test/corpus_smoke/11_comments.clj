; line comment
;; double line comment

(def x 1) ; trailing comment

#_(def ignored-form (this (never runs)))

#_#_ (def also-ignored 1) (def and-this-too 2)

(comment
  (def scratch 1)
  (+ scratch 2))

(defn documented
  "docstring, not a comment"
  []
  ;; internal note
  nil)

#!/usr/bin/env bb
