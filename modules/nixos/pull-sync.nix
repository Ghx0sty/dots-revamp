{ config, lib, pkgs, ... }:

{
  system.activationScripts.pullSync = {
    text = ''
    export PATH=${pkgs.git}/bin:$PATH

    # FIXME: Fill this out with your own link!
    githublink="https://github.com/Ghx0sty/dots-revamp.git"

    user=$(getent passwd 1000 | cut -d: -f1)
    userdir=$(getent passwd 1000 | cut -d: -f6)
    dotsdir="$userdir/.nixdots"
    nixosdir="/etc/nixos"
    if [[ ! -d $dotsdir ]]; then
      echo "First time setup; cloning repo and putting it in the right places"
      mkdir $dotsdir
      git clone $githublink $dotsdir
      chown -R $user $dotsdir
      rm -rf $nixosdir
      ln -s $dotsdir $nixosdir
    fi
  '';
  };
}
