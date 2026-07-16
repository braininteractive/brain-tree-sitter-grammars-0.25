(def inc-all (map #(+ % 1) [1 2 3]))

(def add-pairs (map #(+ %1 %2) [1 2] [3 4]))

(def rest-args #(apply max %&))

(def word-re #"\w+")

(def tricky-re #"(?i)[a-z\"\\]+\s*")

(defn find-words [s]
  (re-seq #"\p{L}+" s))
