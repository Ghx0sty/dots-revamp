{ config, lib, pkgs, ... }:

{
  home.activation.githubSync = ''
    # TODO: Make sure you have done the following:
    # - Set your branch as main/origin
    # - Made your git push remote SSH based (git remote set-url --push git@github.com:your/repo.git)
    # - Authenticated to your Github via SSH
    # This script relies on SSH authentication and pushing to work.

    # FIXME: Install the two dependencies you see here!
    # - git
    # - openssh
    export PATH=${pkgs.git}/bin:${pkgs.openssh}/bin:/run/wrapper/bin:$PATH


    # FIXME: Change this if you have your dotfiles somewhere else!
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
        echo "Out of date! Pulling latest changes and merging if necessary"
        git config pull.rebase false
        git pull
      elif [[ $remote == $base ]]; then
        echo "All clear, pushing newest change"
      else
        # echo "What happened? Commits diverged somehow. Fix that yourself, you're mucking about"
        # exit 0
        echo "Looks like you've diverged a bit. Merging all changes, please double-check your git to make sure it's all good"
        git merge origin/main -m "Merged to main after diverging"
      fi

      git push
    else
      echo "You aren't authenticated to Github yet!"
      echo $authcheck
    fi
 '';
}
