(asdf:defsystem :advent2022
  :description "Advent of Code 2022 solution in Common Lisp"
  :author "Piotr Jaszczyk"

  :license "MIT"
  :version "0.0.1"

  :depends-on (:split-sequence
               :serapeum
               :alexandria
               :arrow-macros
               :cl-ppcre)

  :in-order-to ((asdf:test-op (asdf:test-op :advent2022/test)))

  :serial t
  :components ((:file "package")
               (:file "common/utils")
               (:file "01/code")
               (:file "02/rock")
               (:file "03/code")
               (:file "04/code")
               (:file "05/solution")))

(asdf:defsystem :advent2022/test
  :description "Test suite"

  :author "Piotr Jaszczyk"
  :license "MIT"

  :depends-on (:advent2022 :1am)

  :serial t
  :components ((:file "package.test")
               (:file "05/tests"))
  :perform (asdf:test-op (op system)
                         (funcall (read-from-string "1am:run"))))
