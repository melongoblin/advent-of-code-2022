(setq scores '((("A" "X") 4) ;; 1 + 3
               (("A" "Y") 8) ;; 2 + 6
               (("A" "Z") 3) ;; 3 + 0
               (("B" "X") 1) ;; 1 + 0
               (("B" "Y") 5) ;; 2 + 3
               (("B" "Z") 9) ;; 3 + 6
               (("C" "X") 7) ;; 1 + 6
               (("C" "Y") 2) ;; 2 + 0
               (("C" "Z") 6))) ;; 3 + 3

(setq moves '((("A" "X") "Z")
              (("A" "Y") "X")
              (("A" "Z") "Y")
              (("B" "X") "X")
              (("B" "Y") "Y")
              (("B" "Z") "Z")
              (("C" "X") "Y")
              (("C" "Y") "Z")
              (("C" "Z") "X")))

(defun solve-part1 ()
  (with-temp-buffer
    (insert-file-contents "input.txt")
    (goto-char (point-min))
    (let ((sum 0))
      (while (not (eobp))
        (let ((current-list (split-string (string-trim-right (thing-at-point 'line t)) " ")))
          (let ((current-number (or (cadr (assoc current-list scores)) 0)))
            (setq sum (+ sum current-number))
            (forward-line))))
      sum)))

(defun solve-part2 ()
  (with-temp-buffer
    (insert-file-contents "input.txt")
    (let ((sum 0))
      (while (not (eobp))
        (let
            ((current-list (split-string (string-trim-right (thing-at-point 'line t)) " ")))
          (let ((current-move (list (car current-list) (cadr (assoc current-list moves)))))
            (let ((current-number (cadr (assoc current-move scores))))
              (setq sum (+ sum current-number))
              (forward-line)))))
      sum)))

; (message "%s" (solve-part1))
(message "%s" (solve-part2))
