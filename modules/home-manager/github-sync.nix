{ config, lib, pkgs, ... }:

{
  home.activation.githubSync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export PATH=${pkgs.git}/bin:${pkgs.openssh}/bin:/run/wrapper/bin:$PATH
    dotsdir="$HOME/.nixdots"

    set +e
    authcheck=$(ssh -T git@github.com -o BatchMode=yes 2>&1)
    set -e

    echo $authcheck

    if [[ $authcheck == *successfully* ]]; then
      echo "Works"
    else
      echo "You aren't authenticated to Github yet!"
    fi
    # echo "Syncing dots to GitHub..."
    # git add *
    # git commit -m "Testing automation"
    # git push
  '';
}
