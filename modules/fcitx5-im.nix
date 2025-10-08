{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./openbangla-keyboard.nix
  ];

  # Enable OpenBangla Keyboard
  services.openbangla-keyboard = {
    enable = true;
    # Enable either Fcitx5 or IBus support, not both
    enableFcitx5 = true;
    enableIbus = false;
  };

  # Input method configuration with fcitx5
  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-material-color
          fcitx5-gtk
          fcitx5-anthy
          fcitx5-mozc
          fcitx5-skk
          fcitx5-m17n
          fcitx5-chinese-addons
        ];
      };
    };
  };

  # Additional packages that might be useful
  environment.systemPackages = with pkgs; [
    # Input method configuration tools
    fcitx5-configtool  # GUI configuration for Fcitx5
    # ibus-setup      # Uncomment if using IBus instead
  ];

}