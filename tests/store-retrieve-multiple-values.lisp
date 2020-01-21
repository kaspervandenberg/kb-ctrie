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
  )
(finalize)
