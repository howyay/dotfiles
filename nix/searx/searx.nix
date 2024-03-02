{ pkgs, ... }:
let
  searxConfig = builtins.readFile ./settings.yml;
in 
{
  services.searx = {
    enable = true;
    settingsFile = pkgs.writeText "settings.yml" searxConfig; 
    environmentFile = "/home/haoye/dotfiles/nix/searx/env";
  };
}
