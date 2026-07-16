(def ^:private secret 42)

(def ^{:doc "documented" :added "1.0"} documented 1)

(defn typed ^String [^long n]
  (str n))

(def ^:dynamic *config* {})

(def multi ^:a ^:b ^{:c 1} [1 2 3])

(def old-style #^:deprecated legacy-var)
