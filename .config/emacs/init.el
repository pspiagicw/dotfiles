
(require 'package)
(setq visible-bell -1)
(setq ring-bell-function 'ignore)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("elpa" . "https://elpa.gnu.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")))
(setq default-frame-alist '((font . "JetBrains Mono 7")))
(require 'use-package)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq inhibit-startup-message t)
(setq use-package-always-ensure t)
(setq show-paren-style 'expression)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)
(setq  large-file-warning-threshold 1000000)

(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(use-package undo-tree
  :config
  (global-undo-tree-mode 1)
  )


(use-package dashboard
  :config
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  (setq dashboard-startup-banner '3)
  (setq dashboard-center-content t)
  (setq dashboard-show-shortcuts nil)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-navigator t)
  (setq dashboard-projects-switch-function 'counsel-projectile-switch-project-by-name)
  (dashboard-setup-startup-hook)
  )
(use-package doom-themes
  :config
  (load-theme 'doom-dracula t))
(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :init
  (setq doom-modeline-icon t)
  (setq doom-modeline-project-detection 'projectile)
  (setq doom-modeline-buffer-state-icon t)
  (setq doom-modeline-major-mode-color-icon t)
  (setq doom-modeline-buffer-modification-icon t)
  )
(use-package all-the-icons)
(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3)
  (setq which-key-popup-type 'minibuffer))








(use-package counsel
  :bind (
	 ("C-s" . swiper)
	 ("M-x" . counsel-M-x)
	 ("C-x b" . counsel-switch-buffer)
	 ("C-w" . backward-kill-word)
	 ("C-h" . delete-backward-char)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . counsel-minibuffer-history)
	 :map ivy-minibuffer-map
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-d" . ivy-switch-buffer-kill))
  ("C-j" . ivy-next-line)
  ("C-k" . ivy-previous-line)
  :config
  (counsel-mode 1)
  )
(use-package ivy-rich
  :config
  (ivy-rich-mode 1))

(use-package evil
  :init
  (setq evil-want-integration nil)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump t)
  (setq evil-want-C-w-delete t)
  (setq evil-want-C-u-delete t)
  (setq evil-want-minibuffer nil)
  :config
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (define-key evil-normal-state-map (kbd "M-l") 'evil-window-right)
  (define-key evil-normal-state-map (kbd "M-h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "M-j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "M-k") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "/") 'counsel-grep-or-swiper)
  (define-key evil-normal-state-map (kbd "?") 'counsel-grep-or-swiper)
  (define-key evil-insert-state-map (kbd "M-l") 'evil-window-right)
  (define-key evil-insert-state-map (kbd "M-h") 'evil-window-left)
  (define-key evil-insert-state-map (kbd "M-j") 'evil-window-down)
  (define-key evil-insert-state-map (kbd "M-k") 'evil-window-up)
  ;; (define-key evil-normal-sate-map (kbd ":") 'counsel-M-x)

  ;; this set's up the messages-buffer-mode to normal
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  ;; This set's up the initial mode for evil in Emacs's startup
  (evil-set-initial-state 'dashboard-mode 'normal)
  (evil-mode 1))


(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-surround
  :config
  (global-evil-surround-mode t))
(use-package evil-commentary
  :config
  (evil-commentary-mode 1))
(use-package evil-escape
  :init
  (setq-default evil-escape-key-sequence "jk")
  :config
  (evil-escape-mode 1))

(use-package evil-terminal-cursor-changer
  :init
  (unless (display-graphic-p)
    (evil-terminal-cursor-changer-activate))
  )

(use-package evil-matchit
  :config
  (global-evil-matchit-mode 1))

(use-package evil-numbers
  :config
  (define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "C-x") 'evil-numbers/dec-at-pt)
  )
(use-package evil-goggles
  :config
  (evil-goggles-mode)
  )




(use-package toml-mode)
(use-package haskell-mode)
(use-package yaml-mode)
(use-package markdown-mode)





(use-package general
  :config
  (general-evil-setup t)
  )

(use-package projectile
  :config
  :custom
  (projectile-completion-system 'ivy)
  (setq projectile-project-search-path '("~/code/python/projects/" "~/code/c/projects/"))
  (setq projectile-switch-project-action #'projectile-dired)
  (projectile-mode 1))

(use-package counsel-projectile
  :config
  (counsel-projectile-mode 1))
(defun kill-dired-buffers ()
  (interactive)
  (mapc (lambda (buffer) 
	  (when (eq 'dired-mode (buffer-local-value 'major-mode buffer)) 
	    (kill-buffer buffer))) 
	(buffer-list)))
(defun custom-switch-to-next-theme ()
  "Switch to next theme"
  (interactive)
  (let (
	(theme-name (nth theme-index (custom-available-themes)))
	)
    (message "Current Theme: %s" theme-name)
    (setq theme-index (+ theme-index 1))
    (if (> theme-index (length (custom-available-themes)))
	(setq theme-index 0))
    (load-theme theme-name t)

    ))
(defun custom-switch-to-dashboard ()
  "Switch to dashboard"
  (interactive)
  (switch-to-buffer (get-buffer "*dashboard*"))
  )
(defun custom-terminal ()
  "Open a terminal differently depending on whether on project or not"
  (interactive)
  (if (projectile-project-p)
      (projectile-run-term)
    (term "/bin/bash")))
(defun custom-grep ()
  "Determines if in project or not and calls required grep function"
  (interactive)
  (if (projectile-project-p)
      (counsel-projectile-grep)
    (counsel-grep)))
(defun custom-vsplit ()
  "Custom vpslit with focus going to split"
  (interactive)
  (evil-window-vsplit)
  (evil-window-right 1))
(defun custom-split ()
  "Custom vpslit with focus going to split"
  (interactive)
  (evil-window-split)
  (evil-window-down 1))

(defun custom-find-file ()
  "Determines if in project or not and calls required find-file function"
  (interactive)
  (if (projectile-project-p)
      (counsel-projectile-find-file)
    (counsel-find-file)))
(defun custom-switch-buffer ()
  "Determines if in project or not and calls required find-file function"
  (interactive)
  (if (projectile-project-p)
      (counsel-projectile-switch-to-buffer)
    (counsel-switch-buffer)))
(defun custom-dired ()
  "Calls dired depending if in project or not"
  (interactive)
  (if (projectile-project-p)
      (projectile-find-dir)
    (dired (read-directory-name "Dired (directory):"))))


(general-define-key
 :states 'normal
 :keymaps 'override
 :prefix "SPC"
 "f" '(:ignore t :which-key "files")
 "b" '(:ignore t :which-key "buffers")
 "s" '(:ignore t :which-key "search")
 "j" '(:ignore t :which-key "jump")
 "h" '(:ignore t :which-key "help")
 "n" '(:ignore t :which-key "narrowing")
 "d" '(:ignore t :which-key "directory")
 "w" '(:ignore t :which-key "window")
 "p" '(:ignore t :which-key "project")
 "t" '(:ignore t :which-key "theme")
 "t" '(:ignore t :which-key "toggle")
 "g" '(:ignore t :which-key "git")
 "q" '(:ignore t :which-key "session/quit")
 ";" '(counsel-M-x :which-key "m-x")
 ">" '(evil-next-buffer :which-key "move to next buffer")
 "<" '(evil-next-buffer :which-key "move to previous buffer")
 "/" '(counsel-grep :which-key "grep in current buffer")
 "ff" '(custom-find-file :which-key "find file")
 "bb" '(custom-switch-buffer :which-key "switch buffer")
 "dd" '(custom-dired :which-key "open dired")
 "qq" '(delete-frame :which-key "close split/window")
 "ss" '(custom-grep :which-key "search for symbol")
 "tt" '(custom-terminal :which-key "open eshell")
 "wv" '(custom-vsplit :which-key "split vertically")
 "ws" '(custom-split :which-key "split horizonatally")
 "wc" '(evil-window-delete :which-key "delete split/window")
 "fs" '(save-buffer :which-key "save file")
 "fr" '(counsel-recentf :which-key "open recent files")
 "bd" '(evil-delete-buffer :which-key "delete the buffer")
 "wo" '(delete-other-windows :which-key "keep only this window")
 "hf" '(counsel-describe-function :which-key "describe function")
 "hv" '(counsel-describe-variable :which-key "describe function")
 "hc" '(describe-key :which-key "describe key")
 "hp" '(describe-package :which-key "describe package")
 "pp" '(counsel-projectile-switch-project :which-key "open project")
 "pt" '(projectile-test-project :which-key "test your project")
 "pc" '(projectile-compile-project :which-key "compile your project")
 "pf" '(counsel-projectile-find-file :which-key "open file in a project")
 "ps" '(counsel-projectile-grep :which-key "grep in your project")
 "pr" '(projectile-run-project :which-key "run your project")
 "nw" '(widen :which-key "widen")
 "nr" '(narrow-to-region :which-key "narrow to region")
 "nf" '(narrow-to-defun :which-key "narrow to function")
 "np" '(narrow-to-page :which-key "narrow to defun")
 "gg" '(magit-status :which-key "magit status")
 "jl" '(avy-goto-line :which-key "jump to line")
 "Ts" '(counsel-load-theme :which-key "change theme")
 "tn" '(display-line-numbers-mode :which-key "toggle lines numbers")
 "tk" '(which-key-mode :which-key "toggle which key mode")
 "ta" '(company-mode :which-key "toggle company mode")
 "hm" '(describe-mode :which-key "describe current major mode")
 "bh" '(custom-switch-to-dashboard :which-key "switch to dashboard")
 "bw" '(read-only-mode :which-key "toggle read only mode")
 "fs" '(save-buffer :which-key "save all buffers")
 "fS" '(save-some-buffers :which-key "save all buffers")
 "fR" '(rename-file :which-key "rename file")
 "bR" '(rename-buffer :which-key "rename buffer")
 "fC" '(copy-file :which-key "copy file")
 "fL" '(locate :which-key "locate file")
 "pk" '(projectile-kill-buffers :which-key "kill project buffers" )
 "p&" '(projectile-run-async-shell-command-in-root :which-key "run command async in root")
 "p!" '(projectile-run-command-in-root :which-key "run command in root")
 "w." '(hydra-window/body :which-key "window transient state")
 "wh" '(evil-window-left :which-key "move to left window")
 "wl" '(evil-window-right :which-key "move to right window")
 "wj" '(evil-window-down :which-key "move to below window")
 "wk" '(evil-window-up :which-key "move to top window")
 "Tn" '(custom-switch-to-next-theme :which-key "switch to next theme")
 "tm" '(menu-bar-mode :which-key "toggle menu bar")
 "ti" '(highlight-indent-guides-mode :which-key "toggle indent highlight")
 "tf" '(auto-fill-mode :which-key "toggle auto-fill mode(automatic line breaking)")
 "tw" '(whitespace-mode :which-key "toggle whitespace mode")
 "jw" '(avy-goto-word :which-key "jump to word")
 "jc" '(avy-goto-char :which-key "jump to char")
 "w=" '(balance-windows :which-key "balance windows")
 "fj" '(dired-jump :which-key "dired jump to current buffer file")
 "tf" '(flycheck-mode :which-key "toggle flycheckmode")
 "pd" '(projectile-find-dir :which-key "open dired on project root")
 "pg" '(projectile-find-tags :which-key "find tags in project")
 "p%" '(projectile-replace-regexp :which-key "replace name in project")
 "p'" '(projectile-run-term :which-key "Run term in root of project")
 "hr" '(crux-find-user-init-file :which-key "Open User config file")
 "dk" '(kill-dired-buffers :which-key "Kill all dired buffers")
 "fU" '(crux-sudo-edit :which-key "Open current file as root")
 "fu" '(crux-reopen-as-root-mode :which-key "Open current file as root")
 "RET" '(counsel-bookmark :which-key "Open Bookmarks")
 "X" '(crux-create-scratch-buffer :which-key "Create Scratch Buffer")
 "^" '(evil-switch-to-windows-last-buffer :which-key "Switch to last buffer")
 "&" '(async-shell-command :which-key "Run a command aysnc")
 "!" '(shell-command :which-key "Run a command")
 "o" '(:ignore t :which-key "Open Applications")
 "bi" '(ibuffer :which-key "Open Ibuffer")
 "tl" '(hl-line-mode :which-key "Toggle line highlight")
 "oa" '(org-agenda :which-key "Org Agenda")
 "ot" '(custom-transmission :which-key "Open Transmission")
 "tF" '(text-scale-adjust :which-key "Adjust text scale")

 )

(use-package crux)

(general-define-key
 :keymaps 'emacs-lisp-mode-map
 :states '(normal visual)
 :prefix "SPC"
 "m" '(:ignore t :which-key "major-mode")
 "me" '(eval-last-sexp :which-key "evaluate last sexp")
 "m:" '(eval-expression :which-key "evaluate lisp func")
 "md" '(eval-defun :which-key "evaluate defun")
 "mb" '(eval-buffer :which-key "evaluate buffer")
 "mr" '(eval-region :which-key "evaluate region")
 "mj" '(counsel-imenu :which-key "Imenu Mode")
 )
(general-define-key
 :keymaps 'dired-mode-map
 "h" 'dired-up-directory
 "l" 'dired-find-file
 "." 'dired-hide-dotfiles-mode
 "V" 'dired-mark
 )
(general-define-key
 :keymaps 'org-mode-map
 :states 'normal
 :prefix "SPC"
 "m" '(:ignore t :which-key "major-mode")
 "mt" '(:ignore t :which-key "org-toggle")
 "me" '(org-export-dispatch :which-key "Org Export")
 "mth" '(org-toggle-heading :which-key "Org Toggle Heading")
 "mti" '(org-toggle-item :which-key "Org Toggle Item")
 "mtt" '(org-todo :which-key "Org toggle todo")
 "mtc" '(org-toggle-checkbox :which-key "Org toggle checkbox")
 "ms" '(org-schedule :which-key "Org Schedul")
 "mc" '(org-ctrl-c-ctrl-c :which-key "Org Ctrl C")
 "ma" '(org-agenda-file-to-front :which-key "Org Agenda Add")
 "mi" '(org-insert-structure-template :which-key "Org Insert Structure")
 "mT" '(org-babel-tangle :which-key "Org Babel Tangle")
 "ml" '(org-insert-link :which-key "Org Insert Link")
 )
(general-define-key
 :keymaps 'archive-mode-map
 :states 'normal
 "h" 'quit-window
 "l" 'archive-extract
 )
(general-define-key
 :keymaps 'python-mode-map
 :states '(normal visual)
 :prefix "SPC"
 "m" '(:ignore t :which-key "major-mode")
 "mp" '(run-python :which-key "Open Python REPL")
 "mr" '(python-shell-send-region :which-key "Send region to REPL")
 "mb" '(python-shell-send-buffer :which-key "Send buffer to REPL")
 "mf" '(python-shell-send-defun :which-key "Send function to REPL")
 "ms" '(python-shell-send-statement :which-key "Send statement to REPL")
 "mi" '(:ignore t :which-key "Insert things")
 "mic" '(python-skeleton-class :which-key "Insert class skeleton")
 "mif" '(python-skeleton-for :which-key "Insert for skeleton")
 "mii" '(python-skeleton-import :which-key "Insert for skeleton")
 "mid" '(python-skeleton-def :which-key "Insert def skeleton")
 "mit" '(python-skeleton-try :which-key "Insert try skeleton")
 "miw" '(python-skeleton-while :which-key "Insert while skeleton")
 "mj" '(counsel-imenu :which-key "Jump to definition")
 )
(general-define-key
 :states 'normal
 :keymaps 'dired-mode-map
 "h" 'dired-up-directory
 "l" 'dired-find-file
 "." 'dired-hide-dotfiles-mode
 "V" 'dired-mark
 )
(use-package openwith
  :config
  (setq openwith-associations
	(list
	 (list (openwith-make-extension-regexp
		'("mpg" "mpeg" "mp3" "mp4"
		  "avi" "wmv" "wav" "mov" "flv"
		  "ogm" "ogg" "mkv" "opus" "m4a"))
	       "mpv --force-window"
	       '(file))
	 (list (openwith-make-extension-regexp
		'("xbm" "pbm" "pgm" "ppm" "pnm"
		  "png" "gif" "bmp" "tif" "jpeg" "jpg"))
	       "feh"
	       '(file))
	 (list (openwith-make-extension-regexp
		'("doc" "xls" "ppt" "odt" "ods" "odg" "odp" "docx" "pptx" "xlsx"))
	       "libreoffice"
	       '(file))
	 (list (openwith-make-extension-regexp
		'("pdf" "djvu"))
	       "zathura"
	       '(file))
	 '("\\.lyx" "lyx" (file))
	 '("\\.chm" "kchmviewer" (file))
	 (list (openwith-make-extension-regexp
		'("png" "jpeg" "jpg"))
	       "feh"
	       '(file))
	 ))
  (openwith-mode t))


(use-package dired-hide-dotfiles
  :hook
  (dired-mode . dired-hide-dotfiles-mode))

(defun read-lines (filePath)
"Return list of lines at a file at filePath"
(with-temp-buffer
    (insert-file-contents filePath)
    (split-string (buffer-string) "\n" t)))
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "qutebrowser")
(defun custom-transmission ()
  "Custom function for opening transmissino"
  (interactive)
  (when (get-buffer "*transmission*")
      (kill-buffer "*transmission*")
    )
  (transmission))
(global-linum-mode -1)
(use-package evil-vimish-fold
  :config
  (global-evil-vimish-fold-mode 1))
(use-package magit)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python. t)))
(require 'org-tempo)

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :config
  (lsp-enable-which-key-integration t))

(use-package company
  :config
  (setq company-minimum-prefix-length 1
	company-idle-delay 0.0)
  )
(use-package lsp-ui
  :config
  (lsp-ui-mode 1))
(add-to-list 'org-structure-template-alist
      '("py" . "src python"))


 



(use-package lua-mode)
