{ config, lib, pkgs, ... }:

{
  system.activationScripts.pullSync = {
    text = ''
    export PATH=${pkgs.git}/bin:$PATH
    userdir=$(getent passwd 1000 | cut -d: -f6)
    dotsdir="$userdir/.nixdots"
    nixosdir="/etc/nixos"
    if [[ ! -d $dotsdir ]]; then
      echo "First time setup; cloning repo and putting it in the right places"
      mkdir $dotsdir
      git clone https://github.com/Ghx0sty/dots-revamp.git $dotsdir
      chown -R matt $dotsdir
      rm -rf $nixosdir
      ln -s $dotsdir $nixosdir
    fi
  '';
  };
}
