final: prev: {
  # Custom openbangla-keyboard package - callPackage handles dependencies automatically
  openbangla-keyboard-develop = prev.callPackage ../pkgs/openbangla-keyboard {
    # Only specify the optional build flags, not the dependencies
    withFcitx5Support = true;
    withIbusSupport = true;
  };

  # Create fcitx5-specific variant
  fcitx5-openbangla-keyboard-develop = prev.callPackage ../pkgs/openbangla-keyboard {
    withFcitx5Support = true;
    withIbusSupport = false;
  };

  # Create ibus-specific variant  
  ibus-engines = prev.ibus-engines // {
    openbangla-keyboard-develop = prev.callPackage ../pkgs/openbangla-keyboard {
      withFcitx5Support = false;
      withIbusSupport = true;
    };
  };
}