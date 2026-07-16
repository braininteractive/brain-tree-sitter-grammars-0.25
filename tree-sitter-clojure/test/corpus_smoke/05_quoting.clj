(def quoted 'symbol)
(def quoted-list (quote (a b c)))

(defmacro syntax-quoted []
  `(list 1 2 ~(+ 1 2) ~@[4 5 6]))

(def nested-sq
  `(outer ~(inner `(deep ~'raw))))

(def unquote-in-let
  `(let [x# 1]
     (+ x# ~(* 2 3))))
