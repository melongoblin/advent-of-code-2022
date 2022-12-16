
(defun debug-print (thing)
  (with-current-buffer "*scratch*"
    (insert (format "%s\n" thing))))

(defun group-unique-p (collection)
  ; (debug-print collection)
  (or (null collection)
      (and (not (member (car collection) (cdr collection)))
           (group-unique-p (cdr collection)))))

(defun solve-puzzle (file &optional part-two)
  (with-temp-buffer
    (insert-file-contents file)
    (goto-char (point-min))
    (let ((collected-characters '())
          (found-point 0)
          (group-length (if part-two
                            14
                          4)))
      (while (not (eobp))
        (push (thing-at-point 'char) collected-characters)
        (if (= (length collected-characters) group-length)
            (if (group-unique-p collected-characters)
                (setq found-point (point))
              (setq collected-characters (butlast collected-characters 1))))
        (forward-char)
        (debug-print collected-characters))
      found-point)))

(message "%d" (solve-puzzle "input.txt"))
