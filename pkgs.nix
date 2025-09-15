{ 
  outputs 
}:
{
  nixpkgs = {
    overlays = [ 
      outputs.overlays.unstable-packages 
      outputs.overlays.additions
      # self.overlays.modifications
    ];
    config.allowUnfree = true;
  };
}
