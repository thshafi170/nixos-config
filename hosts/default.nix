{ config, pkgs, lib, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../modules/default.nix
      ../users/default.nix
    ];

  networking.hostName = "X1-Yoga-2nd";

  time = {
    timeZone = "Asia/Dhaka";
    hardwareClockInLocalTime = false;
  };

  console = {
    packages = with pkgs; [
      pkgs.terminus_font
    ];
    font = "ter-122n";
    keyMap = "us";
  };

  fonts = {
    fontDir = {
      enable = true;
      decompressFonts = true;
    };
    fontconfig = {
      #enable = true;
      useEmbeddedBitmaps = true;
    };
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      nerd-fonts.meslo-lg
      liberation_ttf
      fira-code
      fira-code-symbols
      terminus_font
      lohit-fonts.bengali
      dejavu_fonts
    ];
  };

  services = {
    flatpak.enable = true;
    fstrim.enable = true;
    power-profiles-daemon.enable = true;
    btrfs.autoScrub.enable = true;
    fwupd.enable = true;
    irqbalance.enable = true;
    udisks2.enable = true;
    dbus.implementation = "broker";
  };

  systemd = {
    user.extraConfig = "DefaultLimitNOFILE=128000";
    services = {
      nix-daemon = {
        environment.TMPDIR = "/var/tmp";
      };
      flatpak-repo = {
        wantedBy = [ "multi-user.target" ];
        path = [ pkgs.flatpak ];
        script = ''
          flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
        '';
      };
    };
  };
  
  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.lix;
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "shafael170" ];
      substituters = [
        "https://cache.nixos.org"
        "https://chaotic-nyx.cachix.org"
        "https://nix-community.cachix.org"
        "https://an-anime-team.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "an-anime-team.cachix.org-1:nr9QXfYG5tDXIImqxjSXd1b6ymLfGCvviuV8xRPIKPM="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  system.stateVersion = "25.05";

}
