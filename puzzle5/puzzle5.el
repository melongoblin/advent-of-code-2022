;;; puzzle5.el --- Description -*- lexical-binding: t; -*-
(require 'subr-x)

(defun set-nth (list n value)
  (let ((output (copy-tree list)))
    (setcar (nthcdr (- n 1) output) value)
    output))

(defun debug-print (thing)
 (with-current-buffer "*scratch*"
   (insert (format "%s\n" thing))))

(defun solve-puzzle (&optional part-two)
  (with-temp-buffer
    (insert-file-contents "input.txt")
    (goto-char (point-min))
    (let ((collected-lines ()))
      (while (not (looking-at-p "[[:blank:]]*$"))
        (let ((current-line (thing-at-point 'line)))
          (push current-line collected-lines))
        (forward-line))
      (let ((max-line-length 0))
        (dolist (line collected-lines)
          (if (> (length line) max-line-length)
              (setq max-line-length (length line))))
        (let ((state '()))
          ;(debug-print collected-lines)
          (dotimes (place (/ max-line-length 4))
            (let ((current-input ()))
              (dolist (line (reverse collected-lines))
                (setq line (string-pad line max-line-length))
                (let* ((parsed (substring line (* place 4) (- (* (+ place 1) 4) 1)))
                       (cleand (string-trim-right (replace-regexp-in-string "[\]]*[\[]*" "" parsed))))
                  (if (not (string-match-p "[[:digit:]]" cleand))
                      (if (not (string-empty-p cleand))
                          (push cleand current-input)))))
              (push current-input state)))
          (setq state (reverse state))
          ;(debug-print state)
          (let ((moves ()))
            (forward-line)
            (while (not (eobp))
              (let* ((line (split-string (thing-at-point 'line) " "))
                     (move (mapcar 'string-to-number (list (nth 1 line) (nth 3 line) (nth 5 line)))))
                ;(debug-print line)
                ;(debug-print move)
                (push move moves))
              (forward-line))
            (dolist (move (reverse moves))
              (let ((number-crates (car move))
                    (from (nth 1 move))
                    (to (nth 2 move)))
                (let* ((from-state (nth (- from 1) state))
                       (to-state (nth (- to 1) state)))
                  (let ((elements (butlast (reverse from-state)
                                           (- (length from-state) number-crates))))
                    (let ((new-to (if part-two
                                      (append to-state (reverse elements))
                                    (append to-state elements)))
                          (new-from (butlast from-state number-crates)))
                      (setq state (set-nth (set-nth state from new-from) to new-to))))))))
          (let ((answer ()))
            (dolist (stack state)
              (push (car (last stack)) answer))
            (string-join (reverse answer))))))))


(message "%s" (solve-puzzle 1))
