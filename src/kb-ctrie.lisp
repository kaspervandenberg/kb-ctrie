(defpackage kb-ctrie
  (:use :cl)
  (:export :make-ctrie
	   :store
	   :retrieve
	   :is-kb-ctrie
	   :not-a-kb-ctrie-error))
(in-package :kb-ctrie)

(define-condition not-a-kb-ctrie-error (error)
  ((non-ctire-value
     :reader non-ctrie-value
     :documentation "value that was passed instead of a kb-ctrie"))
  (:documentation
   "one of the ctrie functions is called with a non-ctrie as argument"))

(defun make-ctrie ()
  "No code needed"
  '(kb-ctrie))

(defun store (ctrie value)
  "Store `value`"
  (assert-is-kb-ctrie ctrie)
  (cons (car ctrie)
	value))

(defun retrieve (ctrie)
  "Retrieve a value previously store in `ctrie`"
  (assert-is-kb-ctrie ctrie)
  (cdr ctrie))

(defun is-kb-ctrie (ctrie)
  "Is `ctrie` a kb-ctrie? I.e. something one which `store` and `retrieve` can operate?"
  (and (listp ctrie)
       (eq (car ctrie)
	   'kb-ctrie)))

(defun assert-is-kb-ctrie (ctrie)
  "Signal an error if `ctrie` is not a kb ctrie."
  (if (not (is-kb-ctrie ctrie))
    (error 'not-a-kb-ctrie-error :non-ctrie-value ctrie)))
