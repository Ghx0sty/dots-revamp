{ config, lib, pkgs, ... }:

{
  system.activationScripts.etcInit.text = ''
    echo "[flake-maintenance] Copying flake to /etc/nixos..."
    FLAKE_SRC=${toString ../../.}

    if [ ! -d /etc/nixos/.git ]; then
      rm -rf /etc/nixos
      cp -r "$FLAKE_SRC" /etc/nixos
      chown -R root:root /etc/nixos
    fi
  '';
}
