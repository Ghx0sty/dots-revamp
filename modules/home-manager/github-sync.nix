{ config, lib, pkgs, ... }:

{
  home.activation.githubSync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export PATH=${pkgs.git}/bin:${pkgs.openssh}/bin:/run/wrapper/bin:$PATH
    dotsdir="$HOME/.nixdots"

    set +e
    authcheck=$(ssh -T git@github.com -o BatchMode=yes 2>&1)
    set -e

    if [[ $authcheck == *successfully* ]]; then
      echo "Syncing dots to GitHub..."

      git fetch origin &>/dev/null

      local=$(git rev-parse @)
      remote=$(git rev-parse @{u})
      base=$(git merge-base @ @{u})

      if [[ $local == $remote ]]; then
        echo "All up to date, skipping"
        exit 0
      elif [[ $local == $base ]]; then
        echo "Out of date! Pulling latest changes and merging"
        git config pull.rebase false
        git pull
      elif [[ $remote == $base ]]; then
        echo "Pushing onto repo"
      else
        echo "What happened? Commits diverged somehow. Fix that yourself, you're mucking about"
        exit 0
      fi

      git add .
      git commit -m "Testing automation"
      git push
    else
      echo "You aren't authenticated to Github yet!"
      echo $authcheck
    fi
 '';
}
