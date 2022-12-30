(in-package :advent2022.day04)

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

(defun overlap (set1 set2)
  (not (null (intersection set1 set2))))


;; part 1

(defun solve-part-1 ()
 (->> (project-file "04/input.txt")
   read-lines
   (mapcar #'parse-line)
   (count-if (lambda (ranges)
               (either-fully-contains (first ranges) (second ranges))))))

(defun solve-part-2 ()
  (->> (project-file "04/input.txt")
    read-lines
    (mapcar #'parse-line)
    (count-if (lambda (ranges)
                (overlap (first ranges) (second ranges))))))
