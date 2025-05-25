{ config, lib, pkgs, ... }:

{
  system.activationScripts.githubSync.text = ''
  echo "Syncing /etc/nixos to GitHub..."
  cd /etc/nixos
  git add .
  git commit -S
  git push
'';
}
