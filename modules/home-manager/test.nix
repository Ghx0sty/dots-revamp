{ config, lib, pkgs, ... }:

{
  home.activation.githubSync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    dotsdir="$HOME"
    user="$USER"

    echo "Trying out some fun stuff!"
    echo "My dir: $dotsdir"
    echo "My user: $user"
    touch $dotsdir/hello.txt
    echo "Try to check out hello.txt"
  '';
}
