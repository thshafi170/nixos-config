{ self, config, pkgs, lib, ... }:

{
  boot = {
    plymouth = {
        enable = true;
        theme = "bgrt";
    };
    loader = {
      systemd-boot = {
        enable = true;
        editor = true;
        consoleMode = "auto";
        edk2-uefi-shell.enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
    initrd = {
      systemd.tmpfiles.settings = {
        "10-lowlatency" = {
          "/sys/class/rtc/rtc0/max_user_freq" = {
            w = {
              argument = "128";
            };
          };
          "/proc/sys/dev/hpet/max-user-freq" = {
            w = {
              argument = "128";
            };
          };
        };
      };
    };
  };
}
