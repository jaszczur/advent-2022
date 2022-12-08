(ql:quickload '(:split-sequence
                :arrow-macros))

(defpackage :advent2022.day01
  (:use :cl :arrow-macros))

(in-package :advent2022.day01)

(defun read-ints (file-path)
  (with-open-file (file file-path)
    (loop for line = (read-line file nil nil)
          while line
          collecting (parse-integer line :junk-allowed t))))

(defun sum-calories (log)
  (loop for elf in log collect
        (loop for calories in elf
              summing calories)))

(defun read-totals-log (file-path)
  (let* ((raw-energy-log (read-ints file-path))
         (energy-log (split-sequence:split-sequence-if #'null raw-energy-log)))
    (sum-calories energy-log)))

(defparameter totals-log (read-totals-log #P"input.txt"))

(defun top-calories (log)
  (loop for total in log
        maximizing total))

(top-calories totals-log)
 ; => 74711 (17 bits, #x123D7)

(defun most-calories (log &key (n 3))
  (subseq (sort log #'>) 0 n))

(->> totals-log
  most-calories
  (reduce #'+))
 ; => 209481 (18 bits, #x33249)
