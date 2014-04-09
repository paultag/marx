(require marx.language)


(marx
  (on :docker-start
    (define [[container (get event "container")]
             [show (go (.show container))]]
      (print "Container started. You have 5 seconds.")
      (go (.sleep asyncio 5))
      (go (.kill container))
      (print "pwned."))))
