{ pkgs, ... }:
#use overlay
with pkgs;
let 
  myRStudio = rstudioWrapper.override{ packages = with rPackages; [ tidyverse xml2 ]; };
in mkShell {
  buildInputs = [
    myRStudio
    #hello-unfree
  ];
}
