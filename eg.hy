(require marx.language)


(marx
  (on :docker-start
    (go-define [[test (.show (get event "container"))]]
      (print test))))
