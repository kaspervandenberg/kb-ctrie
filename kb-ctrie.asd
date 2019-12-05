#|
  This file is a part of kb-ctrie project.
|#

(defsystem "kb-ctrie"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "kb-ctrie"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.md"))
  :in-order-to ((test-op (test-op "kb-ctrie-test"))))
