# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };
  sddm-astronaut-patched = pkgs.callPackage "${pkgs.path}/pkgs/data/themes/sddm-astronaut" { embeddedTheme = "black_hole"; };
  sleek-grub-theme-patched = pkgs.callPackage "${pkgs.path}/pkgs/by-name/sl/sleek-grub-theme/package.nix" { withStyle = "bigSur"; withBanner = "Hello world!"; };
}
