(def simple :foo)
(def with-ns :user/name)
(def auto-resolved ::local)
(def alias-resolved ::str/trimmed)
(def weird :kebab-case-key?)
(def numeric :123abc)

(defn lookup [m]
  [(:foo m)
   (get m ::local)
   (m :user/name)])
