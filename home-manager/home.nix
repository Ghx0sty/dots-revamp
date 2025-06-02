# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example
    # outputs.homeManagerModules.pullSyncHome
    outputs.homeManagerModules.githubSync
    # outputs.homeManagerModules.test

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # TODO: Set your username
  home = {
    username = "matt";
    homeDirectory = "/home/matt";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [ 
    neofetch
    lunarvim
    keychain
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Ghx0sty";
    userEmail = "blobman320@gmail.com";
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      home-sync = "home-manager switch --flake ~/.nixdots#matt@hackpc";
      nixos-switch = "sudo nixos-rebuild switch --flake ~/.nixdots#hackpc";
      nixos-sync = "sudo nixos-rebuild switch --flake ~/.nixdots#hackpc && home-manager switch --flake ~/.nixdots#matt@hackpc";
      flake-update = "nix flake update --flake ~/.nixdots";
    };
  };

  programs.keychain = {
    enable = true;
    keys = [ "githubkey" ];  # or your actual key file name
  };

  # Here goes the Hyprland:
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$terminal" = "alacritty";
      
      "$mainmod" = "ALT";
      "$secondmod" = "SUPER";
      monitor = [
        "Virtual-1,1920x1080@60,0x0,1"
      ];
      bind = [
        "$mainmod, q, exec, $terminal"
        "$mainmod, c, killactive"
        "$mainmod, m, exit"
      ];
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "RobotoMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "RobotoMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "RobotoMono Nerd Font";
          style = "Italic";
        };
        size = 16.0;
      };
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
