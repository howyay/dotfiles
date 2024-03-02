{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-software-center = {
      url = "github:snowfallorg/nix-software-center";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ollama-nix = {
      url = "github:havaker/ollama-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, lanzaboote, ... }@inputs: 
  let
    allSystems = [ "x86_64-linux" ];
    myPkgs = system: (import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      #config.permittedInsecurePackages = [
      #  "openssl-1.1.1w"
      #];
      overlays = [ (import ./overlays.nix)];
    });
    forSystems = systems: function:
      nixpkgs.lib.genAttrs systems (system:
        function (myPkgs system)
      );
    myHome = {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.haoye = import ./home.nix;
    };
  in {
    homeConfigurations = forSystems allSystems (pkgs: 
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      }
    );
    nixosConfigurations.gristle = nixpkgs.lib.nixosSystem {
      inherit (myPkgs "x86_64-linux") pkgs;
      specialArgs = { inherit inputs; };
      modules = [ 
        home-manager.nixosModules.home-manager myHome
        lanzaboote.nixosModules.lanzaboote
        ./nixos/common.nix
        ./nixos/gristle.nix
        ./nixos/nvidia.nix
        #./nixos/paperless.nix
      ];
    };
    nixosConfigurations.backyard = nixpkgs.lib.nixosSystem {
      inherit (myPkgs "x86_64-linux") pkgs;
      specialArgs = { inherit inputs; };
      modules = [
        home-manager.nixosModules.home-manager myHome
        ./nixos/backyard.nix
        ./nixos/common.nix
      ];
    };
    devShells = forSystems allSystems (pkgs: {
      rstudio = import ./devShells/rstudio.nix { inherit pkgs; };
      vulkan = import ./devShells/vulkan.nix { inherit pkgs; };
      ml = import ./devShells/ml.nix { inherit pkgs; };
    });
  };
}
