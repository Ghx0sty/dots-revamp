# dots-revamp
Better nix dots

This is a fork of the below "starter config" made by Misterio77, credited here as neccessary;
https://github.com/Misterio77/nix-starter-configs

Using the "standard" preset

# Notes to self:
## Rough onboard architecture of the system
- Each new host must be defined in flake.nix
- Then the host must gain a host-specific config file from templates
- THIS IS TO BE PUT IN A WRAPPER SHELLSCRIPT (or nixos module if you're fancy)
- All should be configured except for the main system user (template-user fields)
- That will then be configured by a SECOND SHELLSCRIPT
- This script will either request either:
    - A new user be created (Uses template-user from home-manager/template)
    - An existing user to be used from the home-manager dir (Will be scanned)
- Disko will be configured manually and the first script will copy a default LUKS + BTRFS

## Onboarding summary;
- Two scripts control onboarding
    - One handles host creation
    - Other handles user selection + creation
- Users can be reused across hosts
- There is no base home.nix


# WIP Scratchpad:
## Refactoring of pkgs.nix
- Need to continue doing pkgs.nix and rubbing it out from the flake.nix
