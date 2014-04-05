(require marx.language)


(marx
  ; (on :docker (print "Generic" event))
  (on :docker-create
    (print event)))
