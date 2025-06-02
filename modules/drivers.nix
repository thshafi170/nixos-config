{ self, config, pkgs, lib, ... }:

{
  services = {
    hardware.bolt.enable = true;
    libinput.enable = true;
    "06cb-009a-fingerprint-sensor" = {
      enable = true;
      backend = "python-validity";
    };
  };

  systemd.services.python3-validity-suspend-hotfix = {
    after = [
      "hibernate.target"
      "hybrid-sleep.target"
      "suspend.target"
      "suspend-then-hibernate.target"
    ];

    wantedBy = [
      "hibernate.target"
      "hybrid-sleep.target"
      "suspend.target"
      "suspend-then-hibernate.target"
    ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${config.systemd.package}/bin/systemctl --no-block restart python3-validity.service open-fprintd.service";
    };
  };


  security = {
    pam.services = {
      #login.fprintAuth = true;
      sudo.fprintAuth = true;
      kde-fingerprint.fprintAuth = true;
    };
    tpm2.enable = true;
  };

  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        libva
        mesa
        intel-compute-runtime-legacy1
        intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl
        vulkan-loader
        vulkan-extension-layer
        vulkan-validation-layers
      ];
      extraPackages32 = with pkgs.driversi686Linux; [
        mesa
        intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl
      ];
    };
    sensor.iio.enable = true;
  };

environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  environment.systemPackages = with pkgs; [
    ((ffmpeg-full.override {
      withUnfree = true;
      withOpengl = true;
    }).overrideAttrs (_: {
      doCheck = false;
    }))
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    gst_all_1.gst-vaapi
    iio-sensor-proxy
    intel-media-sdk
    lm_sensors
    openh264
  ];
}
