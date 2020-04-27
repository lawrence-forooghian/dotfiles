; https://github.com/syl20bnr/spacemacs/issues/12535#issue-469259962
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(package-initialize)

(require 'use-package)

; --- BEGIN emacs ---

; Hide menu bar
(menu-bar-mode -1)

; soft wrap - http://ergoemacs.org/emacs/emacs_long_line_wrap.html
(global-visual-line-mode 1)

; https://www.gnu.org/software/emacs/manual/html_node/emacs/Display-Custom.html
(setq-default display-line-numbers 'relative)

; https://stackoverflow.com/a/151946
(setq backup-directory-alist `(("." . "~/.emacs_backups")))

; https://emacs.stackexchange.com/a/17214
; note that this directory must already exist, or emacs complains
(setq auto-save-file-name-transforms `((".*" "~/.emacs_autosaves/" t)))

; --- END emacs ---

; --- BEGIN evil ---

(use-package evil
  :ensure t
  :init
  ; https://stackoverflow.com/questions/14302171/ctrlu-in-emacs-when-using-evil-key-bindings
  (setq evil-want-C-u-scroll t)
  ; https://stackoverflow.com/questions/22878668/emacs-org-mode-evil-mode-tab-key-not-working
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  ; Trying to undo emacs-evil-state which puts evil into emacs
  ; mode. The first one didn't work, but I learned about ~kbd~ which
  ; is how you enter keyboard commands.
  ; The second solution came from
  ; https://github.com/syl20bnr/spacemacs/issues/7372 - seems like
  ; keys can be defined in different maps, e.g. global, or this
  ; specific one evil-emacs-state-map.
  ;(global-unset-key (kbd "C-z"))
  (define-key evil-emacs-state-map (kbd "C-z") nil))

; --- END evil ---

; --- BEGIN evil-escape ---

(use-package evil-escape
  :ensure t
  :init
  (setq-default evil-escape-key-sequence "jk")
  :config
  (evil-escape-mode))

; --- END evil-escape

; --- BEGIN evil-surround ---

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

; --- END evil-surround ---

; --- BEGIN base16-theme ---

; https://github.com/belak/base16-emacs
(use-package base16-theme
  :ensure t
  :init
  (setq base16-theme-use-shell-colors t)
  (setq base16-theme-256-color-source "base16-shell")
  :config
  (load-theme 'base16-default-dark t))

; --- END base16-theme ---

; --- BEGIN org ---

; TODO what version of org do I have?

(use-package org
  :ensure t
  :init
  ; # https://orgmode.org/manual/HTML-doctypes.html#HTML-doctypes
  ; # https://emacs.stackexchange.com/questions/27691/org-mode-export-images-to-html-as-figures-not-img
  (setq org-html-doctype "html5")
  (setq org-html-html5-fancy t))

; https://stackoverflow.com/a/47850858
(defun org-export-output-file-name-modified (orig-fun extension &optional subtreep pub-dir)
    (unless pub-dir
          (setq pub-dir "export")
              (unless (file-directory-p pub-dir)
                      (make-directory pub-dir)))
      (apply orig-fun extension subtreep pub-dir nil))
(advice-add 'org-export-output-file-name :around #'org-export-output-file-name-modified)

; --- END org ---

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (base16-theme evil-surround evil-escape evil use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
