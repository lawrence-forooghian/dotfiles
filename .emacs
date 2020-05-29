;; https://github.com/syl20bnr/spacemacs/issues/12535#issue-469259962
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(package-initialize)

(require 'use-package)

;; --- BEGIN emacs ---

(setq inhibit-startup-screen t)

;; Hide menu bar
(menu-bar-mode -1)

;; soft wrap - http://ergoemacs.org/emacs/emacs_long_line_wrap.html
(global-visual-line-mode 1)

;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Display-Custom.html
(setq-default display-line-numbers 'visual)
(setq-default display-line-numbers-current-absolute nil)

;; https://stackoverflow.com/a/151946
(setq backup-directory-alist `(("." . "~/.emacs_backups")))

;; https://emacs.stackexchange.com/a/17214
;; note that this directory must already exist, or emacs complains
(setq auto-save-file-name-transforms `((".*" "~/.emacs_autosaves/" t)))

;; --- END emacs ---

;; --- BEGIN evil ---

(use-package evil
  :ensure t
  :init
  ;; https://stackoverflow.com/questions/14302171/ctrlu-in-emacs-when-using-evil-key-bindings
  (setq evil-want-C-u-scroll t)
  ;; https://stackoverflow.com/questions/22878668/emacs-org-mode-evil-mode-tab-key-not-working
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  ;; Trying to undo emacs-evil-state which puts evil into emacs
  ;; mode. The first one didn't work, but I learned about ~kbd~ which
  ;; is how you enter keyboard commands.
  ;; The second solution came from
  ;; https://github.com/syl20bnr/spacemacs/issues/7372 - seems like
  ;; keys can be defined in different maps, e.g. global, or this
  ;; specific one evil-emacs-state-map.
  ;;(global-unset-key (kbd "C-z"))
  (define-key evil-emacs-state-map (kbd "C-z") nil))

;; --- END evil ---

;; --- BEGIN evil-escape ---

(use-package evil-escape
  :ensure t
  :init
  (setq-default evil-escape-key-sequence "jk")
  :config
  (evil-escape-mode))

;; --- END evil-escape

;; --- BEGIN evil-surround ---

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

;; --- END evil-surround ---

;; --- BEGIN base16-theme ---

;; https://github.com/belak/base16-emacs
(use-package base16-theme
  :ensure t
  :init
  (setq base16-theme-use-shell-colors t)
  (setq base16-theme-256-color-source "base16-shell")
  :config
  (load-theme 'base16-default-dark t))

;; --- END base16-theme ---

;; --- BEGIN org ---

;; TODO what version of org do I have?

(use-package org
  :ensure t
  :init
  ;; https://orgmode.org/manual/HTML-doctypes.html#HTML-doctypes
  ;; https://emacs.stackexchange.com/questions/27691/org-mode-export-images-to-html-as-figures-not-img
  (setq org-html-doctype "html5")
  (setq org-html-html5-fancy t)
  ;; Turn on Org Indent Mode by default – indent instead of displaying multiple stars
  ;;(setq org-startup-indented t))
  )

;; --- END org ---

;; --- BEGIN htmlize ---

;; It asked me to install this when I tried to export an org file as
;; HTML
(use-package htmlize
  :ensure t)

;; --- END htmlize ---

;; --- BEGIN PlantUML ---

;; This has some compilation error, and when opening an Org file with
;; PlantUML content we get:
;; Org mode fontification error in #<buffer ncvo-code-review.org> at 134
;; (use-package plantuml-mode
;;   :ensure t)
;; (add-to-list
;;   'org-src-lang-modes '("plantuml" . plantuml))

;; active Org-babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '(;; other Babel languages
   (plantuml . t)
   (ruby . t)))

;; This assumes that we’re using Homebrew to install PlantUML
;; babel will invoke PlantUML using `java` so the Homebrew-installed
;; OpenJDK needs to be in PATH – TODO raise an issue to make it accept
;; a path to java executable
;; https://github.com/emacs-mirror/emacs/blob/master/lisp/org/ob-plantuml.el
(setq org-plantuml-jar-path
      "/usr/local/opt/plantuml/libexec/plantuml.jar")

;; --- END PlantUML ---

;; --- BEGIN file type major modes ---

(use-package dockerfile-mode
  :ensure t)
(use-package markdown-mode
  :ensure t)
(use-package yaml-mode
  :ensure t)

;; --- END file type major modes ---
;; --- BEGIN experimenting ---

(use-package helm
  :ensure t)
(require 'helm-config)

;; TODO this doesn't work
;;(evil-define-key 'normal evil-normal-state-map
;;  (kbd ",t") helm-find-files)

;; For GUI
(set-default-font "Menlo 17")

;; This gives us smart quotes in text mode. I noticed that when
;; editing Ruby source inside an Org file, it gives the "wrong"
;; quotes. And in code comments it gives code-y quotes.
(use-package typo
  :ensure t)
(typo-global-mode 1)
(add-hook 'text-mode-hook 'typo-mode)

(use-package magit
  :ensure t)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/brain.org" "Captured")
         "* TODO %?\n%i\nCaptured at: %a")))

