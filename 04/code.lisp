(ql:quickload '(:split-sequence
                :serapeum
                :alexandria
                :arrow-macros))

(defpackage :advent2022.day04
  (:use :cl :arrow-macros))

(in-package :advent2022.day04)


(defun read-lines (file-path)
  (with-open-file (file file-path)
    (loop for line = (read-line file nil nil)
          while line
          collecting line)))

(defun parse-assignment (raw)
  (let* ((range (->> raw
                  (split-sequence:split-sequence #\-)
                  (mapcar #'parse-integer)))
         (beginning (first range))
         (end (second range))
         (length (- end beginning)))
    (alexandria:iota (+ 1 length) :start beginning)))

(defun parse-line (line)
  (let ((assignments (split-sequence:split-sequence #\, line)))
    (mapcar #'parse-assignment assignments)))

(defun fully-contains (outer-set possible-inner-set)
  (null (set-difference possible-inner-set outer-set)))

(defun either-fully-contains (set1 set2)
  (or (fully-contains set1 set2)
      (fully-contains set2 set1)))

(->> #P"input.txt"
  read-lines
  (mapcar #'parse-line)
  (count-if (lambda (ranges)
               (either-fully-contains (first ranges) (second ranges)))))

 ; => 602 (10 bits, #x25A)
