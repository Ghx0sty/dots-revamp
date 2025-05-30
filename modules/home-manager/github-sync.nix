{ config, lib, pkgs, ... }:

{
  home.activation.githubSync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # export PATH=${pkgs.git}/bin:/run/wrapper/bin:$PATH
    # userdir=$(getent passwd 1000 | cut -d: -f6)
    dotsdir="$HOME/.nixdots"

    echo "Syncing dots to GitHub..."
    cd $dotsdir
    git add *
    git commit -m "Testing automation"
    git push
  '';
}
