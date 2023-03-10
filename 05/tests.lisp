(in-package :advent2022.day05.tests)

(test cleanup-raw-crates-test
  (is (equal
       (cleanup-raw-crates "[N] [G]     [Q]")
       '("N" "G" "" "Q")))

  (is (equal
       (cleanup-raw-crates "[N] [G]                     [Q]")
       '("N" "G" "" "" "" "" "" "Q")))

  (is (equal
       (cleanup-raw-crates "[F] [Q]     [W] [T] [V] [J] [V] [M]")
       '("F" "Q" "" "W" "T" "V" "J" "V" "M"))))

(test integration-test
  (is (equal
       (solve-part-1)
       "GRTSWNJHH"))
  (is (equal
       (solve-part-2)
       "QLFQDBBHM")))
