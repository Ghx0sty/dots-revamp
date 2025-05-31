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
      dirty=$(git status --porcelain)

      if [[ $local == $remote ]]; then
        echo "All up to date, skipping"
        exit 0
      elif [[ $local == $base ]]; then
        echo "Out of date! Pulling latest changes"
        git config pull.rebase false
        git pull
        if [[ -z $dirty ]]; then
          echo "Looks like you have no more changes to apply. Updated local successfully"
          exit 0
      elif [[ $remote == $base ]]; then
        if [[ -z dirty ]]; then
          echo "It looks like you already got a commit, I'll just push it for you"
          git push
          exit 0
      else
        echo "What happened? Commits diverged somehow. Fix that yourself, you're mucking about"
        exit 0
      fi

      # Note for later: figure out what's happening with the logic at -n $dirty
      echo "Making fresh commit and pushing onto repo"

      git add .
      git commit -m "Automated push"
      git push
    else
      echo "You aren't authenticated to Github yet!"
      echo $authcheck
    fi
 '';
}
