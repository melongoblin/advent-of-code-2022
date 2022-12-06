
(defun solve-part1 ()
  (with-temp-buffer
    (insert-file-contents "input.txt")
    (goto-char (point-min))
    (let ((total-puzzles 0))
      (while (not (eobp))
        (print (string-trim-right (thing-at-point 'line t)))
        (forward-line)))))

(solve-part1)
