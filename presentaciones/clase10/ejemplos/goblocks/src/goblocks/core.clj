(ns goblocks.core
  (:gen-class))

(require '[clojure.core.async :refer [<!! <! >! chan go go-loop close!]])

(defn -main []
  (let [c (chan)
        suma (atom 0)
        workers (for [_ (range 100)]
                  (go-loop []
                    (let [n (<! c)]
                      (when (some? n)
                        (swap! suma + n)
                        (recur)))))]
    (go
      (doseq [x (range 1000)]
        (>! c x))
      (close! c))

    (doall (map <!! workers))
    (println @suma)))
