#|
  This file is a part of kb-ctrie project.
|#

(defsystem "kb-ctrie"
  :version "0.1.0"
  :author "Kasper van den Berg"
  :license "MIT"
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "package")
		 (:file "kb-ctrie"))))
  :description "Aleksander Prokopec's ctrie for Common Lisp"
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.md"))
  :in-order-to ((test-op (test-op "kb-ctrie-test"))))
