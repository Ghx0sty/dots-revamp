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
    ./hypr.nix
  ];

  # Nixpkgs configuration moved to flake.nix

  # TODO: Set your username
  home = {
    username = "matt";
    homeDirectory = "/home/matt";
    stateVersion = "25.05";
    packages = with pkgs; [
      neofetch
      lunarvim
      keychain
    ];
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;

  # Enable home-manager and git
  programs = {
    home-manager.enable = true;
    rofi.enable = true;

    git = {
      enable = true;
      userName = "Ghx0sty";
      userEmail = "blobman320@gmail.com";
    };

    ssh = {
      enable = true;
      addKeysToAgent = "yes";
    };

    zsh = {
      enable = true;
      shellAliases = {
        home-sync = "home-manager switch --flake ~/.nixdots#matt@hackpc";
        nixos-switch = "sudo nixos-rebuild switch --flake ~/.nixdots#hackpc --use-remote-sudo";
        nixos-sync = "sudo nixos-rebuild switch --flake ~/.nixdots#hackpc --use-remote-sudo && home-manager switch --flake ~/.nixdots#matt@hackpc";
        flake-update = "nix flake update --flake ~/.nixdots";
      };
    }; 

    keychain = {
      enable = true;
      keys = ["githubkey"]; # or your actual key file name
    };
    alacritty = {
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
          size = 12.5;
        };
      };
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
}
