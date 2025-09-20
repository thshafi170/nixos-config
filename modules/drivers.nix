{
  config,
  pkgs,
  ...
}:

{
  # Hardware services configuration
  services = {
    hardware.bolt.enable = true;
    libinput.enable = true;
    power-profiles-daemon.enable = true;
    "06cb-009a-fingerprint-sensor" = {
      enable = true;
      backend = "python-validity";
    };
  };

  # Suspend/resume hotfix for fingerprint sensor
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

  # Security configuration
  security = {
    pam = {
      services.sudo.fprintAuth = true;
      u2f.enable = true;
    };
    tpm2.enable = true;
  };

  # Package overrides for Intel hardware acceleration
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };

  # Hardware configuration
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    # Graphics acceleration
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
    opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
    sensor.iio.enable = true;
  };

  # Environment variables for graphics driver
  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

  # Media and hardware packages
  environment.systemPackages = with pkgs; [
    (
      (ffmpeg-full.override {
        withUnfree = true;
        withOpengl = true;
      }).overrideAttrs
      (_: {
        doCheck = false;
      })
    )
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    gst_all_1.gst-vaapi
    iio-sensor-proxy
    lm_sensors
    openh264
  ];
}
