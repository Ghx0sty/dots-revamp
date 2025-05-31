{ config, lib, pkgs, ... }:

{
  home.activation.githubSync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export PATH=${pkgs.git}/bin:${pkgs.openssh}/bin:/run/wrapper/bin:$PATH
    dotsdir="$HOME/.nixdots"

    authcheck=$(ssh -T git@github.com -o BatchMode=yes 2>&1)

    echo $authcheck

    if [[ $authcheck == *successfully* ]]; then
      touch /home/matt/yes
    else
      touch /home/matt/no
    fi
    # echo "Syncing dots to GitHub..."
    # git add *
    # git commit -m "Testing automation"
    # git push
  '';
}
