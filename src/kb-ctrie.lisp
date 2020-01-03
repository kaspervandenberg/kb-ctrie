(defpackage kb-ctrie
  (:use :cl)
  (:export :make-ctrie
	   :store
	   :retrieve
	   :remove-from-ctrie
	   :is-kb-ctrie
	   :not-a-kb-ctrie-error))
(in-package :kb-ctrie)

(define-condition not-a-kb-ctrie-error (error)
  ((non-ctrie-value
     :reader non-ctrie-value
     :documentation "value that was passed instead of a kb-ctrie"))
  (:documentation
   "one of the ctrie functions is called with a non-ctrie as argument"))

(defun make-ctrie ()
  "No code needed"
  '(kb-ctrie))

(defun store (ctrie key value)
  "Store `value`"
  (assert-is-kb-ctrie ctrie)
  (list (car ctrie)
        (acons key value (cadr ctrie))))

(defun retrieve (ctrie key &optional (default-not-found-value nil))
  "Retrieve a value previously store in `ctrie`"
  (assert-is-kb-ctrie ctrie)
  (let ((stored-cons (assoc key (cadr ctrie) :test #'equal)))
    (let ((foundp (consp stored-cons)))
      (values (if foundp
                (cdr stored-cons)
                default-not-found-value)
              foundp))))

(defun remove-from-ctrie (ctrie key)
  "Remove a value from `ctrie`"
  (assert-is-kb-ctrie ctrie)
  (list (car ctrie)
        (remove-if (lambda (x) (eq (car x) key))
                   (cdr ctrie))))

(defun is-kb-ctrie (ctrie)
  "Is `ctrie` a kb-ctrie? I.e. something one which `store` and `retrieve` can operate?"
  (and (listp ctrie)
       (eq (car ctrie)
	   'kb-ctrie)))

(defun assert-is-kb-ctrie (ctrie)
  "Signal an error if `ctrie` is not a kb ctrie."
  (if (not (is-kb-ctrie ctrie))
    (error 'not-a-kb-ctrie-error :non-ctrie-value ctrie)))
