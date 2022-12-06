(require 'seq)

(defun convert-char-score (char)
  (if (= char (upcase char))
      (- char 38)
    (- char 96)))

(defun shared-chars (left right)
  (let ((shared ()))
    (seq-doseq (char left)
      (if (seq-contains-p right char)
          (push char shared))
      (delete-dups shared))
    shared))

(defun solve-part1 ()
  (with-temp-buffer
    (insert-file-contents "input.txt")
    (goto-char (point-min))
    (let ((sum 0))
      (while (not (eobp))
        (let* ((line (string-trim-right (thing-at-point 'line t)))
               (middle (/ (length line) 2))
               (left (substring line 0 middle))
               (right (substring line middle))
               (shared (shared-chars left right)))
          (setq sum (+ sum (convert-char-score (car shared)))))
        (forward-line))
      sum)))

(defun solve-part2 ()
  (with-temp-buffer
    (insert-file-contents "input.txt")
    (goto-char (point-min))
    (let ((sum 0))
      (while (not (eobp))
        (let ((first-elf (string-trim-right (thing-at-point 'line t))))
          (forward-line)
          (let ((secnd-elf (string-trim-right (thing-at-point 'line t))))
            (forward-line)
            (let ((third-elf (string-trim-right (thing-at-point 'line t)))
                  (shared-first (delete-dups (shared-chars first-elf secnd-elf))))
              (dolist (char shared-first)
                (if (seq-contains-p third-elf char)
                    (setq sum (+ sum (convert-char-score char)))))
              (forward-line)))))
      sum)))
; (message "%d" (solve-part1))
(message "%d" (solve-part2))
