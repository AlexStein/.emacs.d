(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(display-time-mode t)
 '(ede-project-directories '("~/positive/ptaf/ptaf-services/"))
 '(package-selected-packages
   '(reverse-im smart-shift all-the-icons smartscan expand-region magit yasnippet yaml-mode tern-auto-complete sass-mode ruby-hash-syntax rinari projectile-rails org neotree json-mode ido-at-point highlight-parentheses highlight git-gutter+ flymake-yaml flymake-sass flymake-ruby flymake-haml flymake-coffee coffee-mode cl-generic ac-js2))
 '(safe-local-variable-values '((encoding . utf-8)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'railscasts t nil)

;; System-type definition
(defun system-is-linux()
    (string-equal system-type "gnu/linux"))
(defun system-is-windows()
    (string-equal system-type "windows-nt"))

;; Emacs > 27.1
(setq byte-complile-warnings '(not cl-functions))

;; F7 to edit init.el
(global-set-key [f7] (lambda () (interactive) (find-file user-init-file)))

;; Show full path to file in current buffer in frame title
(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
        '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

(tool-bar-mode -1)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq inhibit-startup-message t)
(setq column-number-mode t)
(setq use-dialog-box nil)
(setq redisplay-dont-pause t)
(setq ring-bell-function 'ignore)

;; Disable backup/autosave files
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq auto-save-list-file-name nil)

;; End of file newlines
(setq require-final-newline t)
(setq next-line-add-newlines nil)

;; Highlight search results
(setq search-highlight t)
(setq query-replace-highlight t)

;; Easy transition between buffers: M-arrow-keys
(if (equal nil (equal major-mode 'org-mode))
    (windmove-default-keybindings 'meta))

;; Delete trailing whitespaces, untabify when save buffer
(defun untabify-current-buffer()
    (if (not indent-tabs-mode)
        (untabify (point-min) (point-max)))
    nil)
(add-to-list 'write-file-functions 'untabify-current-buffer)
(add-to-list 'write-file-functions 'delete-trailing-whitespace)

;; Default projects folder
(when (system-is-linux)
  (setq default-directory "~/positive/ptaf"))
(when (system-is-windows)
  (setq default-directory "C:/work/_projects/loader10"))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(when (< emacs-major-version 27)
  (package-initialize))

;; ;; Bounds indicator
;; (require 'fill-column-indicator)
;; (setq fci-rule-column 100)
;; (setq fci-rule-width 1)
;; (setq fci-rule-color "darkred")

;; (add-hook 'python-mode-hook 'fci-mode)

;; Trailing spaces
(add-hook 'prog-mode-hook
      (lambda () (setq show-trailing-whitespace t)))

;; Only y or n in questions
(fset 'yes-or-no-p 'y-or-n-p)

(add-to-list 'load-path "~/.emacs.d/mods/")

(require 'rg)
(setq rg-ignore-case nil)
(global-set-key (kbd "M-s") 'ripgrep-regexp)

;; dumb jump
(require 'dumb-jump)
(when (system-is-linux)
  (setq dumb-jump-default-project "~/positive/ptaf"))
(when (system-is-windows)
  (setq dumb-jump-default-project "C:/work/_projects/loader10"))

(setq dumb-jump-prefer-searcher 'rg)
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)

;; smartscan
(setq smartscan-symbol-selector "symbol")
(add-hook 'python-mode-hook 'smartscan-mode)

;; highlight line with the cursor, preserving the colours.
(global-hl-line-mode 1)
(set-face-attribute 'hl-line nil :foreground nil :background "#333300")

(require 'auto-install)
(global-display-line-numbers-mode t)

;; show current time
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
  '((sequence "TODO" "IN-PROGRESS" "WAITING" "THINKING" "DONE")))

;; throw error on edits that affect invisible part of buffer
(setq org-catch-invisible-edits 'error)
(setq org-ellipsis "⤵")
;; add timestamp when closing task
(setq org-log-done 'time)

;; files
(when (system-is-linux)
  (setq org-agenda-files (list "~/Dropbox/TM/"))
  (setq org-directory "~/Dropbox/TM"))
(when (system-is-windows)
  (setq org-agenda-files (list "C:/Dropbox/TM/"))
  (setq org-directory "C:/Dropbox/TM"))

;; calendar
(add-hook 'calendar-load-hook
          (lambda ()
            (calendar-set-date-style 'european)))
(setq calendar-week-start-day 1)
(setq calendar-day-name-array ["Вс" "Пн" "Вт" "Ср" "Чт" "Пт" "Сб"]
      calendar-month-name-array ["Январь" "Февраль" "Март" "Апрель" "Май"
                                 "Июнь" "Июль" "Август" "Сентябрь"
                                 "Октябрь" "Ноябрь" "Декабрь"])
;; Org-mode keys
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; Web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

;; Web-mode settings
(setq web-mode-markup-indent-offset 4)
(setq web-mode-css-indent-offset 4)
(setq web-mode-code-indent-offset 4)
(setq web-mode-enable-current-element-highlight t)
(setq web-mode-enable-current-column-highlight t)

;; reverse-im
(reverse-im-mode t)
(reverse-im-activate "russian-computer")

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

(require 'whitespace)
(setq whitespace-line-column 100) ;; limit line length
(setq whitespace-style '(face lines-tail))
(global-whitespace-mode t)

;; JS
(require 'json-mode)
(require 'js2-mode)
(require 'ac-js2)
(require 'coffee-mode)

(require 'tern)
(require 'tern-auto-complete)

(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))

;; Ruby
(require 'ruby-mode)
(require 'ruby-hash-syntax)
(add-to-list 'auto-mode-alist
               '("\\.\\(?:gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
               '("\\(Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))

(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)
(setq ruby-deep-indent-paren nil)

;; Projectile
(projectile-global-mode)
(add-hook 'projectile-mode-hook 'projectile-rails-on)
(setq projectile-rails-add-keywords nil)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
(add-hook 'yaml-mode-hook '(lambda () (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-smart-open t)

;; git-gutter
(global-git-gutter+-mode t)
(setq git-gutter+-modified-sign "~")
(setq git-gutter+-added-sign "+")
(setq git-gutter+-deleted-sign "-")

(global-set-key (kbd "C-x C-g") 'git-gutter)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)

;; Jump to next/previous hunk
(global-set-key (kbd "C-x p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-x n") 'git-gutter:next-hunk)

;; Stage current hunk
(global-set-key (kbd "C-x v s") 'git-gutter:stage-hunk)

;; Revert current hunk
(global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)

(set-face-foreground 'git-gutter+-modified "purple")
(set-face-foreground 'git-gutter+-added    "green")
(set-face-foreground 'git-gutter+-deleted  "red")

;; Highlight parentheses
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;; Show-paren-mode settings
(show-paren-mode t)
(setq show-paren-style 'expression)
(setq show-paren-delay 2)

(require 'paren)
(set-face-background 'show-paren-match "#334466")

;; Electric-modes settings
(electric-pair-mode 1)

;; Delete selection
(delete-selection-mode t)

;; Markdown
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(require 'symbol-overlay)
(global-set-key (kbd "M-i") 'symbol-overlay-put)
(global-set-key (kbd "M-n") 'symbol-overlay-switch-forward)
(global-set-key (kbd "M-p") 'symbol-overlay-switch-backward)
(global-set-key [f9] 'symbol-overlay-remove-all)
(global-set-key [f10] 'symbol-overlay-mode)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; Snippets
(require 'yasnippet)
(yas-global-mode 1)
(setq yas-snippet-dirs '("~/.emacs.d/snippets" ))
(provide 'init-yasnippet)

;; Bookmark settings
(require 'bookmark)
(setq bookmark-save-flag t)
(when (file-exists-p (concat user-emacs-directory "bookmarks"))
    (bookmark-load bookmark-default-file t))
(global-set-key (kbd "<f3>") 'bookmark-set)
(global-set-key (kbd "<f4>") 'bookmark-jump)
(global-set-key (kbd "<f5>") 'bookmark-bmenu-list)
(setq bookmark-default-file (concat user-emacs-directory "bookmarks"))

;; Emacs server
(when (system-is-linux)
  (require 'server)
  (unless (server-running-p)
    (server-start)))
