
(defun debug-print (thing)
  (with-current-buffer "*scratch*"
    (insert (format "%s\n" thing))))

(defun group-unique (collection)
  ; (debug-print collection)
  (or (null collection)
      (and (not (member (car collection) (cdr collection)))
           (group-unique (cdr collection)))))

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
            (if (group-unique collected-characters)
                (setq found-point (point))
              (setq collected-characters (reverse (cdr (reverse collected-characters))))))
        (forward-char))
      found-point)))

(message "%d" (solve-puzzle "input.txt" t))
