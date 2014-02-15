;;; Minimal emacs setup for Relevance pairhosts.

(require 'cl)

;; Must-have setup for Emacs to operate like a modern application.
(setq
 ;; Do not show a splash screen.
 inhibit-splash-screen t
 ;; Show incomplete commands while typing them.
 echo-keystrokes 0.1
 ;; Flash the screen on errors.
 visible-bell t
 column-number-mode t)

;; Show what text is selected.
(transient-mark-mode t)

;; Always show matching sets of parentheses.
(show-paren-mode t)

;; Allow us to type "y" or "n" instead of "yes" or "no".
(defalias 'yes-or-no-p 'y-or-n-p)

;; Have a modern fuzzy-finding interface.
(ido-mode t)

;; Revert clean files changed outside of Emacs.
(global-auto-revert-mode t)

;; Prevent in-place backup files.
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;; Make buffers with the same filename show their directory.
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Package management.

(load "package")
(package-initialize)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(defvar pair/packages '(autopair
			clojure-mode
			coffee-mode
			cider
			auto-complete
			ac-nrepl
			haml-mode
			magit
			markdown-mode
			marmalade
			org
			paredit
			ruby-mode
			sass-mode
			scss-mode
			yaml-mode))

(defun pair/packages-installed-p ()
  (loop for pkg in pair/packages
        when (not (package-installed-p pkg)) do (return nil)
        finally (return t)))

(unless (pair/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg pair/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

(require 'clojure-mode)
(require 'paredit)
(require 'cider)
(add-hook 'clojure-mode-hook (lambda () 
                               (paredit-mode t)
                               (cider-mode t)))

(add-hook 'cider-repl-mode-hook
          (lambda ()
            (cider-turn-on-eldoc-mode)
            (paredit-mode 1)))

(add-hook 'cider-mode-hook
          (lambda ()
            (cider-turn-on-eldoc-mode)
            (paredit-mode 1)))

(setq cider-popup-stacktraces nil)
(setq cider-popup-stacktraces-in-repl nil)
(add-to-list 'same-window-buffer-names "*cider*")

(require 'ac-nrepl)
(add-hook 'cider-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-mode))
(setq cider-repl-print-length 1000)
(setq nrepl-hide-special-buffers t)
(setq cider-repl-pop-to-buffer-on-connect nil)

(eval-after-load "cider"
  '(define-key cider-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc))
