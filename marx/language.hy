;;;
;;;
;;;


(require acid.language)


(defmacro go-define [variables &rest body]
  (setv macroed_variables [])
  (if (not (isinstance variables HyList))
    (macro-error variables "define lexical context must be a list"))
  (for* [variable variables]
    (if (isinstance variable HyList)
      (do (if (!= (len variable) 2)
            (macro-error variable "define variable assignments must contain two items"))
            (.append macroed-variables `(go-setv ~(get variable 0) ~(get variable 1))))
      (.append macroed-variables `(go-setv ~variable None))))
  `(do
     ~@macroed-variables
     ~@body))


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
