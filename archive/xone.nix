{ pkgs, ... }: {
  #nixpkgs.overlays = [ (import ./ols.nix) ];
  #boot.blacklistedKernelModules = [ "xpad" "mt76x2u" ];
  #hardware.firmware = [ pkgs.xow_dongle-firmware ];
  #boot.extraModulePackages = [ pkgs.linuxPackages_zen.xone ];
  #environment.systemPackages = [ pkgs.hello-unfree ];
}
