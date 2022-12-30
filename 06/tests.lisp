(in-package :advent2022.day06.tests)

(test window-with-index-test
  (is (equal
       (window-with-index 3 '(1 2 3 4 5 6 7 8 9 10))
       '((2 (1 2 3)) (3 (2 3 4)) (4 (3 4 5)) (5 (4 5 6)) (6 (5 6 7)) (7 (6 7 8)) (8 (7 8 9)) (9 (8 9 10))))))

(test find-sop-marker-test
  (is (= 5
         (find-sop-marker "bvwbjplbgvbhsrlpgdmjqwftvncz")))
  (is (= 6
         (find-sop-marker "nppdvjthqldpwncqszvftbrmjlhg")))
  (is (= 10
         (find-sop-marker "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")))
  (is (= 11
         (find-sop-marker "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"))))

(test find-som-marker-test
  (is (= 19
         (find-som-marker "mjqjpqmgbljsphdztnvjfqwrcgsmlb")))
  (is (= 23
         (find-som-marker "bvwbjplbgvbhsrlpgdmjqwftvncz")))
  (is (= 23
         (find-som-marker "nppdvjthqldpwncqszvftbrmjlhg")))
  (is (= 29
         (find-som-marker "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")))
  (is (= 26
         (find-som-marker "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"))))

(test day06-integration-test
  (is (= 1175 (solve-part-1)))
  (is (= 3217 (solve-part-2))))
