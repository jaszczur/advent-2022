(in-package :advent2022.day06)

(defun read-stream (path)
  (coerce (car (read-lines path)) 'list))

(defun window (size lst)
  (let ((acc (make-list 0)))
    (loop for elem in lst
          for wdw = (setf acc
                          (cons elem
                                (if (= size (list-length acc))
                                    (butlast acc)
                                    acc)))
          when (= size (list-length acc))
            collect (reverse wdw))))


(window 3 '(1 2 3 4 5 6 7 8 9 10))

(progn
  (defun solve-part-1 ()
    (->> (project-file "06/input.txt")
      read-stream
      (window 3)))

  (solve-part-1))



(defun solve-part-2 () nil)
