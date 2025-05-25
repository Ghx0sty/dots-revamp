{ config, lib, pkgs, ... }:

{
  githubSync = system.activationScripts.githubSync.text = ''
  echo "Syncing /etc/nixos to GitHub..."
  cd /etc/nixos
  git add .
  git commit -S
  git push
'';
}
