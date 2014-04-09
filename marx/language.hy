;;;
;;;
;;;


(require acid.language)


(defmacro marx [&rest body]
  `(trip
    (import [aiodocker.docker [Docker]] [hy [HyKeyword]])
    (let [[docker (Docker "http://127.0.0.1:4243")]
          [events docker.events]
          [queue (.listen events)]]
      (spawn (events.run))
      (spawn ((fn/coroutine []
        (while true
          (setv event (yield-from (.get queue)))
          (emit (+
            (get :foo 0)
            ":docker-" (.get event "status")) event)
          (emit :docker event)))))
      ~@body)))
