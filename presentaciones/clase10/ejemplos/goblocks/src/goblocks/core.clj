(ns goblocks.core
  (:gen-class)
  (:require
   [clojure.core.async :as async :refer [<!! <! >! chan go close!]]))

(defn -main []
  (let [entrada (chan)
        _ (go (doseq [_ (range 10000)]
                (>! entrada (rand-int 100)))
              (close! entrada))
        workers (for [_ (range 100)]
                  (go (loop [suma 0]
                        (let [n (<! entrada)]
                          (if (nil? n)
                            suma
                            (recur (+ suma n)))))))
        salidas (async/merge workers)
        resultado (go (<! (async/reduce + 0 salidas)))]
    (println (<!! resultado))))
