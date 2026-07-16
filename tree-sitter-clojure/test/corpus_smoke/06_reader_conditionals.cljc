(ns platform.core)

(def target
  #?(:clj  :jvm
     :cljs :js
     :default :unknown))

(defn now []
  #?(:clj (System/currentTimeMillis)
     :cljs (.getTime (js/Date.))))

(def features
  [#?@(:clj [:threads :classes]
       :cljs [:promises])
   :common])
