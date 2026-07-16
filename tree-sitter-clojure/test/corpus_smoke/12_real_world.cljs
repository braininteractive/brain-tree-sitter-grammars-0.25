(ns app.views
  (:require [app.state :as state]))

(defn item-view [{:keys [id title done?] :as item}]
  [:li {:key id
        :class (when done? "done")
        :on-click #(state/toggle! id)}
   title])

(defn list-view []
  (let [items @state/items
        {:strs [q] :or {q ""}} @state/params]
    [:ul
     (for [item (filter #(re-find (re-pattern q) (:title %)) items)]
       ^{:key (:id item)} [item-view item])]))

(defprotocol Renderable
  (render [this]))

(defrecord Widget [id]
  Renderable
  (render [_] [:div (str "widget-" id)]))

(deftype Box [^:volatile-mutable contents]
  Object
  (toString [_] (str "Box<" contents ">")))

(defmulti shape-area :kind)
(defmethod shape-area :circle [{:keys [r]}]
  (* 3.14159 r r))

(-> {:a 1}
    (assoc :b 2)
    (update :a inc)
    (->> (merge {:z 0})))

(doto (java.util.HashMap.)
  (.put "k" "v"))

(.. Runtime getRuntime availableProcessors)

(set! *warn-on-reflection* true)
