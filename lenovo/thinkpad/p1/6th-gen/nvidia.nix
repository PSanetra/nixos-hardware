{ lib, ... }:
{
  hardware.nvidia = {

    modesetting.enable = true;
    powerManagement.enable = lib.mkDefault true;

    # finegrained needs to be disabled with prime.sync.enable = true
    powerManagement.finegrained = lib.mkDefault false;

    prime = {
      # "offload.enable = true" and "reverseSync.enable = true" both have noticable worse performance than sync.enable = true; (e.g. compare with webcam in chrome)
      sync.enable = lib.mkDefault true;

      # Bus ID of the Intel GPU.
      intelBusId = lib.mkDefault "PCI:0:2:0";
      # Bus ID of the NVIDIA GPU.
      nvidiaBusId = lib.mkDefault "PCI:1:0:0";
    };

    open = lib.mkDefault false;

    nvidiaSettings = lib.mkDefault true;

    package = lib.mkDefault config.boot.kernelPackages.nvidiaPackages.stable;

  };

  # Hardware acceleration
  hardware.opengl = {
    enable = lib.mkDefault true;

    # Vulkan
    driSupport = lib.mkDefault true;
    driSupport32Bit = lib.mkDefault true;

    # VA-API
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
    ];
  };

  imports = [
    ../../../../common/gpu/nvidia
  ];

}
