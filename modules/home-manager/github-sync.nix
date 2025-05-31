{ config, lib, pkgs, ... }:

{
  home.activation.githubSync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export PATH=${pkgs.git}/bin:${pkgs.openssh}/bin:/run/wrapper/bin:$PATH
    dotsdir="$HOME/.nixdots"
    ssh -T git@github.com -o BatchMode=yes

    authcheck=$(ssh -T git@github.com -o BatchMode=yes 2>&1)

    if [[ $authcheck == *Successfully* ]]; then
      echo "You're authed, nice!"
    else
      echo "You're not authenticated to Github!"
    fi
    # echo "Syncing dots to GitHub..."
    # git add *
    # git commit -m "Testing automation"
    # git push
  '';
}
