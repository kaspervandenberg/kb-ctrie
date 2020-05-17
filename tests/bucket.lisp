(in-package :kb-ctrie-test)

(plan 1)
(subtest "Bucket"
  (ok
   (kb-ctrie::defstruct-bucket 4))
  (is
   (progn
     (kb-ctrie::defstruct-bucket 4)
     (let ((x (make-bucket
	       :filled-indexes-bitmap #b1001
	       :elements #(hello world))))
       (aref (slot-value x 'kb-ctrie::elements) 1)))
   'world)
  (is
   (progn
     (kb-ctrie::defstruct-bucket 4)
     (let ((x (make-bucket
	       :filled-indexes-bitmap #b1001
	       :elements #(hello world))))
       (slot-value x 'kb-ctrie::filled-indexes-bitmap)))
   #b1001))
(finalize)

