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
    # Additional flake imports go here:
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # Hardware configuration for current host:
    ./hardware-configuration-template.nix
    
    # Disko for current host:
    inputs.disko.nixosModules.disko
    ../../disko/template/disko-template.nix
  ];

  # Nixpkgs configurations moved to flake.nix
  
  # Configure nix.settings for host using nix.settings = {}

  environment = {
    systemPackages = with pkgs; [
    # Drop your host packages here
    nano
    htop
    steam
    ];
  };
 
  # TODO: Set a hostname
  networking.hostName = "template";

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    # TODO: Replace with your username
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
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      # Import your home-manager configuration
      matt = import ../../home-manager/base/home.nix;
    };
  };

  # Going to put services here:
  services.openssh.enable = true;
  services.xserver = {
    enable = true;
    displayManager = {
      setupCommands = "${pkgs.xorg.xrandr}/bin/xrandr -s 1920x1080";
    };
  };
  services.displayManager = {
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

  # And programs here:
  programs.ssh.startAgent = true;
  programs.zsh.enable = true;
  programs.hyprland.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}
