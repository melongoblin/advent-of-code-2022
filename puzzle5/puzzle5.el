;;; puzzle5.el --- Description -*- lexical-binding: t; -*-

(defun solve-part1 ()
  (with-temp-buffer
    (insert-file-contents "input.txt")
    (goto-char (point-min))
    (let ((collected-lines ()))
      (while (not (looking-at-p "[[:blank:]]*$")) ; our first separator is a blank line between the initial state and the moves
        (let ((current-line (thing-at-point 'line t)))
          (push current-line collected-lines))
        (forward-line))
      (let ((line-length 0))
        (setq collected-lines collected-lines)
        (dolist (line collected-lines)
          (if (> (length line) line-length)
              (setq line-length (length line)))) ; find our longest length line
        (let ((puzzle-input '()))
          (dotimes (place (/ line-length 4))
            (let ((current-input ()))
              (dolist (line collected-lines)
                (let* ((parsed-section (substring line (* place 4) (- (* (+ place 1) 4) 1))) ; parses out susbtrings in the form of "[X] "
                       (clean-section (string-trim-right (replace-regexp-in-string "[\[]*[\]]*" "" parsed-section)))) ; removes brackets and blank lines leaving "X"
                  (if (not (string-match-p "[[:digit:]]" clean-section)) ; remove any digits, we don't need the stack numbers
                      (if (not (string-empty-p clean-section))
                          (push clean-section current-input)))))
              (push (reverse current-input) puzzle-input)))
          (setq puzzle-input (reverse puzzle-input))
          (let ((moves ()))
            (forward-line) ;; skip blank line
            (while (not (eobp)) ; parse the rest of the input files
              (let ((line (split-string (thing-at-point 'line t) " "))) ; split the moves line into ("move" x "from" x "to" x)
                (push (mapcar 'string-to-number (list (nth 1 line) (nth 3 line) (nth 5 line))) moves)) ; select all digits from previous split
              (forward-line))
            (dolist (move moves)
              (let ((num-crates (car move))
                    (from (nth 1 move))
                    (to (nth 2 move)))
                (let ((from-list (nth (- from 1) puzzle-input))
                      (to-list (nth (- to 1) puzzle-input)))
                  (let ((element (pop from-list)))
                    (append element to-list))))))
          (let ((final-answer '()))
            (dolist (stack puzzle-input)
              (setq final-answer (append final-answer (list (car (reverse stack))))))
            final-answer))))))

(message "%s" (solve-part1))
