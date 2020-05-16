#|
  This file is a part of kb-ctrie project.
|#

(defsystem "kb-ctrie-test"
  :defsystem-depends-on ("prove-asdf")
  :author "Kasper van den Berg <kasper@kaspervandenberg.net>"
  :license "MIT"
  :depends-on ("kb-ctrie"
               "prove")
  :components ((:module "tests"
                :components
                ((:file "package")
		 (:file "sequence")
		 (:test-file "store-retrieve-single-value")
		 (:test-file "store-retrieve-multiple-values")
		 )))
  :description "Test system for kb-ctrie"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
