{ config, lib, pkgs, ... }:

{
  home.activation.githubSync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    homedir="$HOME"
    user="$USER"

    echo "Trying out some fun stuff!"
    touch $dotsdir/hello.txt
    echo "My dir: $homedir" >> $dotsdir/hello.txt
    echo "My user: $user" >> $dotsdir/hello.txt
    echo "Try to check out hello.txt"
    id >> $dotsdir/hello.txt
    echo "My PATH: $PATH" >> $dotsdir/hello.txt
    echo "And what's $dotsdir"
  '';
}
