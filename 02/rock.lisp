(ql:quickload '(:split-sequence
                :serapeum
                :arrow-macros))

(defpackage :advent2022.day02
  (:use :cl :arrow-macros :serapeum))

(in-package :advent2022.day02)

(defun parse-line (line)
  (split-sequence:split-sequence #\Space line))

(defun read-strategy (file-path)
  (with-open-file (file file-path)
    (loop for line = (read-line file nil nil)
          while line
          collecting (parse-line line))))

(defparameter shapes
  '(("A" . :rock)
    ("B" . :paper)
    ("C" . :scissors)
    ("X" . :rock)
    ("Y" . :paper)
    ("Z" . :scissors)))

(defparameter premium-for-shape
  '((:rock . 1)
    (:paper . 2)
    (:scissors . 3)))

;; rock > sci > paper > rock > ...
(defparameter round-winner
  '(((:rock :rock) . 0)
    ((:rock :paper) . 2)
    ((:rock :scissors) . 1)
    ((:paper :rock) . 1)
    ((:paper :paper) . 0)
    ((:paper :scissors) . 2)
    ((:scissors :rock) . 2)
    ((:scissors :paper) . 1)
    ((:scissors :scissors) . 0)))

(defun translate-shape (raw)
  (assocdr raw shapes :test #'equal))

(defun get-premium (shape)
  (assocdr shape premium-for-shape))

(defun winner (round)
  (assocdr round round-winner :test #'equal))

(defun parse-strategy (raw-strategy)
  (mapcar (lambda (round)
            (list (translate-shape (car round))
                  (translate-shape (cadr round))))
          raw-strategy))

(defun calculate-scores (strategy)
  (mapcar (lambda (round)
            (let ((premium1 (get-premium (car round)))
                  (premium2 (get-premium (cadr round)))
                  (winner (winner round)))
              (case winner
                (1 (list (+ 6 premium1) premium2))
                (2 (list premium1 (+ 6 premium2)))
                (0 (list (+ 3 premium1) (+ 3 premium2))))))
          strategy))

(defun sum-player2-scores (scores)
  (->> scores
    (mapcar #'cadr)
    (reduce #'+)))

(->> #P"input.txt"
  read-strategy
  parse-strategy
  calculate-scores
  sum-player2-scores)

 ; => 13446 (14 bits, #x3486)
