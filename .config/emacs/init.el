(setq make-backup-files nil)
(setq auto-save-default nil)

(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(setq visible-bell -1)
(setq ring-bell-function 'ignore)
(defalias 'y-or-n-p 'yes-or-no-p)

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("elpa" . "https://elpa.gnu.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")))

(require 'use-package)

(use-package use-package
  :config
  (setq use-package-always-ensure t)
)

(use-package emacs
  :ensure nil
  :config
    (scroll-bar-mode -1)
    (tool-bar-mode -1)
    (menu-bar-mode -1)
    (tooltip-mode -1)
    (setq tooltip-use-echo-area t)
    (setq inhibit-startup-message t)
 )

(setq default-frame-alist '((font . "JetBrains Mono 7")))

(use-package all-the-icons)

(use-package doom-themes)
(use-package modus-themes)
(use-package dracula-theme)

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :init
  (setq doom-modeline-icon t)
  (setq doom-modeline-project-detection 'projectile)
  (setq doom-modeline-buffer-state-icon t)
  (setq doom-modeline-major-mode-color-icon t)
  (setq doom-modeline-buffer-modification-icon t)
  )

(use-package dashboard
  :config
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-center-content t)
  (setq dashboard-show-shortcuts nil)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-navigator t)
  (setq dashboard-projects-switch-function 'counsel-projectile-switch-project-by-name)
  (dashboard-setup-startup-hook)
  )

(use-package which-key
  :init (which-key-mode)
  :config
  (setq which-key-idle-delay 0.3)
  (setq which-key-popup-type 'minibuffer)
)

(setq display-buffer-alist
      `(;; no window
	("\\`\\*Async Shell Command\\*\\'"
	 (display-buffer-in-side-window)
	 (window-height . 0.16)
	 (side . bottom))
	("\\*\\(Flymake\\|Package-Lint\\|\\.*compilation.*\\|\\.*terminal.*\\).*"
	 (display-buffer-in-side-window)
	 (window-height . 0.16)
	 (side . bottom)
	 (slot . 0))
	("\\*\\(.*compilation.*\\).*"
	 (display-buffer-in-side-window)
	 (window-height . 0.25)
	 (side . bottom)
	 (slot . 0))
	("\\*Messages.*"
	 (display-buffer-in-side-window)
	 (window-height . 0.16)
	 (side . bottom)
	 (slot . 1))
	("\\*\\(Backtrace\\|Warnings\\|Compile-Log\\)\\*"
	 (display-buffer-in-side-window)
	 (window-height . 0.16)
	 (side . bottom)
	 (slot . 2))
	("\\*\\(Embark\\)?.*Completions.*"
	 (display-buffer-in-side-window)
	 (side . bottom)
	 (slot . 0)
	 (window-parameters . ((no-other-window . t)
			       (mode-line-format . none))))
	("\\*Help.*"            ; See the hooks for `visual-line-mode'
	 (display-buffer-in-side-window)
	 (window-width . 0.25)
	 (side . right)
	 (slot . -1))
	("\\*Faces\\*"
	 (display-buffer-in-side-window)
	 (window-width . 0.25)
	 (side . right)
	 (slot . 0))
	("\\*Occur\\*"
	 (display-buffer-in-side-window)
	 (window-width . 0.25)
	 (side . right)
	 (slot . 0))
	("*\\.*mpc.*\\*"
	 (display-buffer-in-side-window)
	 (window-width . 0.25)
	 (side . right)
	 (slot . 0))
	("\\.*eww.*\\*"
	 (display-buffer-in-side-window)
	 (window-width . 0.25)
	 (side . right)
	 (slot . 0))
	("*\\.*terminal.*\\*"
	 (display-buffer-in-side-window)
	 (window-width . 0.25)
	 (side . right)
	 (slot . 0))
	("\\.*reddigg.*\\*"
	 (display-buffer-in-side-window)
	 (window-width . 0.25)
	 (side . right)
	 (slot . 0))
	("\\*\\(Output\\|Register Preview\\).*"
	 (display-buffer-at-bottom))
	("\\*\\vc-\\(incoming\\|outgoing\\|git : \\).*"
	 (display-buffer-reuse-mode-window display-buffer-at-bottom)
	 (window-height . 0.2))
	("\\*.*\\(e?shell\\|v?term\\).*"
	 (display-buffer-reuse-mode-window display-buffer-at-bottom)
	 (window-height . 0.2))
	;;  )
	)

      )

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
  (evil-set-initial-state 'simple-mpc-mode 'emacs)
  (evil-set-initial-state 'simple-mpc-query-mode 'emacs)
  (evil-set-initial-state 'simple-mpc-current-playlist-mode 'emacs)
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
  (evil-mode 1)
)

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init)
)

(use-package evil-surround
  :config
  (global-evil-surround-mode t)
)

(use-package evil-commentary
  :config
  (evil-commentary-mode 1)
)

(use-package evil-matchit
  :config
  (global-evil-matchit-mode 1)
)

(use-package evil-numbers
  :config
  (define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "C-x") 'evil-numbers/dec-at-pt)
  )

(use-package evil-goggles
  :config
  (evil-goggles-mode)
  (evil-goggles-use-diff-faces)
  )

(use-package evil-escape
  :init
  (setq-default evil-escape-key-sequence "jk")
  :config
  (evil-escape-mode 1)
)

(use-package evil-org
  :after org
  :hook (org-mode . evil-org-mode)
)

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
  (setq ivy-re-builders-alist
	'((t      . ivy--regex-plus)))
  )

(use-package ivy-rich)

(setq tab-width 4)
(setq electric-indent-inhibit t)

(setq python-shell-interpreter "python")

(use-package haskell-mode)

(use-package yaml-mode)

(use-package toml-mode)

(use-package markdown-mode)

(use-package lua-mode)

(use-package projectile
  :config
  :custom
  (projectile-completion-system 'ivy)
  (setq projectile-project-search-path '("~/code/python/projects/" "~/code/c/projects/"))
  (setq projectile-switch-project-action #'projectile-dired)
  (projectile-mode 1)
)

(use-package counsel-projectile
  :config
  (counsel-projectile-mode 1)
)

(use-package magit)

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :config
  (lsp-enable-which-key-integration t)
)

(use-package lsp-ui
  :config
  (lsp-ui-mode 1)
)

(use-package company
  :config
  (setq company-minimum-prefix-length 1
	company-idle-delay 0.0
	company-mode-selection-wrap-around t
	)
  (setq company-backends '((company-lsp)                                                                                                                                                               
			   (company-capf)                                                                                                                                                                                       
			   (company-files)                                                                                                                                                                                      
			   (company-dabbrev-code company-gtags company-etags company-keywords)                                                                                                                                  
			   (company-bbdb)                                                                                                                                                                                       
			   (company-eclim)                                                                                                                                                                                      
			   (company-semantic)                                                                                                                                                                                   
			   (company-clang)                                                                                                                                                                                      
			   (company-xcode)                                                                                                                                                                                      
			   (company-cmake)                                                                                                                                                                                      
			   (company-oddmuse)                                                                                                                                                                                    
			   (company-dabbrev)) 
	)
  )

(use-package company-quickhelp)

(use-package org
  :config
  (setq org-confirm-elisp-link-function nil)
)

(use-package org-tempo
  :ensure nil
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (C . t)
     (shell . t)
     (haskell . t)))
  (setq org-src-preserve-indentation t)
  (setq org-structure-template-alist
	'(("a" . "export ascii")
	  ("c" . "center")
	  ("C" . "comment")
	  ("e" . "example")
	  ("E" . "export")
	  ("h" . "export html")
	  ("l" . "export latex")
	  ("q" . "quote")
	  ("s" . "src")
	  ("v" . "verse")
	  ("sh" . "src shell")
	  ("py" . "src python")
	  ("el" . "src emacs-lisp")
	  ("hs" . "src haskell")
	  )

	)
  (push '("conf-unix" . conf-unix ) org-src-lang-modes)
  )

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  )

(use-package mu4e
  :ensure nil
  :config

  (setq smtpmail-smtp-server "smtp.gmail.com"
	smtpmail-smtp-service 465
	smtpmail-stream-type 'ssl)

  (setq mu4e-change-filenames-while-moving t)
  (setq mu4e-update-interval (* 10 60))
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-maildir "~/.mail")
  (setq mu4e-compose-context-policy 'ask)
  (setq mu4e-compose-format-flowed t)
  (setq mu4e-context-policy 'always-ask)

  (setq mu4e-contexts
	(list
	 ;; Work Account

	 (make-mu4e-context
	  :name "work"
	  :match-func
	  (lambda (msg)
	    (when msg
	      (string-prefix-p "/work" (mu4e-message-field msg :maildir))))
	  :vars '(
		  (user-mail-address . "pspiagicw@gmail.com")
		  (user-full-name . "pspiagicw")
		  (mu4e-drafts-folder . "/work/[Gmail]/Drafts")
		  (mu4e-sent-folder . "/work/[Gmail]/Sent Mail")
		  (mu4e-refile-folder . "/work/[Gmail]/All Mail")
		  (mu4e-trash-folder . "/work/[Gmail]/Trash")
		  (mu4e-maildir-shortcuts . (
					      ("/work/Inbox" . ?i)
					      ("/work/[Gmail]/Sent Mail" . ?s)
					      ("/work/[Gmail]/Trash" . ?t)
					      ("/work/[Gmail]/Drafts" . ?d)
					      ("/work/[Gmail]/All Mail" . ?a)
					      ))
		  ))

	 (make-mu4e-context
	  :name "college"
	  :match-func
	  (lambda (msg)
	    (when msg
	      (string-prefix-p "/college" (mu4e-message-field msg :maildir))))
	  :vars '(
		  (user-mail-address . "pratham.sandeep2020@vitbhopal.ac.in")
		  (user-full-name . "Pratham Powar(20BAI10146)")
		  (mu4e-drafts-folder . "/college/[Gmail]/Drafts")
		  (mu4e-sent-folder . "/college/[Gmail]/Sent Mail")
		  (mu4e-refile-folder . "/college/[Gmail]/All Mail")
		  (mu4e-trash-folder . "/college/[Gmail]/Trash")
		  (mu4e-maildir-shortcuts . (
					      ("/college/Inbox" . ?i)
					      ("/college/[Gmail]/Sent Mail" . ?s)
					      ("/college/[Gmail]/Trash" . ?t)
					      ("/college/[Gmail]/Drafts" . ?d)
					      ("/college/[Gmail]/All Mail" . ?a)
					      ))
		  ))

	 (make-mu4e-context
	  :name "personal"
	  :match-func
	  (lambda (msg)
	    (when msg
	      (string-prefix-p "/personal" (mu4e-message-field msg :maildir))))
	  :vars '(
		  (user-mail-address . "prathampowar2001@gmail.com")
		  (user-full-name . "Pratham Sandeep Powar")
		  (mu4e-drafts-folder . "/personal/[Gmail]/Drafts")
		  (mu4e-sent-folder . "/personal/[Gmail]/Sent Mail")
		  (mu4e-refile-folder . "/personal/[Gmail]/All Mail")
		  (mu4e-trash-folder . "/personal/[Gmail]/Trash")
		  (mu4e-maildir-shortcuts . (
					      ("/personal/Inbox" . ?i)
					      ("/personal/[Gmail]/Sent Mail" . ?s)
					      ("/personal/[Gmail]/Trash" . ?t)
					      ("/personal/[Gmail]/Drafts" . ?d)
					      ("/personal/[Gmail]/All Mail" . ?a)
					      ))
		  ))
	 ))
  )

(use-package elfeed
  :config
  (setq elfeed-show-entry-switch #'elfeed-display-buffer)
  (setq elfeed-feeds
	'(
	  ( "https://www.techrepublic.com/rssfeeds/articles/" article tech )
	  ( "https://opensource.com/feed " opensource tech )
	  ( "http://feeds.bbci.co.uk/news/rss.xml?edition=int" news )
	  ( "https://www.cnet.com/rss/news/" news )
	  ( "https://www.space.com/feeds/all" news space )
	  ( "https://towardsdatascience.com/feed" programming )
	  ( "https://youtube.com/feeds/videos.xml?channel_id=UCVls1GmFKf6WlTraIb_IaJg" youtube linux )
	  ( "https://youtube.com/feeds/videos.xml?channel_id=UCylGUf9BvQooEFjgdNudoQg" youtube )
	  ( "https://youtube.com/feeds/videos.xml?channel_id=UCXuqSBlHAE6Xw-yeJA0Tunw" youtube )
	  ( "https://youtube.com/feeds/videos.xml?channel_id=UCld68syR8Wi-GY_n4CaoJGA" youtube )
	  ( "https://youtube.com/feeds/videos.xml?channel_id=UCsnGwSIHyoYN0kiINAGUKxg" youtube )
	  ( "https://youtube.com/feeds/videos.xml?channel_id=UC6uKrU_WqJ1R2HMTY3LIx5Q" youtube )
	  ( "https://youtube.com/feeds/videos.xml?channel_id=UCL6JmiMXKoXS6bpP1D3bk8g" youtube )
	  ( "https://youtube.com/feeds/videos.xml?channel_id=UCMiJRAwDNSNzuYeN2uWa0pA" youtube )
	  ( "https://youtube.com/feeds/videos.xml?channel_id=UCBJycsmduvYEL83R_U4JriQ" youtube )
	  ( "https://youtube.com/feeds/videos.xml?channel_id=UCBNHHEoiSF8pcLgqLKVugOw" youtube )
	  ( "https://xkcd.com/rss.xml" blog )
	  ( "https://planet.emacsen.org/atom.xml" emacs )
	  ( "https://www.reddit.com/r/emacs/.rss" emacs reddit )
	  ( "https://www.reddit.com/r/linux/.rss" linux reddit )
	  ( "https://www.reddit.com/r/linuxmemes/.rss" linux reddit )
	  ( "https://www.reddit.com/r/vim/.rss" vim reddit )
	  ( "https://www.reddit.com/r/neovim/.rss" vim reddit )
	  ( "https://www.reddit.com/r/archlinux/.rss"  linux  reddit )
	  ( "https://www.reddit.com/r/awesomewm/.rss" linux reddit )
	  ( "https://www.reddit.com/r/google/.rss" news reddit )
	  ( "https://www.reddit.com/r/Python/.rss" programming reddit )
	  ( "https://www.reddit.com/r/suckless/.rss" linux reddit )
	  ( "https://www.reddit.com/r/techhumor/.rss" blog reddit )
	  ( "https://www.reddit.com/r/unixporn/.rss" linux reddit )
	  ( "https://www.reddit.com/r/listentothis/.rss" reddit )
	  ( "https://drewdevault.com/blog/index.xml" blog )
	  ( "https://unixsheikh.com/feed.rss" blog )
	  ( "https://mikestone.me/feed.xml" blog )
	  ( "https://www.phoronix.com/rss.php" )
	  ( "https://fedoramagazine.org/feed/" linux news)
	  ( "https://robertheaton.com/feed" blog )
	  ( "https://reddit.com/r/vimkeyboard/.rss" linux  reddit)
	  ( "https://reddit.com/r/vimporn/.rss" linux reddit)
	  ( "https://reddit.com/r/commandline/.rss" programming reddit)
	  ( "https://distrowatch.com/news/dwd.xml" linux )
	  ( "https://lxer.com/module/newswire/headlines.rss" news )
	  ( "https://betanews.com/feed" news )
	  ( "https://www.computerworld.com/category/linux/index.rss" news )
	  ( "https://youtube.com/feeds/videos.xml?channel_id=UC88tlMjiS7kf8uhPWyBTn_A"  youtube)
	  ( "http://www.polygon.com/rss/index.xml" blog )
	  ( "http://www.dumbingofage.com/feed/" blog )
	  ( "http://www.smbc-comics.com/rss.php" blog )
	  ( "http://feeds.feedburner.com/codinghorror" tech news)
	  ( "https://news.ycombinator.com/rss" )
	  ( "http://waitbutwhy.com/feed" blog )
	  ( "http://www.gunnerkrigg.com/rss.xml" blog)
	  ( "https://reddit.com/r/technology/.rss"  tech  reddit)
	  ( "https://reddit.com/r/games/.rss"  gaming)
	  ( "http://rss.slashdot.org/Slashdot/slashdot"  tech)
	  ( "https://www.cyberciti.biz/atom/atom.xml" tech news)
	  ( "https://www.gamingonlinux.com/article_rss.php" gaming linux)
	  ( "https://feeds.feedburner.com/Ostechnix" linux tech)
	  ( "https://omgubuntu.co.uk/feed" tech linux)
	  ( "https://www.tecmint.com/feed/" tech news)
	  ( "https://youtube.com/feeds/videos.xml?channel_id=UCsBjURrPoezykLs9EqgamOA" youtube )
	  ( "https://youtube.com/feeds/videos.xml?channel_id=UC88tlMjiS7kf8uhPWyBTn_A" youtube )
	  ( "https://youtube.com/feeds/videos.xml?channel_id=UCCIHOP7e271SIumQgyl6XBQ" youtube )
	  ( "https://youtube.com/feeds/videos.xml?channel_id=UCP2bshADPrVMoNrdJvZEQzw" youtube )
	  ( "https://youtube.com/feeds/videos.xml?channel_id=UCP2bshADPrVMoNrdJvZEQzw" youtube )
	  ( "https://youtube.com/feeds/videos.xml?channel_id=UC-x4oXG1CJPrhMiARkW9b3A" youtube )
	  ( "https://youtube.com/feeds/videos.xml?channel_id=UCRE3NFNtdjR96-H4QG4U1Fg" youtube )
	  ( "https://youtube.com/feeds/videos.xml?channel_id=UCxwcmRAmBRzZMNS37dCgmHA" youtube )
	  ( "https://youtube.com/feeds/videos.xml?channel_id=UCXPHFM88IlFn68OmLwtPmZA" youtube )
	  ( "https://youtube.com/feeds/videos.xml?channel_id=UCBa659QWEk1AI5Tg--mrJ2A" youtube )
	  ( "https://youtube.com/feeds/videos.xml?channel_id=UCAiiOTio8Yu69c3XnR7nQBQ" youtube )
	  ( "https://pspiagicw.github.io/rss.xml" personal )
	  )
	)
  )

(use-package erc
  :ensure nil
  :config
  (setq erc-server "irc.libera.chat"
	erc-nick "pspiagicw"
	erc-user-full-name "pspiagicw"
	erc-track-shorten-start 8
	erc-kill-buffer-on-part t
	erc-fill-functional 'erc-fill-static
	erc-fill-static-center 22
	)
  )

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode)
)

(use-package dired-hide-dotfiles
  :hook
  (dired-mode . dired-hide-dotfiles-mode)
)

(use-package eww
  :ensure nil
)

(add-hook 'eww-after-render-hook #'prot-eww--rename-buffer)
(advice-add 'eww-back-url :after #'prot-eww--rename-buffer)
(advice-add 'eww-forward-url :after #'prot-eww--rename-buffer)

(setq
 shr-use-fonts nil
 shr-use-colors t
 shr-indentation 2
 shr-width 150
 )

(use-package olivetti)
(add-hook 'eww-mode-hook (lambda () (olivetti-mode)))

(setq browse-url-browser-function 'custom-browse-url)
(setq browse-url-secondary-browser-funcion 'browse-url-generic)
(setq browse-url-generic-program "qutebrowser")

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
  (openwith-mode -1)
  )

(defun prot-eww--rename-buffer ()
  "Rename EWW buffer using page title or URL.
To be used by `eww-after-render-hook'."
  (let ((name (if (eq "" (plist-get eww-data :title))
		  (plist-get eww-data :url)
		(plist-get eww-data :title))))
    (rename-buffer (format "*%s # eww*" name) t)))

(defun elfeed-display-buffer (buf &optional act)
  (display-buffer buf)
  (set-window-text-height (get-buffer-window) (round (* 0.7 (frame-height)))))

(defun kill-dired-buffers ()
  (interactive)
  (mapc (lambda (buffer) 
	  (when (eq 'dired-mode (buffer-local-value 'major-mode buffer)) 
	    (kill-buffer buffer))) 
	(buffer-list)))

(setq theme-index 0)
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
      (projectile-run-eshell)
    (eshell)))

