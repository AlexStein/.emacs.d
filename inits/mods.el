;; Требуют установки

;; Подсветка 80й колонки
;(require 'column-marker)
;(set-face-background 'column-marker-1 "#333300")
;(column-marker-1 80)
(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))
;; Везде
(global-whitespace-mode t)

;; Если для конкретного режима
;(add-hook 'prog-mode-hook 'whitespace-mode)


; init-yasnippet.el
(require 'yasnippet)
(yas-global-mode 1)

; где лежат сниппеты
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets" ))

(provide 'init-yasnippet)

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

;; Дерево проекта по F8
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; git-gutter
(global-git-gutter-mode +1)
(git-gutter:linum-setup)
(custom-set-variables
 '(git-gutter:modified-sign "~")
 '(git-gutter:added-sign    "+")
 '(git-gutter:deleted-sign  "-"))

(set-face-foreground 'git-gutter:modified "purple")
(set-face-foreground 'git-gutter:added    "green")
(set-face-foreground 'git-gutter:deleted  "red")

;; Подсветка
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

(require 'highlight-current-line)
(highlight-current-line-on t)

;; Цвет
(set-face-background 'highlight-current-line-face "#333300")

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

