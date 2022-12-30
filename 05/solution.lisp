(in-package :advent2022.day05)

(defun cleanup-raw-crates (line)
  (-<> line
    (cl-ppcre:regex-replace-all "\\[" <> ",")
    (cl-ppcre:regex-replace-all "\\]" <> "")
    (cl-ppcre:regex-replace-all "    " <> ",")
    (cl-ppcre:regex-replace-all " " <> "")
    (cdr (cl-ppcre:split "," <>))))

(defun parse-raw-crates (raw-crates)
  (mapcar (lambda (crate)
            (if (equal crate "")
                nil
                crate))
          raw-crates))

(defun fill-with-nulls (list desired-len)
  (let* ((list-len (list-length list))
         (len-diff (- desired-len list-len)))
    (if (< 0 len-diff)
        (concatenate 'list list (make-list len-diff :initial-element nil))
        list)))

(defun normalize-crates (crates)
  (let ((max-len (loop for level in crates
                       maximize (list-length level))))
    (loop for level in crates
          collect (fill-with-nulls level max-len))))

(defun rotate (list-of-lists)
  (apply #'mapcar #'list list-of-lists))

(defun read-state (file-path)
  (->> file-path
    read-lines
    (mapcar #'cleanup-raw-crates)
    (mapcar #'parse-raw-crates)
    (remove-if #'null)
    normalize-crates
    rotate
    (mapcar #'reverse)
    (mapcar (lambda (stack) (remove-if #'null stack)))))

(defun parse-raw-moves (line)
  (cl-ppcre:register-groups-bind
      (how-many stack-from stack-to)
      ("move (\\d+) from (\\d+) to (\\d+)" line)
    (list (parse-integer how-many)
          (- (parse-integer stack-from) 1)
          (- (parse-integer stack-to) 1))))

(defun apply-move (state move)
  (let* ((amount (first move))
         (src-idx (second move))
         (dst-idx (third move))
         (src-stk (nth src-idx state))
         (dst-stk (nth dst-idx state))
         (crates-to-move (reverse (last src-stk amount)))
         (src-stk (butlast src-stk amount))
         (dst-stk (concatenate 'list dst-stk crates-to-move)))
    (loop for stack in state
          for idx from 0
          collect (cond
                    ((= idx src-idx) src-stk)
                    ((= idx dst-idx) dst-stk)
                    (t stack)))))

(defun run-moves (state moves)
  (if (null moves)
      state
      (run-moves (apply-move state (car moves))
                 (cdr moves))))

(defun read-moves (file-path)
  (->> file-path
    read-lines
    (mapcar #'parse-raw-moves)))

(let ((initial-state (read-state (project-file "05/input-initial.txt")))
      (moves (read-moves (project-file "05/input-moves.txt"))))
  (->> (run-moves initial-state moves)
    (mapcan #'last)
    (reduce (alexandria:curry #'concatenate 'string))))

 ; => "GRTSWNJHH"
