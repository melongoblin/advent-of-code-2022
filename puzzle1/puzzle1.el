(defun solve-puzzle (file &optional part-two)
  (with-temp-buffer
    (insert-file-contents file)
    (goto-char (point-min))
    (let ((max 0)
          (collected-sums ()))
      (while (not (eobp))
        (let ((sum 0))
          (while (not (looking-at-p "[[:blank:]]*$"))
            (setq sum (+ sum (number-at-point)))
            (forward-line))
          (add-to-list 'collected-sums sum)
          (if (> sum max)
              (setq max sum))
          (forward-line)))
      (setq collected-sums (sort collected-sums '>))
      (if part-two
          (apply '+ (butlast collected-sums (- (length collected-sums) 3)))
        max))))

;;(message "%d" (solve-puzzle "input.txt")) ;part 1
(message "%d" (solve-puzzle "input.txt" t))
