(setq doom-theme 'doom-outrun-electric doom-font (font-spec :family "RobotoMono Nerd Font" :weight `medium :size 11.0))

(use-package lsp-mode
  :ensure t)

(use-package lsp-nix
  :ensure lsp-mode
  :after (lsp-mode)
  :demand t
  :custom
  (lsp-nix-nil-formatter ["nixfmt"]))

(use-package nix-mode
  :hook (nix-mode . lsp-deferred)
  :ensure t)
