(in-package :kb-ctrie-test)

(defun ≺ (item-a item-b sequence)
    (beforep item-a item-b sequence))
(defun beforep (item-a item-b sequence)
  "Does `item-a` come before `item-b` in `sequence`"
  (< (position item-a sequence)
     (position item-b sequence)))

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
