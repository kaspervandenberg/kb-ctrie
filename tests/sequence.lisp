(in-package :kb-ctrie-test)

(defmacro rest-arg-before-others (original-arg-values rest-arg-symbol fixed-arg-symbol &body body)
  "Alter the order of arguments: the &rest argument comes first, after it come the required arguments.
  The rest-symbol receives the remaining argument-values after the other symbols have received their values."
  (let ((reversed-args-symbol (gensym "REVERSED-ARGS-")))
    `(let ((,reversed-args-symbol (reverse  ,original-arg-values)))
      (let ((,rest-arg-symbol (reverse (rest ,reversed-args-symbol)))
	    (,fixed-arg-symbol (first ,reversed-args-symbol)))
	,@body))))

(defun ≺ (&rest args)
    "Syntax `(beforep item-1 [item-2 [item-3 [... [item-n]]]] sequence)`
  Do the items come in order in `sequence`."
  (apply #'beforep args))

(defun beforep (&rest args)
  "Syntax `(beforep item-1 [item-2 [item-3 [... [item-n]]]] sequence)`
  Do the items come in order in `sequence`."
  (when (>= (length args) 2)
    (rest-arg-before-others args items seq
      (flet ((pos-in-seq (x) (position x seq)))
	(let ((positions (mapcar #'pos-in-seq items)))
	  (and (not (some #'null positions))
	       (apply #'< positions)))))))

(defun all-permutations (sequence)
  "Give a list of all permutations of the elements in `sequence`"
  (cond ((null sequence)
	 '(()))
	(t
	 (mapcan (lambda (item)
		   (mapcar (lambda (rest-permutations)
			     (cons item rest-permutations))
			   (all-permutations (remove item sequence :test #'eq :count 1))))
		 sequence))))

