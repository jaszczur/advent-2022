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
    ("X" . :lose)
    ("Y" . :draw)
    ("Z" . :win)))

(defparameter premium-for-shape
  '((:rock . 1)
    (:paper . 2)
    (:scissors . 3)))

;; rock > sci > paper > rock > ...
(defparameter round-winner
  '(((:rock :rock) . :draw)
    ((:rock :paper) . :win)
    ((:rock :scissors) . :lose)
    ((:paper :rock) . :lose)
    ((:paper :paper) . :draw)
    ((:paper :scissors) . :win)
    ((:scissors :rock) . :win)
    ((:scissors :paper) . :lose)
    ((:scissors :scissors) . :draw)))

(defparameter next-move
  (mapcar (lambda (x)
            (let ((other (caar x))
                  (my (cadar x))
                  (advice (cdr x)))
              `((,other ,advice) . ,my)))
          round-winner))

(defun translate-shape (raw)
  (assocdr raw shapes :test #'equal))

(defun get-premium (shape)
  (assocdr shape premium-for-shape))

(defun shape-for-advice (round)
  (assocdr round next-move :test #'equal))

(defun round-premium-points (round)
  (mapcar #'get-premium round))

(defun winsp (round)
  (assocdr round round-winner :test #'equal))

(defun round-winner-points (round)
  (case (winsp round)
    (:lose '(6 0))
    (:win '(0 6))
    (:draw '(3 3))))

(defun sum-round-points (px0 &rest pxs)
  (apply #'mapcar
         (lambda (round-points-0 &rest round-points-others)
           (apply #'+ round-points-0 round-points-others))
         px0
         pxs))

(defun parse-strategy (raw-strategy)
  (mapcar (lambda (round)
            (list (translate-shape (car round))
                  (translate-shape (cadr round))))
          raw-strategy))

(defun map-advice-to-shape (strategy)
  (mapcar (lambda (round)
            (list (car round) (shape-for-advice round)))
          strategy))

(defun calculate-scores (strategy)
  (mapcar (lambda (round)
            (sum-round-points (round-premium-points round)
                              (round-winner-points round)))
          strategy))

(defun sum-player2-scores (scores)
  (->> scores
    (mapcar #'cadr)
    (reduce #'+)))

(defun solve ()
  (->> (project-file "02/input.txt")
    read-strategy
    parse-strategy
    map-advice-to-shape
    calculate-scores
    sum-player2-scores
    ))

;; part 1 result:
 ; => 13446 (14 bits, #x3486)
;; part 2 result:
 ; => 13509 (14 bits, #x34C5)
