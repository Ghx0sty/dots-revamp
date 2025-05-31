{ config, lib, pkgs, ... }:

{
  system.activationScripts.pullSync = {
    text = ''
    # TODO: This script fetches the first user you make by UID (1000). Make sure this is the one you want running stuff!
    # Also note, this script makes your dots push ssh based!
    export PATH=${pkgs.git}/bin:$PATH

    # FIXME: Fill this out with your own link!
    githublink="https://github.com/Ghx0sty/dots-revamp.git"
    githubssh="git@github.com:Ghx0sty/dots-revamp.git"

    user=$(getent passwd 1000 | cut -d: -f1)
    userdir=$(getent passwd 1000 | cut -d: -f6)
    dotsdir="$userdir/.nixdots"
    nixosdir="/etc/nixos"
    if [[ ! -d $dotsdir ]]; then
      echo "First time setup; cloning repo and putting it in the right places"
      mkdir $dotsdir
      git clone $githublink $dotsdir
      git remote set-url --push origin $githubssh
      chown -R $user:users $dotsdir
      rm -rf $nixosdir
      ln -s $dotsdir $nixosdir
    fi
  '';
  };
}
