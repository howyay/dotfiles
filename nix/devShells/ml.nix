{ pkgs, ... }:
#use overlay
with pkgs;
let 
in mkShell {
  buildInputs = [
    python3
    python3.pkgs.numpy
    python3.pkgs.pandas
    python3.pkgs.torchWithRocm
    python3.pkgs.torchvision
    python3.pkgs.torchaudio
    python3.pkgs.matplotlib
    #python3.pkgs.jupyter
    #python3.pkgs.notebook
    python3.pkgs.jupyterlab
    #python3.pkgs.jupyterlab-server
    #jupyter-all
  ];
}
