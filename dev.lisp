(defpackage :advent2022.dev
  (:use :cl))

(in-package :advent2022.dev)

(defun load-all ()
  (ql:quickload :advent2022)
  (ql:quickload :advent2022/test))

(defun test ()
  (asdf:test-system :advent2022))

(defun load-and-test ()
  (load-all))

(load-all)

#+nil
(progn

  (test)

  )
