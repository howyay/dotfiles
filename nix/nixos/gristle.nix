{ config, lib, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  networking.hostName = "gristle";

  boot.initrd.availableKernelModules =
    [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];

  boot.bootspec.enable = true;
  boot = {
    loader.systemd-boot.enable = lib.mkForce false;
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };

  
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/23708e9c-e747-4752-8c9a-b4b6663ce4ae";
    fsType = "btrfs";
  };

  fileSystems."/mnt/ext4dat" = {
    device = "/dev/disk/by-uuid/eac3393a-6dee-4b6b-9eb0-1fa501c42c24";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/E849-DDC0";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" "defaults" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/9b0815cf-77e7-4287-9be4-88c49fa0119d";
    fsType = "btrfs";
  };

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/5954ed20-2bc1-4424-9ad1-9fb63474a968";
      allowDiscards = true; # Used if primary device is a SSD
      preLVM = true;
    };
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp5s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
