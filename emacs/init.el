(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(evil-collection evil-visual-mark-mode hide-mode-line magit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Open magit in a full screen buffer
(setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)

;; I don’t know why this is needed, but it must be done before loading evil
(setq evil-want-keybinding nil)
(require 'evil)
(evil-mode 1)

(evil-collection-init 'magit)

(require 'hide-mode-line)
(add-hook 'magit-mode-hook #'hide-mode-line-mode)
