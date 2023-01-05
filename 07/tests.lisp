(in-package :advent2022.day07.tests)

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
           (sut::fs-node-size result)))))
