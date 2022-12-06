
(defun solve-part1 ()
  (with-temp-buffer
    (insert-file-contents "input.txt")
    (goto-char (point-min))
    (let ((total-contained-sections 0))
      (while (not (eobp))
        (let* ((line (string-trim-right (thing-at-point 'line t)))
               (parts (split-string line ",")))
          (let ((left (mapcar 'string-to-number (split-string (car parts) "-")))
                (right (mapcar 'string-to-number (split-string (cadr parts) "-"))))
            (if (or (<= (car left) (car right) (cadr right) (cadr left))
                    (<= (car right) (car left) (cadr left) (cadr right)))
                (setq total-contained-sections (1+ total-contained-sections)))))
        (forward-line))
      total-contained-sections)))

(defun solve-part2 ()
  (with-temp-buffer
    (insert-file-contents "input.txt")
    (goto-char (point-min))
    (let ((total-overlaps 0))
      (while (not (eobp))
        (let* ((line (string-trim-right (thing-at-point 'line t)))
               (parts (split-string line ",")))
          (let ((left (mapcar 'string-to-number (split-string (car parts) "-")))
                (right (mapcar 'string-to-number (split-string (cadr parts) "-"))))
            (if (and (<= (car left) (cadr right))
                     (<= (car right) (cadr left)))
                (setq total-overlaps (1+ total-overlaps)))))
        (forward-line))
      total-overlaps)))

; (message "%s" (solve-part1))
(message "%s" (solve-part2))
