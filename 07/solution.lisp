(in-package :advent2022.day07)

(defclass fs-node ()
  ((name :initarg :name
         :accessor fs-node-name)
   (path :initarg :path
         :accessor fs-node-path)
   (parent :initarg :parent
           :accessor fs-node-parent)
   (size :initarg :size
         :initform nil
         :accessor fs-node-size)))

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
                             :path nil
                             :parent nil)))
    (make-instance 'evaluation-state
                   :root root
                   :cwd root)))

(defun eval-cmd (state cmd)
  (when (equal (car cmd) "cd")
    (if (equal (cadr cmd) "..")
        ;; going back to parent directory
        (setf (evaluation-state-cwd state)
              (-> state evaluation-state-cwd fs-node-parent))

        ;; going to child directory
        (let ((new-dir (make-instance 'fs-directory
                                      :name (cadr cmd)
                                      :path (cons (cadr cmd) (-> state evaluation-state-cwd fs-node-path))
                                      :parent (evaluation-state-cwd state))))
          (setf (-> state evaluation-state-cwd fs-directory-contents)
                (cons new-dir
                      (-> state evaluation-state-cwd fs-directory-contents)))
          (setf (evaluation-state-cwd state)
                new-dir)))))

(defun add-file (state file-spec)
  (setf (-> state evaluation-state-cwd fs-directory-contents)
        (cons (make-instance 'fs-file
                             :size (parse-integer (car file-spec))
                             :name (cadr file-spec)
                             :path (cons (cadr file-spec) (-> state evaluation-state-cwd fs-node-path))
                             :parent (evaluation-state-cwd state))
              (-> state evaluation-state-cwd fs-directory-contents))))

(defun parse-line (state line)
  (let* ((cmd (cl-ppcre:split " " line))
         (head (car cmd)))
    (cond
      ((equal head "$") (eval-cmd state (cdr cmd)))
      ((equal head "dir") nil)
      (t (add-file state cmd)))
    state))

(defun cleanup-fs-tree (node)
  (setf (fs-node-path node) (reverse (fs-node-path node)))
  (when (typep node 'fs-directory)
    (setf (fs-directory-contents node)
          (mapcar #'cleanup-fs-tree (fs-directory-contents node)))
    (setf (fs-node-size node)
          (->> node
            fs-directory-contents
            (mapcar #'fs-node-size)
            (reduce #'+))))
  node)

(defun parse-shell-session (lines)
  (-<> lines
    (reduce #'parse-line
            <>
            :initial-value (create-evaluation-state))
    (evaluation-state-root <>)
    (cleanup-fs-tree <>)
    (fs-directory-contents <>)
    (car <>)))

(defun find-nodes (pred node)
  (let ((children (when (typep node 'fs-directory)
                    (->> node
                      fs-directory-contents
                      (mapcan (alexandria:curry #'find-nodes pred))))))
    (if (funcall pred node)
        (cons node children)
        children)))

(defun sum-sizes-less-than-100k (root)
  (->> root
    (find-nodes (lambda (node)
                  (and (typep node 'fs-directory)
                       (< (fs-node-size node) 100000))))
    (mapcar #'fs-node-size)
    (reduce #'+)))

(defun solve-part-1 ()
  (->> (project-file "07/input.txt")
    read-lines
    parse-shell-session
    sum-sizes-less-than-100k))

(solve-part-1)

 ; => 1644735 (21 bits, #x1918BF)
(defun solve-part-2 () nil)
