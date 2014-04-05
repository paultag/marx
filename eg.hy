(require marx.language)


(marx
  ; (on :docker (print "Generic" event))
  (on :docker-create (print "Create" event))
  (on :docker-die (print "Die" event)))
