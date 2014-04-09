(require marx.language)


(marx
  (on :docker-start
    (define [[container (get event "container")]
             [show (go (.show container))]]
      (print show))))
