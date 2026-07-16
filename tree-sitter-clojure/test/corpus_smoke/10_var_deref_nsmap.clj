(def the-var #'clojure.core/map)

(defn var-meta []
  (meta #'the-var))

(def state (atom {:count 0}))

(def snapshot @state)

(def also-deref (deref state))

(def ns-keyed-map #::{:a 1 :b 2})

(def ns-named-map #:person{:name "Rich" :lang "clojure"})

(def auto-ns-map #::str{:sep ","})
