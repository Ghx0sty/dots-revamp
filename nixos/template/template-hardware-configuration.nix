# This is just an example, you should generate yours with nixos-generate-config and put it in here.
{
  pkgs,
  ...
}: {
  boot = {
    # TODO: Change your resolution per host
    kernelParams = [ "video=Virtual-1:1920x1080@60" "quiet" "splash" ];
    loader = {
      grub = {
        gfxmodeEfi = "1920x1080";
      };
    };
  };
 
  # Set your system kind (needed for flakes)
  nixpkgs.hostPlatform = "x86_64-linux";
}
