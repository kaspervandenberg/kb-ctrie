(defpackage kb-ctrie
  (:use :cl)
  (:export :make-ctrie
	   :store
	   :retrieve
	   :remove-from-ctrie
	   :is-kb-ctrie
	   :not-a-kb-ctrie-error))
