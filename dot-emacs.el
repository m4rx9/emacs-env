(require 'package)
;; Add the original Emacs Lisp Package Archive
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
;; Add the user-contributed repository
;(add-to-list 'package-archives
;             '("marmalade" . "http://marmalade-repo.org/packages/"))
;; from Bogus
(add-to-list 'package-archives
       '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)
;; # load-path
;(add-to-list 'load-path "~/.emacs.d/plugins/")


;; https://github.com/iqbalansari/emacs-emojify
;(add-hook 'after-init-hook #'global-emojify-mode)


;; https://github.com/dimitri/el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (require 'package)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.org/packages/"))
  (package-refresh-contents)
  (package-initialize)
  (package-install 'el-get)
  (require 'el-get))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)


;; source https://github.com/wernerandrew/jedi-starter/blob/master/jedi-starter.el
;; https://www.youtube.com/watch?v=6BlTGPsjGJk
;(defvar local-packages '(projectile auto-complete epc jedi ido-vertical-mode))
;(defun uninstalled-packages (packages)
;  (delq nil
;        (mapcar (lambda (p) (if (package-installed-p p nil) nil p)) packages)))
;; This delightful bit adapted from:
;; http://batsov.com/articles/2012/02/19/package-management-in-emacs-the-good-the-bad-and-the-ugly/
;(let ((need-to-install (uninstalled-packages local-packages)))
;  (when need-to-install
;    (progn
;      (package-refresh-contents)
;      (dolist (p need-to-install)
;	(package-install p)))))
;;;;;;


; Emacs Notebook
(require 'ein)
(setq ein:use-auto-complete t)
;(add-to-hook 'after-init-hook 'ein:notebooklist-load)
(add-hook 'ein (lambda nil (load-theme-buffer-local 'tango (current-buffer))))
(add-hook 'ein:connect-mode-hook 'ein:jedi-setup)
(setq ein:notebook-modes '(ein:notebook-python-mode))
;;Or, to enable "superpack" (a little bit hacky improvements):
(setq ein:use-auto-complete-superpack t)
;(global-set-key "\C-cn" 'ein:notebooklist-open)


;; @pocket
(require 'el-pocket)
(el-pocket-load-auth)


;; rename buffer
(global-set-key "\C-cR" 'rename-buffer)


;; locate
(global-set-key "\C-cl" 'locate)


;; grep
(global-set-key "\C-cq" 'grep)


;; visual mode ;; works! https://www.emacswiki.org/emacs/VisualLineMode
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(add-hook 'org-mode 'turn-on-visual-line-mode)

;; flyspell
(add-hook 'org-mode-hook 'flyspell-mode)
(add-hook 'markdown-mode-hook 'flyspell-mode)
;(add-hook 'python-mode-hook 'flyspell-mode)
(add-hook 'python-mode-hook 'flyspell-prog-mode) ;; https://stackoverflow.com/questions/2455062/how-to-spell-check-python-docstring-with-emacs

;; ispell
(global-set-key "\C-ci" 'ispell)


;; terminal
(global-set-key "\C-cm" 'ansi-term)
;; fix of missing tab completion http://stackoverflow.com/questions/18278310/emacs-ansi-term-not-tab-completing
(add-hook 'term-mode-hook (lambda()
        (setq yas-dont-activate t)))


;;
(setq inhibit-startup-message t)


;; # let make happy all emacs clients
(server-start)


;; A GNU Emacs library to ensure environment variables inside Emacs look the same as in the user's shell.
;; https://github.com/purcell/exec-path-from-shell
(when (memq window-system '(mac ns))
 (exec-path-from-shell-initialize))


;; https://stackoverflow.com/questions/25433260/pylint-does-not-work-in-emacs
;; yep, indeed it fixed a problem with pylint!
(require 'exec-path-from-shell) ;; if not using the ELPA package
(exec-path-from-shell-initialize)


;; # bookmark+ http://www.emacswiki.org/emacs/bookmark%2B-doc.el http://www.cs.cmu.edu/cgi-bin/info2www?%28emacs%29Bookmarks
;'(load "bookmark+.el")
;(require 'bookmark+)
(setq bookmark-save-flag 1)   ;; autosave each change)
(setq inhibit-splash-screen t)
(bookmark-bmenu-list)


;; Mac stuff
;; unset alt
(setq mac-option-key-is-meta t)
(setq mac-right-option-modifier nil)
(setq ns-right-alternate-modifier nil)

;; used mostly for my geekbook, reload a file if modified
;; auto revert http://stackoverflow.com/questions/1480572/how-to-have-emacs-auto-refresh-all-buffers-when-files-have-changed-on-disk
(global-auto-revert-mode t)


;; https://www.emacswiki.org/emacs/AlarmBell
(setq ring-bell-function 'ignore)


;; lista
(global-set-key (kbd "C-x C-b") 'buffer-menu)


;; @PYTHON -------------------------------------------------------------
;; # yasnippet https://github.com/capitaomorte/yasnippet
  ;(add-to-list 'load-path
  ;              "~/.emacs.d/elpa/yasnippet-20130218.2229")
  (require 'yasnippet)
  (yas/global-mode 1)


(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
(setq py-autopep8-options '("--max-line-length=100"))

;;https://www.emacswiki.org/emacs/DeletingWhitespace#toc3
(add-hook 'python-mode-hook
	    (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))

(setenv "PYTHONPATH" "/home/magnus/work/src/rna-pdb-tools")


;; https://www.emacswiki.org/emacs/ShowWhiteSpace
(require 'blank-mode)


;; projectile
(require 'projectile)
(projectile-global-mode)


;; https://www.youtube.com/watch?v=6BlTGPsjGJk
(require 'auto-complete-config)
(ac-config-default)


;; https://github.com/creichert/ido-vertical-mode.el
;(require 'ido-vertical-mode)
;(ido-mode 1)
;(ido-vertical-mode 1)
;(setq ido-vertical-define-keys 'C-n-and-C-p-only)
;; ^ i don't like this in geekbook so I don't see the whole list of files
;; and I can't sort etc.

  ;; # color (set-face-background 'highlight "#FFF498")  ;; orange
  ;(global-hl-line-mode t)


  (add-to-list 'load-path "~/.emacs.d/settings")
  ;(require 'python-el-settings) ;; off this plugin


  ;; # color (set-face-background 'highlight "#FFF498")  ;; orange
  ;(global-hl-line-mode t)


  ;; https://mail.python.org/pipermail/python-list/2002-May/128695.html
  ;; python-outline
  ;(setq outline-start-hidden t)
  ;(load-library "python-outline")
  ;(setq auto-mode-alist (append '(
  ;    ("\\.texi" . texi-outline)
  ;    ("\\.py" . python-outline))
  ;              auto-mode-alist))

  ;; https://github.com/kostafey/sphinx-frontend
  (require 'sphinx-frontend)


  ;; sphinx-doc
  (add-hook 'python-mode-hook (lambda ()
                                  (require 'sphinx-doc)
                                  (sphinx-doc-mode t)))
                                   

  ;;python-mode.el
  (autoload 'python-mode "python-mode" "Python Mode." t)
  (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
  (add-to-list 'interpreter-mode-alist '("ipython" . python-mode))


  ;; jedi melpa @jedi
  ;; this should be after python-model.el load
  (add-hook 'python-mode-hook 'jedi:setup)
  (setq jedi:setup-keys t)                      ; optional
  (setq jedi:complete-on-dot t)                 ; optional
  (setq jedi:tooltip-method '(pos-tip popup))   ; popup window
  (put 'set-goal-column 'disabled nil)


  ;; pylint
  ;(autoload 'pylint "pylint")
  ;(add-hook 'python-mode-hook 'pylint-add-menu-items)
  ;(add-hook 'python-mode-hook 'pylint-add-key-bindings)


  ;; # highlight the import pdb text; anotate pdb http://pedrokroger.com/2010/07/configuring-emacs-as-a-python-ide-2/
  (defun annotate-pdb ()
    (interactive)
    (highlight-lines-matching-regexp "import pdb")
    (highlight-lines-matching-regexp "pdb.set_trace()"))
  (add-hook 'python-mode-hook 'annotate-pdb)


  ;; # python-add-breakpoint http://pedrokroger.com/2010/07/configuring-emacs-as-a-python-ide-2/
  (defun python-add-breakpoint ()
    (interactive)
    ;;(py-newline-and-indent)
    (insert "import ipdb; ipdb.set_trace()")
    (highlight-lines-matching-regexp "^[  ]*import ipdb; ipdb.set_trace()")
    )
  ;;(define-key py-mode-map (kbd "C-c C-b") 'python-add-breakpoint)
  ;;(global-set-key (kbd "<f8>") 'python-add-breakpoint)
  ;;(local-set-key (kbd "<f8>") 'python-add-breakpoint)
(eval-after-load 'python-mode
'(define-key python-mode-map (kbd "<f8>") 'python-add-breakpoint))


;; keybinding for magit status (https://github.com/AndreaCrotti/minimal-emacs-configuration/blob/master/init.el)
;; magit
(require 'magit)
(global-set-key "\C-cg" 'magit-status)


;; pythonpath add auto
(setenv "PYTHONPATH" (shell-command-to-string "$SHELL --login -c 'echo -n $PYTHONPATH'"))
(getenv "PYTHONPATH")

;; C-u C-c # http://stackoverflow.com/questions/12381692/how-to-uncomment-code-block-in-emacs-python-mode
(eval-after-load 'python-mode
'(define-key python-mode-map (kbd "\C-cu") 'uncomment-region))


;; flycheck
(require 'flycheck)
(global-flycheck-mode t)

;; flycheck-pos-tip
(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))

(setq-default flycheck-flake8-maximum-line-length 100)

;;
(require 'flycheck-color-mode-line)
(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))


;; flymake
(require 'flymake-cursor)


;; @RNA -----------------------------------------------------------------
  ;; ralee mode is good for RNA alignment editing # http://personalpages.manchester.ac.uk/staff/sam.griffiths-jones/software/ralee/
  (add-to-list 'load-path "~/.emacs.d/plugins/ralee/elisp")
  (autoload 'ralee-mode "ralee-mode" "Yay! RNA things" t)
  (setq auto-mode-alist (cons '("\\.stk$" . ralee-mode) auto-mode-alist))
  (setq auto-mode-alist (cons '("\\.sto$" . ralee-mode) auto-mode-alist))


  ;; pdb.el
  (load-file "~/.emacs.d/plugins/pdb-mode/pdb-mode.el")
  (setq pdb-rasmol-name "/usr/bin/pymol")
  (setq auto-mode-alist
       (cons (cons "pdb$" 'pdb-mode) 
             auto-mode-alist ) )
  (autoload 'pdb-mode "PDB")
;; WEB DEV -----------------------------------------------------------------
  (autoload 'tidy-parse-config-file "tidy" "Parse the `tidy-config-file'" t)
  (autoload 'tidy-save-settings "tidy" "Save settings to `tidy-config-file'" t)
  (autoload 'tidy-build-menu  "tidy" "Install an options menu for HTML Tidy." t)

  ;If you use html-mode to edit HTML files then add something like
  ;this as well

  (defun my-html-mode-hook () "Customize my html-mode."
    (tidy-build-menu html-mode-map)
    (local-set-key [(control c) (control c)] 'tidy-buffer)
    (setq sgml-validate-command "tidy"))

  (add-hook 'html-mode-hook 'my-html-mode-hook)

  ;This will set up a "tidy" menu in the menu bar and bind the key
  ;sequence "C-c C-c" to `tidy-buffer' in html-mode (normally bound to
  ;`validate-buffer').

  ;For other modes (like html-helper-mode) simple change the variables
  ;`html-mode-hook' and `html-mode-map' to whatever is appropriate e.g.

  (defun my-html-mode-hook () "Customize my html-helper-mode."
    (tidy-build-menu html-helper-mode-map)
    (local-set-key [(control c) (control c)] 'tidy-buffer)
    (setq sgml-validate-command "tidy"))

  (add-hook 'html-helper-mode-hook 'my-html-mode-hook)
;; SETTINGS -----------------------------------------------------------------
  
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-ispell-fuzzy-limit 2)
 '(ac-ispell-requires 4)
 '(bmkp-last-as-first-bookmark-file "/home/magnus/.emacs.d/bookmarks")
 '(column-number-mode t)
 '(display-time-mode t)
 '(fringe-mode (quote (0)) nil (fringe))
 '(magit-git-executable "git")
 '(markdown-hr-string
   "--------------------------------------------------------------------------------")
 '(org-agenda-category-icon-alist
   (quote
    (("work-curr" "~/Dropbox/curr_dropbox/org_mode_icon/icon.png" nil nil))))
 '(org-agenda-custom-commands
   (quote
    (("o" "Agenda and all TODO's work*.org"
      ((agenda ""
	       ((org-agenda-files
		 (quote
		  ("~/Dropbox/geekbook/notes/work-curr.org")))))
       (alltodo ""
		((org-agenda-files
		  (quote
		   ("~/Dropbox/geekbook/notes/work-curr.org" "~/Dropbox/geekbook/notes/work-inbox.org")))))))
     ("l" "Agenda life*.org"
      ((agenda ""
	       ((org-agenda-files
		 (quote
		  ("~/Dropbox/geekbook/notes/life-curr.org" "~/Dropbox/geekbook/notes/life-today.org")))))))
     (";" "Agenda and all TODO's life*.org"
      ((agenda ""
	       ((org-agenda-files
		 (quote
		  ("~/Dropbox/geekbook/notes/life-curr.org" "~/Dropbox/geekbook/notes/life-today.org")))))
       (alltodo ""
		((org-agenda-files
		  (quote
		   ("~/Dropbox/geekbook/notes/life-archive.org" "~/Dropbox/geekbook/notes/life-curr.org" "~/Dropbox/geekbook/notes/life-today.org")))))))
     ("x" "Agenda and all TODO's eXtremal science "
      ((agenda ""
	       ((org-agenda-files
		 (quote
		  ("~/Dropbox/geekbook/notes/science.org")))))
       (alltodo ""
		((org-agenda-files
		  (quote
		   ("~/Dropbox/geekbook/notes/science.org")))))))
     ("k" "Agenda and all TODO's s[k]ills"
      ((agenda ""
	       ((org-agenda-files
		 (quote
		  ("~/Dropbox/geekbook/notes/skills-curr.org")))))
       (alltodo ""
		((org-agenda-files
		  (quote
		   ("~/Dropbox/geekbook/notes/skills-curr.org")))))))
     ("w" "Agenda work*.org"
      ((agenda ""
	       ((org-agenda-files
		 (quote
		  ("~/Dropbox/geekbook/notes/work-someday.org" "~/Dropbox/geekbook/notes/work-extra.org" "~/Dropbox/geekbook/notes/work-curr.org" "~/Dropbox/geekbook/notes/work-archive.org" "~/Dropbox/geekbook/notes/work-inbox.org")))))))
     ("n" "Agenda and all TODO's"
      ((agenda "" nil)
       (alltodo "" nil))
      nil))))
 '(org-agenda-files
   (quote
    ("~/Dropbox/geekbook/notes/work-someday.org" "~/Dropbox/geekbook/notes/work-extra.org" "~/Dropbox/geekbook/notes/work-curr.org" "~/Dropbox/geekbook/notes/work-archive.org" "~/Dropbox/geekbook/notes/work-inbox.org")))
 '(org-agenda-span (quote day))
 '(org-indent-indentation-per-level 5)
 '(org-indent-mode-turns-on-hiding-stars f)
 '(package-selected-packages
   (quote
    (flyspell-correct-popup flyspell-lazy dic-lookup-w3m build-status flycheck-color-mode-line flycheck-pos-tip flymd flycheck-pyflakes django-mode web-narrow-mode web-mode jedi github-theme color-theme-buffer-local uimage csv-mode w3m org-gcal darkroom google-this langtool org-random-todo emojify el-pocket blank-mode ido-vertical-mode ox-gfm auto-org-md sphinx-mode sphinx-frontend sphinx-doc auto-complete-rst ac-helm python ipython outline-magic writeroom-mode wanderlust tidy synonyms stem skype python-pylint python-pep8 python-mode projectile powerline multi-term markdown-mode+ magit-tramp jabber hipster-theme helm-ispell helm google-translate git-rebase-mode git-commit-mode focus flyspell-popup flymake-python-pyflakes flymake flycheck fiplr exec-path-from-shell ess-smart-underscore ess-R-object-popup eimp ecb dictionary color-theme cl-generic calfw-gcal calfw auto-yasnippet auto-dictionary ac-slime ac-python ac-php-core ac-ispell ac-R)))
 '(py-keep-windows-configuration t)
 '(show-paren-mode t)
 '(synonyms-cache-file
   "/Users/magnus/Dropbox/workspace/emacs-env/dot-emacs.d/synonimous/mthesaur.txt.cache")
 '(synonyms-file
   "/Users/magnus/Dropbox/workspace/emacs-env/dot-emacs.d/synonimous/mthesaur.txt")
 '(tool-bar-mode nil))
  
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

; '(default ((t (:family "Monaco" :foundry "unknown" :slant normal :weight normal :height 110 :width normal)))))

;; OrgMode ----------------------------------------------------------
 ;; hide @toolbar
  (setq org-todo-keywords (quote ((sequence "TODO" "INPROGRESS" ">>>>" "WAITING" "DONE"))))
  (setq org-todo-keyword-faces
             '(("TODO" . org-warning)
  	     ("INPROGRESS" . (:foreground "orange"))
  	     (">>>>" .  "dark orange")
  	     ("WAITING" . "violet")
  	     ))

  ;(setq org-agenda-custom-commands 
  ;      '(("w" "work" ;; (1) (2) (3) (4)
  ;         ((org-agenda-files '("/home/magnus/Dropbox/lb_v2/md/work-curr.org" "/home/magnus/Dropbox/lb_v2/md/work-extra.org")) ;; (5)
  ;          (org-agenda-sorting-strategy '(priority-up effort-down))) ;; (5) cont.
  ;         ) ;; (6)
  ;        ;; ...other commands here
  ;        )
  ;)

  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (setq org-log-done t)

  (lambda ()
  (interactive)
  (org-agenda-refile nil nil t))


  (setq org-directory "~/Dropbox/geekbook/notes/")
  (setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
  (setq org-mobile-files '("~/Dropbox/geekbook/notes/work-curr.org" "~/Dropbox/geekbook/notes/life-curr.org"  "~/Dropbox/geekbook/notes/skills-curr.org"))
  (setq org-mobile-inbox-for-pull "~/Dropbox/geekbook/notes/inbox.org")
  ;;(setq org-mobile-inbox-for-pull "~/Dropbox/inbox.org")
  (put 'upcase-region 'disabled nil)

  (org-mode)
  (org-mobile-pull)
  (add-hook 'after-init-hook 'org-mobile-pull)
  (add-hook 'after-init-hook 'org-mobile-push)
  (add-hook 'kill-emacs-hook 'org-mobile-push)
  (add-hook 'kill-emacs-hook 'org-mobile-pull)


(setq org-random-todo-how-often 1500)
(org-random-todo-mode 1)
(global-set-key "\C-c0" 'org-random-todo)

;; @ENGLISH/SPELLING/@WRITING -----------------------------------------------
;(:name textlint
;    :type git
;    :url "git://github.com/DamienCassou/textlint.git"
;    :website "http://scg.unibe.ch/research/textlint"
;    :description "Allows the integration of TextLint within Emacs"
;    :load "textlint.el")

;(global-set-key (kbd "<f7>") 'dic-lookup-w3m--collocation-weblio-word)
;(global-set-key (kbd "<f8>") 'synonyms-match-more)
;(global-set-key (kbd "<f6>") 'lookup-word-definition)

;; https://github.com/xuchunyang/flyspell-popup
(define-key flyspell-mode-map (kbd "C-;") #'flyspell-popup-correct)
(add-hook 'flyspell-mode-hook #'flyspell-popup-auto-correct-mode)

;; https://github.com/syohex/emacs-ac-ispell
;; Completion words longer than 4 characters
(eval-after-load "auto-complete"
  '(progn
     (ac-ispell-setup)))

(add-hook 'git-commit-mode-hook 'ac-ispell-ac-setup)
(add-hook 'text-mode-hook 'ac-ispell-ac-setup)
(add-hook 'org-mode-hook 'ac-ispell-ac-setup)
(add-hook 'markdown-mode-hook 'ac-ispell-ac-setup)          
;;

;; @darkroom
(defun darkroom-mode ()
	"Make things simple-looking by removing decoration 
	 and choosing a simple theme."
        (interactive)
        ;(switch-full-screen 1)     ;; requires above function 
	;(color-theme-retro-green)  ;; requires color-theme
        (setq left-margin 10)
        (menu-bar-mode -1)
        (tool-bar-mode -1)
        (scroll-bar-mode -1)
        (set-face-foreground 'mode-line "gray15")
        (set-face-background 'mode-line "black")
        (auto-fill-mode 1))


;; @google-this-mode 
;(google-this-mode 1)
;(global-set-key (kbd "C-x g") 'google-this-mode-submap)
;(global-set-key (kbd "C-c g w") 'google-word)
;(global-set-key (kbd "C-c g t") 'google-this)
;(global-set-key (kbd "C-c g l") 'google-line)
;(global-set-key (kbd "C-c g r") 'google-region)

  ;; google-translate
  (require 'google-translate)

  (global-set-key "\C-ct" 'google-translate-at-point)
  (global-set-key "\C-cr" 'google-translate-at-point-reverse)
  ;;(global-set-key (kbd "C-c r") 'google-translate-at-point-reverse)
  ;;(global-set-key "\C-c" 'google-translate-at-point-reverse)
  ;;(global-set-key "\C-cT" 'google-translate-query-translate)
  ;;(global-set-key (kbd "C-c R") 'google-translate-query-translate-reverse)
  (setq google-translate-default-source-language "en")
  (setq google-translate-default-target-language "pl")


(require 'langtool)
(setq langtool-java-bin "/usr/bin/java")
(setq langtool-language-tool-jar "/Users/magnus/opt/languagetool/LanguageTool-3.7/languagetool-commandline.jar")
(setq langtool-default-language "en-US")

(global-set-key "\C-c4w" 'langtool-check)
(global-set-key "\C-c4W" 'langtool-check-done)
(global-set-key "\C-c4l" 'langtool-switch-default-language)
(global-set-key "\C-c44" 'langtool-show-message-at-point)
(global-set-key "\C-c4c" 'langtool-correct-buffer)

(defun langtool-autoshow-detail-popup (overlays)
  (when (require 'popup nil t)
    ;; Do not interrupt current popup
    (unless (or popup-instances
                ;; suppress popup after type `C-g` .
                (memq last-command '(keyboard-quit)))
      (let ((msg (langtool-details-error-message overlays)))
        (popup-tip msg)))))

(setq langtool-autoshow-message-function
      'langtool-autoshow-detail-popup)

;; MARKDOWN --------------------------------------------------------------------
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
  (put 'narrow-to-region 'disabled nil)
  ;; duplicate line C-c C-d
  (global-set-key "\C-c\C-d" "\C-a\C- \C-n\M-w\C-y")


;; https://github.com/jamcha-aa/auto-org-md
;  (require 'auto-org-md)

;; @THEME --------------------------------------------------------------------
(require 'hipster-theme) ;; should be before powerline, otherwise it seems that it overwrites powerline
;; http://stackoverflow.com/questions/4821984/emacs-osx-default-font-setting-does-not-persist


;;https://stackoverflow.com/questions/4532024/different-color-themes-per-mode-in-emacs?rq=1
(defun w () 
       (interactive)
         (let ((color-theme-is-global nil))
	   (iimage-mode)
	   ;(set-cursor-color "#000") 
	;   (load-theme-buffer-local 'whiteboard (current-buffer))
	   (load-theme-buffer-local 'github (current-buffer))
	   )
	 )

(defun b () 
       (interactive)
         (let ((color-theme-is-global nil))
          ;;(load-theme 'wombat t)
	  ;(set-cursor-color "#fff") 
          (load-theme-buffer-local 'wombat (current-buffer))
          )
         )

;; powerline
(require 'cl)
(require 'powerline)
(powerline-default-theme)
(set-face-attribute 'mode-line nil
                      :foreground "Black"
                      :background "DarkOrange"
                      :box nil)  

;;  (old) python-outline
;; -------------------------------------------------------------
;; it has to be at the end, then it works by default!
;; https://mail.python.org/pipermail/python-list/2002-May/128695.html
;;(add-to-list 'load-path "~/.emacs.d/plugins/python-outline/")
(load-file "~/.emacs.d/plugins/python-outline/python-outline.el")

;; (global-set-key (kbd "\C-co")  'python-outline)
(eval-after-load 'python-mode
   '(define-key python-mode-map (kbd "\C-c o") 'python-outline))

;(setq outline-start-hidden t)
(setq auto-mode-alist (append '(
    ("\\.text" . texi-outline)
    ("\\.py" . python-outline))
             auto-mode-alist))

;; Emacs lips mode <http://ergoemacs.org/emacs/reclaim_keybindings.html>
(define-key emacs-lisp-mode-map (kbd "C-c b") 'eval-buffer)
(define-key emacs-lisp-mode-map (kbd "C-c r") 'eval-region)


;;
(add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . csv-mode))
(autoload 'csv-mode "csv-mode"
  "Major mode for editing comma-separated value files." t)
(put 'downcase-region 'disabled nil)


(scroll-bar-mode -1)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))


;; tramp
(require 'tramp)
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)


;; My plugins ----------------------------------------------------------
  ;; Insert curr date use with Geekbook
  ;; http://www.emacswiki.org/emacs/InsertingTodaysDate
  (defun insert-current-date () (interactive)
     (insert (shell-command-to-string "echo -n $(date +%y%m%d)"))) ;; echo -n $(date +%y%m%d)
  (global-set-key (kbd "C-c .") 'insert-current-date)


(add-hook 'html-mode-hook 'web-mode)


