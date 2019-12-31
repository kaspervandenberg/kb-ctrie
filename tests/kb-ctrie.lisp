(defpackage kb-ctrie-test
  (:use :cl
        :kb-ctrie
        :prove))
(in-package :kb-ctrie-test)

;; NOTE: To run this test file, execute `(asdf:test-system :kb-ctrie)' in your Lisp.

(plan 1)

(subtest "Store & retrieve single value"
  (is
   (retrieve (store (make-ctrie) 'dummy-key "value") 'dummy-key)
   "value"
   "Retrieved is stored")
  (ok
   (is-kb-ctrie (make-ctrie))
   "make-ctrie creates kb-ctries")
  (ok
   (is-kb-ctrie (store (make-ctrie) 'dummy-key "value"))
   "store returns a kb-ctrie")
  (is-error
   (store 'no-ctrie 'dummy-key "value")
   'not-a-kb-ctrie-error
   "calling store on something that is not a ctrie should signal an error")
  (is-error
   (retrieve 'no-ctrie 'dummy-key)
   'not-a-kb-ctrie-error
   "calling retrieve on something that is not a ctrie should signal an error")
  (is
    (retrieve (make-ctrie) 'dummy-key)
    nil
    "retrieve on empty kb-ctrie should return nil")
  (is-values
    (retrieve (make-ctrie) 'dummy-key)
    '(nil nil)
    "retrieve on empty kb-ctrie should return two values: nil result and falsey foundp")
  (isnt
    (multiple-value-bind (result foundp)
                      (retrieve (store (make-ctrie) 'dummy-key nil) 'dummy-key)
                      foundp)
    nil
    "retrieve's second value on ctrie with explicit nil should be truthy")
  (is
    (retrieve (make-ctrie) 'dummy-key 'empty-placeholder)
    'empty-placeholder
    "retrieve on empty kb-ctrie should return the specified default")
  (is-values
   (let ((ctrie-with-first-val (store (make-ctrie) 'dummy-key 'first-val)))
     (let ((retrieved-first-value (retrieve ctrie-with-first-val 'dummy-key))
           (ctrie-with-second-val (store ctrie-with-first-val 'dummy-key 'second-val)))
               (let ((retrieved-second-value (retrieve ctrie-with-second-val 'dummy-key)))
         (values retrieved-first-value retrieved-second-value))))
   '(first-val second-val)
   "store should overwrite the first value with a second value")
  (is-values
   (let ((ctrie-with-val (store (make-ctrie) 'dummy-key 'value)))
     (let ((retrieved-value (retrieve ctrie-with-val 'dummy-key)))
       (let ((ctrie-with-removed-val (remove-from-ctrie ctrie-with-val 'dummy-key)))
	 (let ((retrieved-no-value (retrieve ctrie-with-removed-val 'dummy-key)))
	   (values retrieved-value retrieved-no-value)))))
   '(value nil)
   "remove should return the ctrie to no value")
  )

(finalize)
