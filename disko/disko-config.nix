{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/vdb";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                extraFormatArgs = ["--pbkdf argon2id -c serpent-xts-plain64 -h sha-512"];
                settings = {
                  # if you want to use the key for interactive login be sure there is no trailing newline
                  # for example use `echo -n "password" > /tmp/secret.key`
                  # keyFile = "/tmp/secret.key";
                  allowDiscards = true;
                };
                # additionalKeyFiles = ["/tmp/additionalSecret.key"]; https://github.com/nix-community/disko/issues/289
                content = {
                  type = "lvm_pv";
                  vg = "pool";
                };
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "30%";
            content = {
              type = "filesystem";
              format = "btrfs";
              mountpoint = "/";
              extraArgs = ["-f"];
              };
            };
          home = {
            size = "30%";
            content = {
              type = "filesystem";
              format = "btrfs";
              mountpoint = "/home";
              extraArgs = ["-f"];
              };
            };
          var = {
            size = "20%";
            content = {
              type = "filesystem";
              format = "btrfs";
              mountpoint = "/var";
              extraArgs = ["-f"];
              };
            };
          tmp = {
            size = "10%";
            content = {
              type = "filesystem";
              format = "btrfs";
              mountpoint = "/tmp";
              extraArgs = ["-f"];
              };
            };
          swap = {
            size = "1G";
            content = {
              type = "swap";
              discardPolicy = both;
            };
          };
        };
      };
    };
  };
}
