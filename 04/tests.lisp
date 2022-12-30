(in-package :advent2022.day04.tests)

(test integration-test
  (is (=
       (solve-part-1)
       602))

  (is (=
       (solve-part-2)
       891)))
