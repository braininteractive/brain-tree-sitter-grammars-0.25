(defn add
  ([x] x)
  ([x y] (+ x y))
  ([x y & more] (reduce + (add x y) more)))

(defmacro unless
  "Inverted `when`."
  [test & body]
  `(if ~test
     nil
     (do ~@body)))

(defmacro with-timing [& body]
  `(let [start# (System/nanoTime)
         result# (do ~@body)]
     [result# (- (System/nanoTime) start#)]))

(defn- private-helper [x]
  (* x x))
