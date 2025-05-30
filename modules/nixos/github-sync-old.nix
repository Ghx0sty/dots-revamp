{ config, lib, pkgs, ... }:

{
  system.activationScripts.githubSync = {
    text = ''
    export PATH=${pkgs.git}/bin:/run/wrapper/bin:$PATH
    echo "Syncing /etc/nixos to GitHub..."
    cd /etc/nixos
    su - matt <<'EOF'
      git add *
      git commit -S -m "Testing automation"
      git push
  EOF
  '';
  };
}
