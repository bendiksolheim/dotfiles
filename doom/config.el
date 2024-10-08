;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Bendik Solheim"
      user-mail-address "hello@bendik.dev")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
(setq doom-font (font-spec :family "Iosevka" :size 14 :weight 'normal)
      doom-serif-font (font-spec :family "Iosevka" :size 14 :weight 'normal)
      doom-big-font (font-spec :family "Iosevka" :size 16 :weight 'bold))

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-nano-dark)
(setq doom-theme 'doom-nano-dark)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Disable LSP formatting for typescript
(setq-hook! 'typescript-tsx-mode-hook +format-with-lsp nil)
(setq-hook! 'typescript-tsx-mode-hook +format-with :none)
(setq-hook! 'typescript-mode-hook +format-with-lsp nil)
(setq-hook! 'typescript-mode-hook +format-with :none)
(setq-hook! 'javascript-mode-hook +format-with-lsp nil)
(setq-hook! 'javascript-mode-hook +format-with :none)
(setq +format-with-lsp nil)

(add-hook 'typescript-tsx-mode-hook 'prettier-js-mode)
(add-hook 'typescript-mode-hook 'prettier-js-mode)

;; Disable formatting for ruby completely as it requires an external tool
(setq-hook! 'ruby-mode-hook +format-with :none)

;; Key bindings
(map! :nveomr "'" #'evil-window-map)
(map! :n "s-k" #'evil-jump-backward)
(map! :n "s-j" #'evil-jump-forward)
(map! :leader :prefix "w" "'" #'other-window)
(map! :leader :prefix "w" "-" #'evil-window-split)
(map! :leader :prefix "w" "/" #'evil-window-vsplit)
(map! :leader :prefix ("$" . "AI")
      (:desc "Refactor" "r" #'org-ai-refactor-code
       :desc "Billing" "$" #'org-ai-open-account-usage-page
       :desc "Query ChatGPT" "q" #'org-ai-prompt
       :desc "Debug" "d" #'org-ai-open-request-buffer))
(map! :leader :n "h h" #'helpful-at-point)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Iterate through CamelCaseWords
(global-subword-mode 1)

(after! doom-modeline
  (setq doom-modeline-persp-name t
        doom-modeline-persp-icon nil
        doom-modeline-bar-width 4
        doom-modeline-major-mode-icon t
        doom-modeline-major-mode-color-icon t
        doom-modeline-buffer-file-name-style 'truncate-upto-root))


(add-to-list 'auto-mode-alist '("\\.d2\\'" . d2-mode))
