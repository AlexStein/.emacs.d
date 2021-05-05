(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(display-time-mode t)
 '(ede-project-directories (quote ("/home/stein/positive/ptaf/ptaf-services/")))
 '(git-gutter:added-sign "+")
 '(git-gutter:deleted-sign "-")
 '(git-gutter:modified-sign "~")
 '(package-selected-packages
   (quote
    (smartscan expand-region magit yasnippet yaml-mode tern-auto-complete sass-mode ruby-hash-syntax rinari projectile-rails org nlinum neotree json-mode ido-at-point highlight-parentheses highlight-current-line highlight git-gutter-fringe git-gutter+ flymake-yaml flymake-sass flymake-ruby flymake-haml flymake-coffee coffee-mode cl-generic ac-js2)))
 '(safe-local-variable-values (quote ((encoding . utf-8))))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
; )
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(load-theme 'railscasts t nil)

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq inhibit-startup-message t)

(tool-bar-mode -1)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

;; Подсветка пробелов в конце строк
(add-hook 'prog-mode-hook
      (lambda () (setq show-trailing-whitespace t)))
;; В вопросах только y или n
(fset 'yes-or-no-p 'y-or-n-p)

;; Подсветка курсора
;;(beacon-mode 1)

;; Подсветка слова
(smartscan-mode 1)

(add-to-list 'load-path "~/.emacs.d/inits/")
(add-to-list 'load-path "~/.emacs.d/mods/")

;;(require 'rg)
(global-set-key (kbd "M-s") 'ripgrep-regexp)

(require 'auto-install)
(require 'nlinum)
;; Preset width nlinum
(add-hook 'nlinum-mode-hook
          (lambda ()
            (setq nlinum--width
              (length (number-to-string
                       (count-lines (point-min) (point-max)))))))
(global-linum-mode t)

;; Показывать время
(display-time-mode 1)
(setq display-time-format "%H:%M:%S")

;;magit status
(global-set-key (kbd "C-x g") 'magit-status)

(require 'ido)
(ido-mode t)

;; Org-mode
(setq org-modules '(org-habit))

;; Keywords
(setq org-todo-keywords
  '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE" "THINKING")))

;; throw error on edits that affect invisible part of buffer
(setq org-catch-invisible-edits 'error)

;; add timestamp when closing task
(setq org-log-done 'time)

;; files
(setq org-agenda-files (list "~/Dropbox/TM/"))

;; configure capturing
(setq org-directory "~/Dropbox/TM")

;; calendar
(add-hook 'calendar-load-hook
          (lambda ()
            (calendar-set-date-style 'european)))
(setq calendar-week-start-day 1)
(setq calendar-day-name-array ["Вс" "Пн" "Вт" "Ср" "Чт" "Пт" "Сб"]
      calendar-month-name-array ["Январь" "Февраль" "Март" "Апрель" "Май"
                                 "Июнь" "Июль" "Август" "Сентябрь"
                                 "Октябрь" "Ноябрь" "Декабрь"])
;; org-mode keys
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; Web-mode
(require 'web-mode)

; с какими файлами ассоциировать web-mode
;;(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

; настройка отступов
(setq web-mode-markup-indent-offset 4)
(setq web-mode-css-indent-offset 4)
(setq web-mode-code-indent-offset 4)

; сниппеты и автозакрытие парных скобок
;;(setq web-mode-extra-snippets '(("erb" . (("name" . ("beg" . "end"))))
;;                                ))
;;(setq web-mode-extra-auto-pairs '(("erb" . (("open" "close")))
;;                                ))

; подсвечивать текущий элемент
(setq web-mode-enable-current-element-highlight t)
; и колонку
(setq web-mode-enable-current-column-highlight t)

(load "quail/cyrillic")
(quail-defrule "%" ?% "cyrillic-jcuken") ; 5
(quail-defrule "^" ?: "cyrillic-jcuken") ; 6
(quail-defrule "&" ?? "cyrillic-jcuken") ; 7
(quail-defrule "*" ?* "cyrillic-jcuken") ; 8
(quail-defrule "|" ?/ "cyrillic-jcuken")
(quail-defrule "/" ?. "cyrillic-jcuken")
(quail-defrule "?" ?, "cyrillic-jcuken")

(defun reverse-input-method (input-method)
  "Build the reverse mapping of single letters from INPUT-METHOD."
  (interactive
   (list (read-input-method-name "Use input method (default current): ")))
  (if (and input-method (symbolp input-method))
      (setq input-method (symbol-name input-method)))
  (let ((current current-input-method)
        (modifiers '(nil (control) (meta) (control meta))))
    (when input-method
      (activate-input-method input-method))
    (when (and current-input-method quail-keyboard-layout)
      (dolist (map (cdr (quail-map)))
        (let* ((to (car map))
               (from (quail-get-translation
                      (cadr map) (char-to-string to) 1)))
          (when (and (characterp from) (characterp to))
            (dolist (mod modifiers)
              (define-key local-function-key-map
                (vector (append mod (list from)))
                (vector (append mod (list to)))))))))
    (when input-method
      (activate-input-method current))))

(global-set-key (kbd "<mouse-4>")
 (lambda () (interactive) (scroll-down mouse-wheel-scroll-amount) (redisplay)))
(global-set-key (kbd "<mouse-5>")
 (lambda () (interactive) (scroll-up mouse-wheel-scroll-amount) (redisplay)))

;;(require 'nose)
;;(add-hook 'python-mode-hook (lambda () (nose-mode t)))
;;(setq nose-global-name "nosetests")
(add-hook 'python-mode-hook
          '(lambda () (define-key python-mode-map "\C-ct" 'nosetests-again)))

;; Emacs server
;;(require 'server)
;;(unless (server-running-p)
;;  (server-start))

(load "mods")

;; new mods
(require 'symbol-overlay)
(global-set-key (kbd "M-i") 'symbol-overlay-put)
(global-set-key (kbd "M-n") 'symbol-overlay-switch-forward)
(global-set-key (kbd "M-p") 'symbol-overlay-switch-backward)
(global-set-key (kbd "<f7>") 'symbol-overlay-mode)
(global-set-key (kbd "<f9>") 'symbol-overlay-remove-all)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
