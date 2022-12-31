(in-package :advent2022.utils)

(defun project-file (path)
  (asdf:system-relative-pathname "advent2022" path))

(defun read-lines (file-path)
  (with-open-file (file file-path)
    (loop for line = (read-line file nil nil)
          while line
          collecting line)))

;;;; Collection utilities

(defun duplicatesp (lst &key (test #'=))
  "DUPLICATESP is a predicate which checks if given list lst contains duplicated elements.
test is used for equality check. Returns first duplicate element or NIL when no
duplicates was found."
  (loop for (elem . rest) on lst
        when (member elem rest :test test)
          do (return elem)))

(defun uniquep (lst &key (test #'=))
  "UNIQUEP is a predicate which checks if given list lst does not contain duplicated elements.
test is used for equality check. Returns T or NIL."
  (not (duplicatesp lst :test test)))

