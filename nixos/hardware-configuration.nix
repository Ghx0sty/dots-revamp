# This is just an example, you should generate yours with nixos-generate-config and put it in here.
{
  pkgs,
  ...
}: {
  boot = {
    # Fixes resolution
    kernelParams = [ "video=Virtual-1:1920x1080@60" "quiet" "splash" ];
    loader = {
      grub = {
        enable = true;
        # Pizzazz
        theme = "${pkgs.sleek-grub-theme-patched}";
        efiSupport = true;
        # efiInstallAsRemovable = true;
        devices = [ "nodev" ];
        gfxmodeEfi = "1920x1080";
      };
      efi = {
        efiSysMountPoint = "/boot";
        canTouchEfiVariables = true;
      };
    };
    plymouth  = {
      enable = true;
      theme = "fade-in";
    };
    initrd = {
      systemd.enable = true;
    };
  };
  
 
  # Set your system kind (needed for flakes)
  nixpkgs.hostPlatform = "x86_64-linux";
}
