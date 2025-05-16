{ config, pkgs, lib, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../modules
      ../users
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

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };

  systemd = {
    user.extraConfig = "DefaultLimitNOFILE=128000";
    services.nix-daemon = {
      environment.TMPDIR = "/var/tmp";
    };
  };

  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.lix;
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "shafael170" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  system.stateVersion = "25.05";

}