(add-hook 'org-capture-mode-hook 'evil-insert-state)

(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg/")

; https://orgmode.org/manual/Activation.html#Activation
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

(global-set-key (kbd "C-c j") 'org-clock-goto)

;; I'm temporarily disabling these because I seem to not have a clock running often when I think I do
;;(global-set-key (kbd "C-c o") 'org-clock-out)
;;(global-set-key (kbd "C-c x") 'org-clock-in-last)

; https://emacs.stackexchange.com/questions/2999/how-to-maximize-my-emacs-frame-on-start-up
; Want GUI Emacs to start up maximised
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(use-package projectile
  :ensure t)
; http://tuhdo.github.io/helm-projectile.html
; see "All-in-one command: helm-projectile, C-c p h"
(projectile-global-mode)
; https://github.com/bbatsov/projectile
(projectile-mode +1)

(use-package helm-projectile
  :ensure t)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

(use-package projectile-rails
  :ensure t)
(projectile-rails-global-mode)
(define-key projectile-rails-mode-map (kbd "C-c r") 'projectile-rails-command-map)

(use-package evil-leader
  :ensure t)
(global-evil-leader-mode) ; TODO Note: You should enable global-evil-leader-mode before you enable evil-mode, otherwise evil-leader won’t be enabled in initial buffers (*scratch*, *Messages*, …).
(evil-leader/set-leader ",")
(evil-leader/set-key
  "t" 'helm-projectile
  "p" 'helm-projectile-switch-project)

; Code completion
(use-package company
  :ensure t)
(company-mode)

(setq org-todo-keywords
      '((sequence "TODO" "PENDING" "|" "DONE")))

(setq org-todo-keyword-faces
      '(("TODO" . org-warning) ("PENDING" . "yellow")))

;; (use-package smartparens
;;   :ensure t)
;; (require 'smartparens-config)

;; --- END experimenting ---

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(calendar-week-start-day 1)
 '(ns-right-alternate-modifier (quote none))
 '(org-adapt-indentation nil)
 '(org-agenda-files (quote ("~/org/brain.org")))
 '(org-refile-use-outline-path t)
 '(package-selected-packages
   (quote
    (php-mode smartparens company company-mode evil-leader projectile-rails projectile browse-at-remote magit aggressive-indent typo visual-fill-column helm markdown-mode dockerfile-mode anki-editor org-preview-html base16-theme evil-surround evil-escape evil use-package)))
 '(ring-bell-function (quote ignore))
 '(ruby-insert-encoding-magic-comment nil)
 '(tool-bar-mode nil)
 '(vc-follow-symlinks t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(outline-4 ((t (:foreground "coral1")))))
