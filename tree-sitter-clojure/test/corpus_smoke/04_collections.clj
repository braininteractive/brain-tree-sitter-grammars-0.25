(def a-map {:name "Ada" :year 1980, :tags #{:old :typed}})

(def nested {:outer {:inner [1 2 3]
                     :pairs '([a 1] [b 2])}})

(def a-vector [1 2.5 -3 4/5 0x1F 2r1010 36rZZ 1e3 1.5M 42N])

(def a-set #{:a :b :c})

(def a-list '(1 2 3))

(def empties [{} [] #{} ()])

(def chars [\a \newline \space \tab λ \o777])

(def specials [nil true false ##Inf ##-Inf ##NaN])
