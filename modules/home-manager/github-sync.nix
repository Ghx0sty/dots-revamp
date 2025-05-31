{ config, lib, pkgs, ... }:

{
  home.activation.githubSync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export PATH=${pkgs.git}/bin:${pkgs.openssh}/bin:/run/wrapper/bin:$PATH
    dotsdir="$HOME/.nixdots"
    cd $dotsdir

    set +e
    authcheck=$(ssh -T git@github.com -o BatchMode=yes -o StrictHostKeyChecking=accept-new 2>&1)

    if [[ $authcheck == *successfully* ]]; then
      echo "Syncing dots to GitHub..."

      dirty=$(git status --porcelain)

      if [[ -z $dirty ]]; then
        echo "Tree is not dirty, no commit made"
      else
        echo "Dirty tree, creating new commit"
        git add .
        git commit -m "Automated push"
      fi

      git fetch origin

      local=$(git rev-parse @)
      remote=$(git rev-parse @{u})
      base=$(git merge-base @ @{u})

      if [[ $local == $remote ]]; then
        echo "All up to date, skipping"
        exit 0
      elif [[ $local == $base ]]; then
        echo "Out of date! Pulling latest changes"
        git config pull.rebase false
        git pull
        # if [[ -z $dirty ]]; then
          # echo "Looks like you have no more changes to apply. Updated local successfully"
          # exit 0
        # fi
      elif [[ $remote == $base ]]; then
        echo "All clear, pushing newest change"
        # if [[ -z $dirty ]]; then
          # echo "It looks like you already got a commit, I'll just push it for you"
          # git push
          # exit 0
        # fi
      else
        echo "What happened? Commits diverged somehow. Fix that yourself, you're mucking about"
        exit 0
      fi

      # Note for later: figure out what's happening with the logic at -n $dirty

      git push
    else
      echo "You aren't authenticated to Github yet!"
      echo $authcheck
    fi
 '';
}
