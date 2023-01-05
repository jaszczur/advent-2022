(in-package :advent2022.day07)

(defclass fs-node ()
  ((name :initarg :name
         :accessor fs-node-name)
   (parent :initarg :parent
           :accessor fs-node-parent)
   (size :initarg :size
         :initform nil)))

(defclass fs-directory (fs-node)
  ((contents :initarg :contents
             :initform nil
             :accessor fs-directory-contents)))

(defclass fs-file (fs-node) ())

(defclass evaluation-state ()
  ((root :initarg :root
         :accessor evaluation-state-root)
   (cwd :initarg :cwd
        :accessor evaluation-state-cwd)))

(defun create-evaluation-state ()
  (let ((root (make-instance 'fs-directory
                             :name ""
                             :parent nil)))
    (make-instance 'evaluation-state
                   :root root
                   :cwd root)))

(defun eval-cmd (state cmd)
  (when (equal (car cmd) "cd")
    (if (equal (cadr cmd) "..")
        (setf (evaluation-state-cwd state)
              (-> state evaluation-state-cwd fs-node-parent))
        (let ((new-dir (make-instance 'fs-directory
                                      :name (cdr cmd)
                                      :parent (evaluation-state-cwd state))))
          (setf (-> state evaluation-state-cwd fs-directory-contents)
                (cons new-dir
                      (-> state evaluation-state-cwd fs-directory-contents)))
          (setf (evaluation-state-cwd state)
                new-dir)))))

(defun add-dir (state name)
  #+nil
  (setf (-> state evaluation-state-cwd fs-directory-contents)
        (cons (make-instance 'fs-directory
                             :name name
                             :parent (evaluation-state-cwd state))
              (-> state evaluation-state-cwd fs-directory-contents))))

(defun add-file (state file-spec)
  (setf (-> state evaluation-state-cwd fs-directory-contents)
        (cons (make-instance 'fs-file
                             :size (parse-integer (car file-spec))
                             :name (cadr file-spec)
                             :parent (evaluation-state-cwd state))
              (-> state evaluation-state-cwd fs-directory-contents))))

(defun parse-line (state line)
  (let* ((cmd (cl-ppcre:split " " line))
         (head (car cmd)))
    (cond
      ((equal head "$") (eval-cmd state (cdr cmd)))
      ((equal head "dir") (add-dir state (cadr cmd)))
      (t (add-file state cmd)))
    state))

(defun parse-shell-session (lines)
  (reduce #'parse-line
          lines
          :initial-value (create-evaluation-state)))

(->> (project-file "07/input.txt")
  read-lines
  parse-shell-session)

(parse-shell-session '("$ cd /"
                       "$ ls"
                       "111 file1"
                       "222 file2"
                       "dir dir1"
                       "dir dir2"
                       "$ cd dir1"
                       "$ ls"
                       "333 file11"
                       "444 file22"
                       "$ cd .."
                       "$ cd dir2"
                       "$ ls"
                       "555 file21"
                       "666 file22"))


(defun solve-part-1 () nil)

(defun solve-part-2 () nil)