(defun custom-grep ()
  "Determines if in project or not and calls required grep function"
  (interactive)
  (if (projectile-project-p)
      (counsel-projectile-grep)
    (counsel-grep)))

(defun custom-open-eww ()
  (interactive)
  (eww-browse-url url-to-open)
  )
(defun custom-browse-url-generic ()
  (interactive)
  (browse-url-generic url-to-open)
  )
(defun custom-reddigg-url ()
  (interactive)
  (reddigg-view-comments url-to-open)
  )
(defun custom-browse-url (url &optional a)
    "Browse URL"
    (setq url-to-open url)
    (command-execute 'hydra-url/body)
)

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

(defun custom-occur ()
  "Determines if in project or not and calls required find-file function"
  (interactive)
  (if (projectile-project-p)
      (projectile-multi-occur)
    (command-execute 'occur)))

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

(defun custom-elfeed-back()
  (interactive)
  (elfeed-kill-buffer)
  (switch-to-buffer "*elfeed-search*")
  )

(defun move-mpc-down ()
  (interactive)
  (evil-next-visual-line)
  (mpc-select)
 )
(defun move-mpc-up ()
  (interactive)
  (evil-previous-visual-line)
  (mpc-select)
 )
(defun increase-mpc-volume ()
  (interactive)
  (async-shell-command "mpc volume +5")
)

(defun decrease-mpc-volume ()
  (interactive)
  (async-shell-command "mpc volume -5")
 )

(setq config-dict '(
		    (alacritty . "~/.config/alacritty/alacritty.yml")
		    (emacs . "~/.config/emacs/emacs.org")
		    (xmonad . "~/.xmonad/xmonad.org")
		    (bash . "~/.bashrc")
		    (dunst . "~/.config/dunst/dunstrc")
		    (xmobar . "~/.config/xmobar/xmobarrc")
		    ))
(defun counsel-confedit ()
  "Edit a config file"
  (interactive)
  (ivy-read "Edit Config: "
	    (mapcar 'car (car ( list config-dict)))
	    :action (lambda (x)
		      (find-file (alist-get (intern x) config-dict)))))

(defun counsel-run-comand ()
  "Run a command"
  (interactive)
  (ivy-read "Run Command: "
	    (split-string (shell-command-to-string "dmenu_path"))
	    :action (lambda (x)
		      (async-shell-command x))))

(setq wallpaper-directory "~/.config/wallpaper/wallpapers")
(defun counsel-wallpaper ()
  "Change wallpaper"
  (interactive)
  (ivy-read "Choose Wallpaper: "
	    (directory-files wallpaper-directory)
	    :action (lambda (x)
		      (async-shell-command (format "feh --no-fehbg --bg-fill %s/%s" wallpaper-directory x)))))

(use-package general)

(use-package hydra)

(defhydra hydra-window (:color red
                        :hint nil)
  "
 Split: _v_ert _x_:horz
Delete: _o_nly  _da_ce  _dw_indow  _db_uffer  _df_rame
  Move: _s_wap
Frames: _f_rame new  _df_ delete
  Misc: _m_ark _a_ce  _u_ndo  _r_edo"
  ("h" windmove-left)
  ("j" windmove-down)
  ("k" windmove-up)
  ("l" windmove-right)
  ("H" hydra-move-splitter-left)
  ("J" hydra-move-splitter-down)
  ("K" hydra-move-splitter-up)
  ("L" hydra-move-splitter-right)
  ("|" (lambda ()
         (interactive)
         (split-window-right)
         (windmove-right)))
  ("_" (lambda ()
         (interactive)
         (split-window-below)
         (windmove-down)))
  ("v" split-window-right)
  ("x" split-window-below)
  ;("t" transpose-frame "'")
  ;; winner-mode must be enabled
  ("u" winner-undo)
  ("r" winner-redo) ;;Fixme, not working?
  ("o" delete-other-windows :exit t)
  ("a" ace-window :exit t)
  ("f" new-frame :exit t)
  ("s" ace-swap-window)
  ("da" ace-delete-window)
  ("dw" delete-window)
  ("db" kill-this-buffer)
  ("df" delete-frame :exit t)
  ("q" nil)
  ;("i" ace-maximize-window "ace-one" :color blue)
  ;("b" ido-switch-buffer "buf")
  ("m" headlong-bookmark-jump)
)

(defhydra hydra-url (:exit t)
  "Browse URL"
  ("e" custom-open-eww "eww")
  ("b" custom-browse-url-generic "external browser")
  ("r" custom-reddigg-url "reddigg")
)

(defhydra hydra-lsp (:exit t :hint nil)
  "
 Buffer^^               Server^^                   Symbol
-------------------------------------------------------------------------------------
 [_f_] format           [_M-r_] restart            [_d_] declaration  [_i_] implementation  [_o_] documentation
 [_m_] imenu            [_S_]   shutdown           [_D_] definition   [_t_] type            [_r_] rename
 [_x_] execute action   [_M-s_] describe session   [_R_] references   [_s_] signature"
  ("d" lsp-find-declaration)
  ("D" lsp-ui-peek-find-definitions)
  ("R" lsp-ui-peek-find-references)
  ("i" lsp-ui-peek-find-implementation)
  ("t" lsp-find-type-definition)
  ("s" lsp-signature-help)
  ("o" lsp-describe-thing-at-point)
  ("r" lsp-rename)

  ("f" lsp-format-buffer)
  ("m" lsp-ui-imenu)
  ("x" lsp-execute-code-action)

  ("M-s" lsp-describe-session)
  ("M-r" lsp-restart-workspace)
  ("S" lsp-shutdown-workspace)
 )

(defhydra hydra-toggle ()
  "Toggle Settings"
  ("a" custom-open-eww "eww")
  ("b" custom-browse-url-generic "external browser")
  ("r" custom-reddigg-url "reddigg")
)

(general-define-key
 :states '(normal visual)
 :keymaps 'override
 :prefix "SPC"
  ";" '(counsel-M-x :which-key "Execute a Command")
  ">" '(evil-next-buffer :which-key "Move to Next Buffer")
  "<" '(evil-prev-buffer :which-key "Move to Prev Buffer")
  "/" '(counsel-grep :which-key "Grep in Current Buffer")
  "." '(find-file :which-key "Find File")
  "!" '(shell-command :which-key "Execute Shell Command")
  "&" '(async-shell-command :which-key "Execute Shell Command Async")
  "RET" '(counsel-bookmark :which-key "Browse Bookmarks")
)

(general-define-key
 :states '(normal visual)
 :keymaps 'override
 :prefix "SPC"
 "b" '(:ignore t :which-key "Buffer")
 "bn" '(evil-next-buffer :which-key "Switch to next buffer")
 "bp" '(evil-prev-buffer :which-key "Switch to prev buffer")
 "bb" '(counsel-switch-buffer :which-key "Switch to Buffer")
 "br" '(rename-buffer :which-key "Rename buffer")
 "bd" '(evil-delete-buffer :which-key "Delete Buffer")
 "bi" '(ibuffer :which-key "Open Ibuffer")
 "bR" '(read-only-mode :which-key "Toggle Read Only Mode")
 )

(general-define-key
 :states '(normal visual)
 :keymaps 'override
 :prefix "SPC"
 "f" '(:ignore t :which-key "Files")
 "ff" '(counsel-find-file :which-key "Find Files Interactively")
 "fs" '(save-buffer :which-key "Save Current Buffer")
 "fr" '(counsel-recentf :which-key "Find Recent Files")
 "fR" '(rename-file :which-key "Rename File")
 "fC" '(copy-file :which-key "Copy File")
 "fl" '(counsel-locate :which-key "Locate File")
)

(general-define-key
 :states '(normal visual)
 :keymaps 'override
 :prefix "SPC"
 "t" '(:ignore t :which-key "Toggle")
 "tt" '(custom-terminal :which-key "Toggle Terminal")
 "tn" '(display-line-numbers-mode :which-key "Toggle Line Numbers")
 "tk" '(which-key-mode :which-key "Toggle Which Key")
 "ta" '(company-mode :which-key "Toggle Autocompletion")
 "tm" '(menu-bar-mode :which-key "Toggle Menu Bar")
 "tf" '(auto-fill-mode :which-key "Toggle Whitespace mode")
 "ti" '(electric-indent-local-mode :which-key "Toggle Auto Indenting")
 "tl" '(hl-line-mode :which-key "Toggle Line Hightlight")
 "tf" '(flymake-mode :which-key "Toggle Flymake")
 "tF" '(text-scale-adjust :which-key "Toggle font sizes")
 "tp" '(electric-pair-local-mode :which-key "Toggle Pairing")
 "tw" '(whitespace-mode :which-key "Toggle Whitespace Mode")
)

(general-define-key
 :states '(normal visual)
 :keymaps 'override
 :prefix "SPC"
 "n" '(:ignore t :which-key "Narrow")
 "nr" '(narrow-to-region :which-key "Narrow Region")
 "nf" '(narrow-to-defun :which-key "Narrow to Function")
 "np" '(narrow-to-page :which-key "Narrow to Page")
)

(general-define-key
 :states '(normal visual)
 :keymaps 'override
 :prefix "SPC"
 "h" '(:ignore t :which-key "Help")
 "hf" '(describe-function :which-key "Describe Function")
 "hv" '(describe-variable :which-key "Describe Variable")
 "hc" '(describe-key :which-key "Describe Key")
 "hp" '(describe-package :which-key "Describe Package")
 "hi" '(info :which-key "Info Manuals")
 "hm" '(describe-mode :which-key "Describe Mode")
)

(general-define-key
 :states '(normal visual)
 :keymaps 'override
 :prefix "SPC"
 "p" '(:ignore t :which-key "Projects")
 "pp" '(counsel-projectile-switch-project :which-key "Switch Project")
 "pc" '(projectile-compile-project :which-key "Compile Project")
 "pt" '(projectile-test-project :which-key "Test Project")
 "pf" '(counsel-projectile-find-file :which-key "Find File in Project")
 "ps" '(counsel-projectile-grep :which-key "Grep in your Project")
 "pr" '(projectile-run-project :which-key "Run Project")
 "pk" '(projectile-kill-buffers :which-key "Kill all Project buffers")
 "p&" '(projectile-run-async-shell-command-in-root :which-key "Run Command Async in Project")
 "p!" '(projectile-run-command-in-root :which-key "Run Command in Project")
 "pd" '(projectile-find-dir :which-key "Open Dired on Project Root")
 "pg" '(projectile-find-tags :which-key "Find Tags in Project")
 "p%" '(projectile-replace-regexp :which-key "Replace Name in Project")
 "p'" '(projectile-run-term :which-key "Run Term in Root of Project")
)

(general-define-key
 :states '(normal visual)
 :keymaps 'override
 :prefix "SPC"
 "d" '(:ignore t :which-key "Dired")
 "dk" '(kill-dired-buffers :which-key "Kill Dired Buffers")
 "dd" '(custom-dired :which-key "Open Dired")
)

(general-define-key
 :states '(normal visual)
 :keymaps 'override
 :prefix "SPC"
 "g" '(:ignore t :which-key "Git")
 "gg" '(magit-status :which-key "Git Status")
 "gc" '(magit-clone :which-key "Git Clone")
)

(general-define-key
 :states '(normal visual)
 :keymaps 'override
 :prefix "SPC"
 "w" '(:ignore t :which-key "Window")
 "wv" '(custom-vsplit :which-key "Split Vertically")
 "ws" '(custom-split :which-key "Split Horizonatally")
 "wc" '(evil-window-delete :which-key "Delete Window")
 "w=" '(balance-windows :which-key "Balance Windows")
 "wh" '(evil-window-left :which-key "Move to Left Window")
 "wl" '(evil-window-right :which-key "Move to Right Window")
 "wj" '(evil-window-down :which-key "Move to Below Window")
 "wk" '(evil-window-up :which-key "Move to Top Window")
 "wo" '(delete-other-windows :which-key "Delete other Windows")
 "wu" '(winner-undo :which-key "Undo Window Configuration")
 "wr" '(winner-redo :which-key "Redo Window Configuration")
 "w." '(hydra-window/body :which-key "Window Transient State")
)

(general-define-key
 :states '(normal visual)
 :keymaps 'override
 :prefix "SPC"
 "ll" '(lsp :which-key "Start/Connect with LSP Server")
 "l." '(hydra-lsp/body :which-key "LSP Transient State")
 )

(general-define-key
 :states '(normal visual)
 :keymaps 'override
 :prefix "SPC"
 "s" '(:ignore t :which-key "Search")
 "sg" '(grep-find :which-key "Search Using Grep Recursively")
 "ss" '(custom-grep :which-key "Search Using Grep")
 "so" '(custom-occur :which-key "Search Using Occur")
)

(general-define-key
 :states '(normal visual)
 :keymaps 'override
 :prefix "SPC"
 "o" '(:ignore t :which-key "Open Applications")
 "oo" '(openwith-mode :which-key "Toggle OpenWith Mode")
 "or" '(reddigg-view-main :which-key "Open Reddit")
 "oa" '(org-agenda :which-key "Org Agenda")
 "om" '(mpc :which-key "Open Simple MPC")
 "ob" '(eww :which-key "Open Browser")
 "oM" '(mu4e :which-key "Open Mu4e")
)

(use-package link-hint)

(use-package ace-window)

(general-define-key
 :keymaps 'override
 :states '(normal visual)
 :prefix "SPC"
 "j" '(:ignore t :which-key "Jump")
 "ji" '(counsel-semantic-or-imenu :which-key "Jump to tag using Imenu")
 "jl" '(link-hint-open-link :which-key "Jump to link")
 "jw" '(ace-window :which-key "Jump to Window")
 "jn" '(next-error :which-key "Jump to next error")
 "jp" '(previous-error :which-key "Jump to next error")
 )

(general-define-key
 :states '(normal visual)
 :keymaps 'override
 :prefix "SPC"
 "qq" '(delete-frame :which-key "Delete Frame")
 )

(general-define-key
 :keymaps 'override
 :states '(normal visual)
 :prefix "SPC"
 "m" '(:ignore t :which-key "Major Mode")
 )

(general-define-key
 :keymaps 'python-mode-map
 :states '(normal visual)
 :prefix "SPC"
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
 :keymaps 'org-mode-map
 :states '(normal visual)
 :prefix "SPC"
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
 "ml" '(org-insert-link :which-key "Org Insert Link")
 "m'" '(org-edit-special :which-key "Org Edit Special")
 )

(general-define-key
 :keymaps 'dired-mode-map
 :states 'normal
 "h" 'dired-up-directory
 "l" 'dired-find-file
 "." 'dired-hide-dotfiles-mode
 "V" 'dired-mark
 )

(general-define-key
 :keymaps 'elfeed-show-mode-map
 :states 'normal
 "h" 'custom-elfeed-back
 "f" 'link-hint-open-link
 )
(general-define-key
 :keymaps 'elfeed-search-mode-map
 :states 'normal
 "l" 'elfeed-search-show-entry
 "L" 'scroll-other-window
 )

(general-define-key
 :keymaps 'archive-mode-map
 :states 'normal
 "h" 'quit-window
 "l" 'archive-extract
 )

(general-define-key
 :keymaps 'emacs-lisp-mode-map
 :states '(normal visual)
 :prefix "SPC"
 "me" '(eval-last-sexp :which-key "evaluate last sexp")
 "m:" '(eval-expression :which-key "evaluate lisp func")
 "md" '(eval-defun :which-key "evaluate defun")
 "mb" '(eval-buffer :which-key "evaluate buffer")
 "mr" '(eval-region :which-key "evaluate region")
 "mj" '(counsel-imenu :which-key "Imenu Mode")
 )

(general-define-key
 :keymaps 'mpc-mode-map
 :states 'normal
 "j" 'move-mpc-down
 "k" 'move-mpc-up
 "t" 'mpc-toggle-play
 "r" 'mpc-repeat
 "S" 'mpc-toggle-shuffle
 "c" 'mpc-toggle-consume
 "a" 'mpc-playlist-add
 "p" 'mpc-playlist
 ">" 'mpc-next
 "<" 'mpc-prev
 "R" 'mpc-playlist-delete
 "x" 'mpc-play-at-point
 "RET" 'mpc-select
 "+" 'increase-mpc-volume
 "-" 'decrease-mpc-volume
 )
(general-define-key
 :keymaps 'mpc-status-mode-map
 :states 'normal
 "p" 'move-to-mpc-playlist
 )

(general-define-key
 :keymaps 'erc-mode-map
 :states 'normal
 :prefix "SPC"
 "mj" '(erc-join-channel :which-key "ERC Join Channel")
 "mp" '(erc-part-from-channel :which-key "ERC Part Channel")
 "mq" '(erc-quit-server :which-key "ERC Quit Server")
 "mb" '(erc-switch-to-buffer :which-key "ERC Switch Buffer")
 "mt" '(erc-set-topic :which-key "ERC Topic")
 "mn" '(erc-channel-names :which-key "ERC Names")
 )

(general-define-key
 :keymaps 'eww-mode-map
 :states 'normal
 "f" 'link-hint-open-link
)

(general-define-key
 :keymaps 'Info-mode-map
 :states 'normal
 "f" 'link-hint-open-link
)

(general-define-key
 :keymaps 'help-mode-map
 :states 'normal
 "f" 'link-hint-open-link
)

;; Force OpenWith mode to close
(openwith-mode -1)
(setq ivy-re-builders-alist
      '((t . ivy--regex-ignore-order))
)
