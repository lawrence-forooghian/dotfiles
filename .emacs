; https://github.com/syl20bnr/spacemacs/issues/12535#issue-469259962
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

; https://stackoverflow.com/questions/14302171/ctrlu-in-emacs-when-using-evil-key-bindings
(setq evil-want-C-u-scroll t)

; https://stackoverflow.com/questions/22878668/emacs-org-mode-evil-mode-tab-key-not-working
(setq evil-want-C-i-jump nil)

(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

; Hide menu bar
(menu-bar-mode -1)

(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(package-selected-packages
   (quote
    (ox-jira solarized-theme base16-theme evil-surround htmlize evil-escape key-chord ##))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

; https://github.com/syl20bnr/evil-escape
(setq-default evil-escape-key-sequence "jk")
(evil-escape-mode)

; soft wrap - http://ergoemacs.org/emacs/emacs_long_line_wrap.html
(global-visual-line-mode 1)

; https://www.gnu.org/software/emacs/manual/html_node/emacs/Display-Custom.html
(setq-default display-line-numbers 'relative) 

; https://emacsredux.com/blog/2013/04/02/highlight-current-line/
; (global-hl-line-mode +1)

					; https://emacs.stackexchange.com/questions/2664/syntax-highlighting-in-source-blocks
; TODO still not working, have to restart emacs to get org code blocks to syntax highlight
(setq org-src-fontify-natively t)

(require 'use-package)

; https://github.com/emacs-evil/evil-surround
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(setq base16-theme-use-shell-colors t)
(setq base16-theme-256-color-source "base16-shell")

; https://github.com/belak/base16-emacs
(use-package base16-theme
  :ensure t
  :config
  (load-theme 'base16-default-dark t))

; Trying to undo emacs-evil-state which puts evil into emacs mode. The first one didn't work, but I learned about ~kbd~ which is how you enter keyboard commands.
; The second solution came from https://github.com/syl20bnr/spacemacs/issues/7372 - seems like keys can be defined in different maps, e.g. global, or this specific one evil-emacs-state-map.
; (global-unset-key (kbd "C-z"))
(define-key evil-emacs-state-map (kbd "C-z") nil)

; copied from the test here: https://github.com/stig/ox-jira.el/blob/master/test/ox-jira-test.el
; not sure why needed
(require 'ox-jira)

; From https://mobileorg.github.io/documentation/
;; Set to the location of your Org files on your local system
(setq org-directory "~/org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/flagged.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")

(setq org-mobile-files '("~/org/to_mobile.org"))

; https://stackoverflow.com/a/47850858
(defun org-export-output-file-name-modified (orig-fun extension &optional subtreep pub-dir)
    (unless pub-dir
          (setq pub-dir "export")
              (unless (file-directory-p pub-dir)
                      (make-directory pub-dir)))
      (apply orig-fun extension subtreep pub-dir nil))
(advice-add 'org-export-output-file-name :around #'org-export-output-file-name-modified)

; https://stackoverflow.com/a/151946
(setq backup-directory-alist `(("." . "~/.emacs_backups")))

; https://emacs.stackexchange.com/a/17214
; note that this directory must already exist, or emacs complains
(setq auto-save-file-name-transforms `((".*" "~/.emacs_autosaves/" t)))
