(ns hello.core
  (:require [clojure.string :as str])
  (:import (java.util Date)))

(defn greet
  "Say hello to someone."
  [name]
  (println (str/join " " ["Hello," name])))

(defn -main [& args]
  (greet (or (first args) "world")))
