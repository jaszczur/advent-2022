(defpackage :advent2022.dev
  (:use :cl))

(in-package :advent2022.dev)

(defun load-all ()
  (ql:quickload :advent2022)
  (ql:quickload :advent2022/test))

(load-all)

(defun load-and-test ()
  (load-all)
  (asdf:test-system :advent2022))

(defun test ()
  (1am:run))

#+nil
(progn
  (load-and-test)

  (test)


  )
