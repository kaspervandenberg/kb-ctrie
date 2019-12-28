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
  (is-error
   (store 'no-ctrie "value")
   'not-a-kb-ctrie-error
   "calling store on something that is not a ctrie should signal an error")
  (is-error
   (retrieve 'no-ctrie)
   'not-a-kb-ctrie-error
   "calling retrieve on something that is not a ctrie should signal an error")
  (is
    (retrieve (make-ctrie))
    nil
    "retrieve on empty kb-ctrie should return nil")
  (is-values
    (retrieve (make-ctrie))
    '(nil nil)
    "retrieve on empty kb-ctrie should return two values: nil result and falsey foundp")
  (isnt
    (multiple-value-bind (result foundp)
                      (retrieve (store (make-ctrie) nil))
                      foundp)
    nil
    "retrieve's second value on ctrie with explicit nil should be truthy")
  (is
    (retrieve (make-ctrie) 'empty-placeholder)
    'empty-placeholder
    "retrieve on empty kb-ctrie should return the specified default")
  )

(finalize)
