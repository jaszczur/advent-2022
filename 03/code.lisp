(ql:quickload '(:split-sequence
                :serapeum
                :arrow-macros))

(defpackage :advent2022.day03
  (:use :cl :arrow-macros))

(in-package :advent2022.day03)


(defun parse-line (line)
  (let ((middle (/ (length line) 2)))
    (list (subseq line 0 middle)
          (subseq line middle))))

(defun read-rucksacks (file-path)
  (with-open-file (file file-path)
    (loop for line = (read-line file nil nil)
          while line
          collecting (parse-line line))))

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

(->> #P"input.txt"
  read-rucksacks
  (mapcar #'find-duplicates)
  (mapcar #'priority-for-item)
  (reduce #'+)
  )

 ; => 7990 (13 bits, #x1F36)
 ; => (#\q #\Z #\t #\S #\T #\f #\j #\m #\Z #\W #\J #\c #\S #\q #\j #\p #\q #\Q #\t
 ; #\R #\S #\d #\S #\N #\s #\j #\H #\H #\G #\r #\L #\j #\g #\p #\H #\v #\v #\d
 ; #\J #\D #\Q #\p #\R #\D #\P #\D #\r #\p #\r #\c #\M #\b #\h #\B #\c #\F #\L
 ; #\G #\n #\r #\q #\Z #\r #\s #\W #\h #\R #\j #\Q #\J #\r #\v #\Q #\B #\R #\z
 ; #\m #\c #\Z #\R #\h #\w #\G #\z #\G #\g #\f #\V #\P #\J #\S #\F #\Q #\C #\f
 ; #\m #\r #\H #\w #\T #\Q #\b #\T #\h #\b #\M #\w #\l #\j #\Q #\s #\C #\b #\S
 ; #\d #\P #\N #\n #\H #\q #\B #\C #\r #\q #\d #\h #\s #\b #\T #\s #\z #\g #\v
 ; #\P #\g #\W #\d #\C #\V #\L #\B #\N #\c #\d #\L #\Z #\V #\T #\S #\p #\F #\d
 ; #\H #\g #\G #\Q #\J #\l #\j #\L #\p #\H #\z #\l #\h #\m #\w #\q #\Q #\h #\g
 ; #\b #\G #\r #\m #\v #\L #\P #\t #\F #\G #\T #\P #\t #\F #\S #\D #\V #\B #\w
 ; #\W #\F #\n #\f #\T #\n #\V #\p #\c #\b #\L #\R #\Q #\N #\s #\l #\V #\c #\j
 ; #\m #\z #\b #\W #\T #\J #\n #\q #\P #\G #\H #\g #\V #\G #\Z #\l #\z #\q #\g
 ; #\D #\C #\B #\g #\L #\q #\Z #\R #\N #\P #\n #\F #\V #\S #\D #\m #\T #\s #\M
 ; #\P #\D #\P #\j #\C #\g #\j #\S #\F #\f #\C #\L #\T #\c #\W #\v #\N #\P #\R
 ; #\v #\M #\g #\Q #\D #\v #\G #\t #\w #\z #\D #\B #\l #\V #\T #\j #\h #\Z #\M
 ; #\q #\S #\b #\s #\h #\f #\q #\L #\f #\J #\b #\F #\h #\Z #\B)
