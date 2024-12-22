{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  boot = {
    tmp = {
      cleanOnBoot = true;
      useTmpfs = true;
    };

    # APPLE TODO
    #    extraModprobeConfig =
    #      if builtins.hasAttr "hid_apple" (builtins.readDir /sys/module)
    #      then ''
    #        options hid_apple fnmode=2
    #        options hid_apple swap_opt_cmd=1
    #        options hid_apple swap_fn_leftctrl=1
    #      ''
    #      else "";

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };

    initrd = {
      luks.devices.crypted = {
        device = "/dev/disk/by-label/crypted";
        preLVM = true;
      };
      availableKernelModules = [
        "xhci_pci"
        "nvme"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = ["dm-snapshot"];
    };
    # TODO
    #kernelModules = ["kvm-intel" "wl" "v4l2loopback"];
    kernelModules = ["kvm-intel"];
    extraModulePackages = [
      # TODO
      #config.boot.kernelPackages.broadcom_sta
      #config.boot.kernelPackages.v4l2loopback
    ];
  };

  # TODO
  #environment.systemPackages = [pkgs.linuxPackages.v4l2loopback];

  fileSystems."/" = {
    device = "/dev/disk/by-label/root";
    fsType = "ext4";
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-label/nix";
    fsType = "ext4";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/home";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  swapDevices = [
    {device = "/dev/disk/by-label/swap";}
  ];

  # TODO
  #powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
