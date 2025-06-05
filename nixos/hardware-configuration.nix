# This is just an example, you should generate yours with nixos-generate-config and put it in here.
{
  pkgs,
  ...
}: {
  # boot.loader.systemd-boot.enable = true;
  
  boot = {
    # Fixes resolution
    kernelParams = [ "video=Virtual-1:1920x1080@60" ];
    loader = {
      grub = {
        enable = true;
        # Pizzazz
        theme = "${pkgs.sleek-grub-theme}";
        efiSupport = true;
        devices = [ "nodev" ];
      };
      efi = {
        efiSysMountPoint = "/boot/EFI";
      };
    };
  };
  
 
  # Set your system kind (needed for flakes)
  nixpkgs.hostPlatform = "x86_64-linux";
}
