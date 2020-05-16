(in-package :kb-ctrie-test)

(plan 1)
(subtest "Store & retrieve multiple values"
  (is
   (let ((ctrie (store (store (make-ctrie) 'key-a 'val-a) 'key-b 'val-b)))
     (list (retrieve ctrie 'key-a) (retrieve ctrie 'key-b)))
   '(val-a val-b)
   "Store and retrieve values by multiple keys")
  (isnt
   (retrieve
    (store (make-ctrie) 'key 'value)
    'different-key)
   'value
   "Retrieve should not retrieve values stored with different keys")
  (is
   (retrieve (remove-from-ctrie (store (store (make-ctrie) 'key-a 'val-a) 'key-b 'val-b) 'key-b) 'key-a)
   'val-a
   "Remove should not remove other keys")
  (is-values
   (retrieve (remove-from-ctrie (store (store (make-ctrie) 'key-a 'value-first) 'key-a 'value-second) 'key-a) 'key-a)
   '(nil nil)
   "Removing a key with value that was overwritten should remove the key not reinstate the previous value")
  (labels ((store-a (ctrie &optional (context nil))
	      (values (store ctrie 'key-a 'value-a1)
		      context))
	    (update-a (ctrie &optional (context nil))
	      (values (store ctrie 'key-a 'value-a2)
		      context))
	    (store-b (ctrie &optional (context nil))
	      (values (store ctrie 'key-b 'value-b)
		      context))
	    (del-b (ctrie &optional (context nil))
	      (values (remove-from-ctrie ctrie 'key-b)
		      context))
	    (retrieve-a (ctrie &optional (context nil))
	      (values ctrie
		      (acons 'result-a (retrieve ctrie 'key-a) context)))
	    (retrieve-b (ctrie &optional (context nil))
	      (values ctrie
		      (acons 'result-b (retrieve ctrie 'key-b) context)))
	    (in-order-store-update-retrievep (seq)
	      (≺ #'store-a #'update-a #'retrieve-a seq))
	    (in-order-store-del-retrievep (seq)
	      (≺ #'store-b #'del-b #'retrieve-b seq)))
     (let* ((ops-to-test (list #'store-a #'update-a #'store-b #'del-b #'retrieve-a #'retrieve-b))
	    (ops-permutations
	     (remove-if (compose #'not
				 (conjoin #'in-order-store-update-retrievep
					  #'in-order-store-del-retrievep))
			(all-permutations ops-to-test))))
       (mapcar #'(lambda (ops)
		   (let ((result (multiple-value-list (funcall (apply #'multiple-value-compose (reverse ops)) (make-ctrie) nil))))
		     (is
		      (cdr (assoc 'result-a (cadr result)))
		      'value-a2
		      (format nil "Retrieved ~a (expected ~a) in ~a"
			      (assoc 'result-a (cadr result))
			      'value-a2
			      ops))
		     (is
		      (cdr (assoc 'result-bv (cadr result)))
		      nil
		      (format nil "Retrieved ~a (expected ~a) in ~a"
			      (assoc 'result-a (cadr result))
			      'value-a2
			      ops))
		     ))
	       ops-permutations
	       )
     )))
(finalize)
