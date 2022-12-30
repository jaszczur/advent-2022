(defpackage :advent2022.dev
  (:use :cl))

(in-package :advent2022.dev)

(defun load-all ()
  (ql:quickload :advent2022)
  (ql:quickload :advent2022/test))

(defun test ()
  (1am:run))

(defun load-and-test ()
  (load-all)
  (asdf:test-system :advent2022))

(load-all)

#+nil
(progn
  (load-and-test)

  (test)


  )
