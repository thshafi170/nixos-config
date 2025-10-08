{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.openbangla-keyboard;
in

{
  options = {
    services.openbangla-keyboard = {
      enable = mkEnableOption "OpenBangla Keyboard";

      enableFcitx5 = mkOption {
        type = types.bool;
        default = true;
        description = "Enable Fcitx5 support for OpenBangla Keyboard";
      };

      enableIbus = mkOption {
        type = types.bool;
        default = false;
        description = "Enable IBus support for OpenBangla Keyboard";
      };
    };
  };

  config = mkIf cfg.enable {
    # Add assertion to prevent both being enabled
    assertions = [
      {
        assertion = !(cfg.enableFcitx5 && cfg.enableIbus);
        message = "Cannot enable both Fcitx5 and IBus for OpenBangla Keyboard";
      }
    ];

    # Install the custom openbangla-keyboard package
    environment.systemPackages = with pkgs; [
      openbangla-keyboard-develop
    ];

    # Add to existing input method configuration
    i18n.inputMethod = {
      fcitx5.addons = mkIf cfg.enableFcitx5 (with pkgs; [
        fcitx5-openbangla-keyboard-develop
      ]);

      ibus.engines = mkIf cfg.enableIbus (with pkgs.ibus-engines; [
        openbangla-keyboard-develop
      ]);
    };

    # Set environment variables based on which input method is enabled
    environment.variables = mkMerge [
      (mkIf cfg.enableFcitx5 {
        GTK_IM_MODULE = "fcitx";
        QT_IM_MODULE = "fcitx";
        XMODIFIERS = "@im=fcitx";
      })
      (mkIf cfg.enableIbus {
        GTK_IM_MODULE = "ibus";
        QT_IM_MODULE = "ibus";
        XMODIFIERS = "@im=ibus";
      })
    ];
  };
}