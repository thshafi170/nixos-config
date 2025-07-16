{ config, pkgs, lib, ... }:

{
  boot = {
    # Plymouth boot splash configuration
    plymouth = {
      enable = true;
      theme = "bgrt";
    };

    # Boot loader configuration
    loader = {
      systemd-boot = {
        enable = true;
        editor = true;
        consoleMode = "auto";
        edk2-uefi-shell.enable = true;
      };
      efi.canTouchEfiVariables = true;
    };

    # Initial RAM disk configuration
    initrd = {
      systemd.tmpfiles.settings = {
        # Low latency settings for real-time applications
        "10-lowlatency" = {
          "/sys/class/rtc/rtc0/max_user_freq" = {
            w.argument = "128";
          };
          "/proc/sys/dev/hpet/max-user-freq" = {
            w.argument = "128";
          };
        };
      };
    };
  };
}
