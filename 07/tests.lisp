(in-package :advent2022.day07.tests)


(defparameter aoc-sample-data
  "$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
")


(test parsing-shell-log-test
  (let ((result (sut::parse-shell-session '("$ cd /"
                                            "$ ls"
                                            "100 file1"
                                            "200 file2"
                                            "dir dir1"
                                            "dir dir2"
                                            "$ cd dir1"
                                            "$ ls"
                                            "300 file11"
                                            "400 file22"
                                            "$ cd .."
                                            "$ cd dir2"
                                            "$ ls"
                                            "500 file21"
                                            "666 file22"))))
    (is (= 2166
           (sut::fs-node-size result)))
    (is (equal "file22"
               (->> result
                 (sut::find-nodes (lambda (node) (= 666 (sut::fs-node-size node))))
                 car
                 sut::fs-node-name)))))

(test aoc-sample-data-test
  (let ((result (->> aoc-sample-data
                  (cl-ppcre:split "\\n")
                  (sut::parse-shell-session))))
    (is (= 48381165
           (sut::fs-node-size result)))
    (is (= 95437
           (sut::sum-sizes-less-than-100k result)))))

(test integration-test
  (is (= 1644735 (sut::solve-part-1))))
