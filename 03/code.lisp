(ql:quickload '(:split-sequence
                :serapeum
                :arrow-macros))

(defpackage :advent2022.day03
  (:use :cl :arrow-macros))

(in-package :advent2022.day03)


(defun read-lines (file-path)
  (with-open-file (file file-path)
    (loop for line = (read-line file nil nil)
          while line
          collecting line)))

(defun parse-rucksack (line)
  (let ((middle (/ (length line) 2)))
    (list (subseq line 0 middle)
          (subseq line middle))))


(defun find-duplicates (rucksack)
  (loop named outer
        for item1 across (first rucksack)
        do
           (loop for item2 across (second rucksack) do
             (when (eql item1 item2)
               (return-from outer item1)))))

(defun priority-for-item (item)
  (let ((code (char-code item)))
    (if (< code (char-code #\a))
        ;; uppercase 27-52
        (+ (- code (char-code #\A)) 27)

        ;; lowercase
        (+ (- code (char-code #\a)) 1))))

;; part 1
(->> #P"input.txt"
  read-lines
  (mapcar #'parse-line)
  (mapcar #'find-duplicates)
  (mapcar #'priority-for-item)
  (reduce #'+)
  )
 ; => 7990 (13 bits, #x1F36)

;; part 2
(defun assign-to-groups (lines)
  (serapeum:batches lines 3))


(defun find-duplicates-in-group (rucksacks)
  (loop for item1 across (first rucksacks) do
    (when (and (find item1 (second rucksacks)) (find item1 (third rucksacks)))
            (return item1))))

(->> #P"input.txt"
  read-lines
  assign-to-groups
  (mapcar #'find-duplicates-in-group)
  (mapcar #'priority-for-item)
  (reduce #'+)
  )

 ; => 2602 (12 bits, #xA2A)
