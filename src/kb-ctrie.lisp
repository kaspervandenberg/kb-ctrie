(defpackage kb-ctrie
  (:use :cl)
  (:export :make-ctrie
	   :store
	   :retrieve
	   :is-kb-ctrie))
(in-package :kb-ctrie)

(defun make-ctrie ()
  "No code needed"
  '(kb-ctrie))

(defun store (ctrie value)
  "Store `value`"
  (cons (car ctrie)
	value))

(defun retrieve (ctrie)
  "Retrieve a value previously store in `ctrie`"
  (cdr ctrie))

(defun is-kb-ctrie (ctrie)
  "Is `ctrie` a kb-ctrie? I.e. something one which `store` and `retrieve` can operate?"
  (and (listp ctrie)
       (eq (car ctrie)
	   'kb-ctrie)))
