;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(completion-styles '(basic partial-completion emacs22 flex))
 '(custom-enabled-themes '(modus-operandi-tinted))
 '(fido-mode t)
 '(fido-vertical-mode t)
 '(frame-background-mode 'light)
 '(icomplete-mode t)
 '(indent-tabs-mode nil)
 '(package-archive-priorities '(("gnu" . 9) ("melpa-stable" . 8)))
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/")
     ("melpa-stable" . "https://stable.melpa.org/packages/")
     ("melpa" . "https://melpa.org/packages/")))
 '(package-selected-packages nil)
 '(savehist-mode t)
 '(scroll-bar-mode nil)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(which-key-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "IBM Plex Mono" :foundry "IBM " :slant normal :weight regular :height 98 :width normal)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Put manual customization below this point ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (package-refresh-contents)

(use-package acp :ensure t :pin melpa) ;; dependency of agent-shell
(use-package agent-shell
  :ensure t
  :pin melpa
  :custom
  (agent-shell-mistral-authentication
   (agent-shell-mistral-make-authentication
    :api-key (lambda ()
	       (string-trim
		(shell-command-to-string "source ~/.vibe/.env; echo $MISTRAL_API_KEY"))))))

(use-package eca
  :ensure t
  :pin melpa
  :custom
  (eca-custom-command '("eca" "server")))
