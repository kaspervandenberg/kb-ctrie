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
                ((:test-file "kb-ctrie"))))
  :description "Test system for kb-ctrie"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
