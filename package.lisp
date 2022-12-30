(defpackage :advent2022.utils
  (:use :cl)
  (:export
   :project-file
   :read-lines))

(defpackage :advent2022.day01
  (:use :cl :advent2022.utils :arrow-macros))

(defpackage :advent2022.day02
  (:use :cl :advent2022.utils :arrow-macros)
  (:import-from :serapeum :assocdr))

(defpackage :advent2022.day03
  (:use :cl :advent2022.utils :arrow-macros))

(defpackage :advent2022.day04
  (:use :cl :advent2022.utils :arrow-macros)
  (:export :solve-part-1
           :solve-part-2))

(defpackage :advent2022.day05
  (:use :cl :advent2022.utils :arrow-macros)
  (:export :cleanup-raw-crates
           :solve-part-1
           :solve-part-2))

(defpackage :advent2022.day06
  (:use :cl :advent2022.utils :arrow-macros)
  (:import-from :alexandria :curry)
  (:export :solve-part-1
           :solve-part-2))
