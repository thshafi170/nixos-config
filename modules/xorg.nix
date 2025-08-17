{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.xserver = {
    enable = false;
    wacom.enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
    excludePackages = with pkgs; [
      xterm
    ];
  };

}
