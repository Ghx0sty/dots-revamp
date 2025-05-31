{ config, lib, pkgs, ... }:

{
  home.activation.pullSyncHome = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # TODO: Remember to install git. Also, this script makes your git remote SSH based!
    export PATH=${pkgs.git}/bin:$PATH

    # FIXME: Fill this out with your own link!
    githublink="https://github.com/Ghx0sty/dots-revamp.git"
    githubssh="git@github.com:Ghx0sty/dots-revamp.git"

    # FIXME: Also rename this if you want your dots elsewhere!
    dotsdir="$HOME/.nixdots"

    if [[ ! -d $dotsdir ]]; then
      echo "First time setup; cloning repo and putting it in the right places"
      mkdir $dotsdir
      git clone $githublink $dotsdir
      git remote set-url --push origin $githubssh
    fi
  '';
}
