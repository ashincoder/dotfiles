
;; Get file icons in dired
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

;; Theme
(setq doom-theme 'doom-one)

;; Modeline
(setq doom-modeline-height 30     ;; sets modeline height
      doom-modeline-bar-width 5   ;; sets right bar width
      doom-modeline-persp-name t  ;; adds perspective name to modeline
      doom-modeline-persp-icon t) ;; adds folder icon next to persp name

;; Font
(setq doom-font (font-spec :family "JetBrains Mono Nerd Font" :size 15)
      doom-variable-pitch-font (font-spec :family "Noto Sans" :size 15)
      doom-big-font (font-spec :family "JetBrains Mono Nerd Font" :size 24))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq display-line-numbers-type t)

;; Org
(map! :leader
      :desc "Org babel tangle" "m B" #'org-babel-tangle)
(after! org
  (setq org-directory "~/Org/"
        org-agenda-files '("~/Org/agendas/")
        org-notes-files '("~/Org/notes/")
        org-ellipsis " ▼ "
        org-superstar-headline-bullets-list '("◉" "●" "○" "◆" "●" "○" "◆")
        org-superstar-item-bullet-alist '((?+ . ?➤) (?- . ?✦)) ; changes +/- symbols in item lists
        org-log-done 'time
        org-hide-emphasis-markers t
        org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
          '((sequence
             "TODO(t)"
             "PROJ(p)"
             "STUDY(s)"
             "ASSIGNMENT(h)"
             "|"
             "WAIT(w)"
             "CANCELLLED(c)"
             "DONE(d)" )))
  ;; Org journal
  (setq org-journal-dir "~/Org/journal/"
        org-journal-date-prefix "* "
        org-journal-time-prefix "** "
        org-journal-date-format "%B %d, %Y (%A) "
        org-journal-file-format "%Y-%m-%d.org"))

;; Disable invasive lsp-mode features
(setq lsp-ui-sideline-enable nil   ; not anymore useful than flycheck
      lsp-ui-doc-enable nil        ; slow and redundant with K
      lsp-enable-symbol-highlighting nil
      ;; If an LSP server isn't present when I start a prog-mode buffer, you
      ;; don't need to tell me. I know. On some systems I don't care to have a
      ;; whole development environment for some ecosystems.
      +lsp-prompt-to-install-server 'quiet)
