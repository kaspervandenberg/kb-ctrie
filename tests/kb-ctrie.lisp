(defpackage kb-ctrie-test
  (:use :cl
        :kb-ctrie
        :prove))
(in-package :kb-ctrie-test)

;; NOTE: To run this test file, execute `(asdf:test-system :kb-ctrie)' in your Lisp.

(plan 1)

(subtest "Store & retrieve single value"
  (is
   (retrieve (store (make-ctrie) "value"))
   "value"
   "Retrieved is stored")
  (ok
   (is-kb-ctrie (make-ctrie))
   "make-ctrie creates kb-ctries")
  (ok
   (is-kb-ctrie (store (make-ctrie) "value"))
   "store returns a kb-ctrie")
  )

(finalize)
