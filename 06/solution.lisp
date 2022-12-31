(in-package :advent2022.day06)

(defun window-with-index (size input-list)
  (let* ((first-wdw (subseq input-list 0 size))
         (acc (reverse first-wdw))
         (lst (subseq input-list size)))
    (cons (list (- size 1) first-wdw)
          (loop for elem in lst
                for idx from size
                for wdw = (setf acc
                                (cons elem (butlast acc)))
                collect (list idx (reverse wdw))))))

(defun seq-unique (wdw)
  (uniquep (second wdw) :test #'eq))

(defun find-marker (str &key window-size)
  (->> (coerce str 'list)
    (window-with-index window-size)
    (find-if #'seq-unique)
    car
    (+ 1)))

(defun find-sop-marker (str)
  (find-marker str :window-size 4))

(defun find-som-marker (str)
  (find-marker str :window-size 14))


(defun solve-part-1 ()
  (->> (project-file "06/input.txt")
    read-lines
    car
    find-sop-marker))

(defun solve-part-2 ()
  (->> (project-file "06/input.txt")
    read-lines
    car
    find-som-marker))
