{ config, lib, pkgs, ... }:

{
  home.activation.githubSync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    dotsdir="$HOME"
    user="$USER"

    echo "Trying out some fun stuff!"
    touch $dotsdir/hello.txt
    echo "My dir: $dotsdir" >> $dotsdir/hello.txt
    echo "My user: $user" >> $dotsdir/hello.txt
    echo "Try to check out hello.txt"
    id >> $dotsdir/hello.txt
    echo "My PATH: $PATH" >> $dotsdir/hello.txt
  '';
}
