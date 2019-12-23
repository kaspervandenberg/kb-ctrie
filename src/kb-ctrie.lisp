(defpackage kb-ctrie
  (:use :cl)
  (:export :make-ctrie
	   :store
	   :retrieve))
(in-package :kb-ctrie)

(defun make-ctrie ()
  "No code needed"
  nil)

(defun store (ctrie value)
  "Store `value`"
  (cons ctrie value))

(defun retrieve (ctrie)
  "Retrieve a value previously store in `ctrie`"
  (cdr ctrie))
