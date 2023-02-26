{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: let
  isDesktop = builtins.readDir /sys/class/power_supply == {};
in {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  boot = {
    cleanTmpDir = true;

    extraModprobeConfig =
      if builtins.hasAttr "hid_apple" (builtins.readDir /sys/module)
      then ''
        options hid_apple fnmode=2
        options hid_apple swap_opt_cmd=1
        options hid_apple swap_fn_leftctrl=1
      ''
      else "";

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = isDesktop;
      grub =
        if isDesktop
        then {enable = false;}
        else {
          enable = true;
          version = 2;
          device = "nodev";
          efiSupport = true;
          enableCryptodisk = true;
        };
    };

    initrd = {
      luks.devices =
        if isDesktop
        then {}
        else {
          crypted = {
            device = "/dev/disk/by-label/crypted";
            preLVM = true;
          };
        };
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      kernelModules = ["dm-snapshot"];
    };
    kernelModules = ["kvm-intel" "wl" "v4l2loopback"];
    extraModulePackages = [
      config.boot.kernelPackages.broadcom_sta
      config.boot.kernelPackages.v4l2loopback
    ];
  };

  environment.systemPackages = [pkgs.linuxPackages.v4l2loopback];

  fileSystems."/" = {
    device = "/dev/disk/by-label/root";
    fsType = "ext4";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/home";
    fsType = "ext4";
  };

  /*
   fileSystems."/var" = {
     device = "/dev/disk/by-label/var";
     fsType = "ext4";
   };
   */

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  swapDevices = [
    {device = "/dev/disk/by-label/swap";}
  ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
