{ config, lib, pkgs, ... }:

{
  home.activation.pullSyncHome = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export PATH=${pkgs.git}/bin:$PATH

    # FIXME: Fill this out with your own link!
    # githublink="https://github.com/Ghx0sty/dots-revamp.git"
    githublink="git@github.com:Ghx0sty/dots-revamp.git"

    dotsdir="$HOME/.nixdots"
    nixosdir="/etc/nixos"
    if [[ ! -d $dotsdir ]]; then
      echo "First time setup; cloning repo and putting it in the right places"
      mkdir $dotsdir
      git clone $githublink $dotsdir
    fi
  '';
}
