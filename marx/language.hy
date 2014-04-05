;;;
;;;
;;;


(require acid.language)


(defmacro marx [&rest body]
  `(trip
    (import [marx.aiodocker [Docker]]
            [hy [HyKeyword]])
    (let [[docker (Docker "http://127.0.0.1:4243")]]
      ~@body
      (.run-until-complete loop
        (.events docker
          (fn [data]
            (emit (+ (get :foo 0) ":" "docker-" (get data "status")) data)
            (emit :docker data)))))))
