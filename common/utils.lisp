(in-package :advent2022.utils)

(defun project-file (path)
  (asdf:system-relative-pathname "advent2022" path))

(defun read-lines (file-path)
  (with-open-file (file file-path)
    (loop for line = (read-line file nil nil)
          while line
          collecting line)))
