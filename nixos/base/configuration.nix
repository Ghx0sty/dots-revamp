# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example
    outputs.nixosModules.pullSync

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  # Nixpkgs configurations moved to flake.nix

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  environment = {
    systemPackages = with pkgs; [
      psmisc
      adwaita-icon-theme
      librewolf
      walker
      rofi-wayland
      sddm-astronaut-patched
      catppuccin-plymouth-patched
      home-manager
      git
      zsh
      alacritty
      xorg.xrandr
      breeze-hacked-cursor-theme
      plymouth
      catppuccin-plymouth-patched
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.roboto-mono
  ];

  # TODO: Set your hostname
  networking.hostName = "hackpc";

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    # FIXME: Replace with your username
    matt = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "root";
      isNormalUser = true;
      shell = pkgs.zsh;
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = ["wheel"];
    };
  };

  # Bit of home-manager here
  # TODO: Remember to remove the home-manager aspect from base later
  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    users = {
      # Import your home-manager configuration
      matt = import ../../home-manager/base/home.nix;
    };
  };

  # Going to put services here:
  services = {
    openssh.enable = true;
    xserver = {
      enable = true;
      displayManager = {
        setupCommands = "${pkgs.xorg.xrandr}/bin/xrandr -s 1920x1080";
      };
    };
    displayManager = {
      sddm = {
        enable = true;
        theme = "sddm-astronaut-theme";
        package = pkgs.kdePackages.sddm;
        extraPackages = with pkgs; [
          sddm-astronaut-patched
        ];
        settings = {
          General = {
            CursorTheme = "Breeze_Hacked";
          };
        };
      };
      defaultSession = "hyprland";
    };
  };

  # And programs here:
  programs = {
    ssh.startAgent = true;
    zsh.enable = true;
    hyprland.enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}
