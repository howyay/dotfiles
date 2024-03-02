#{pkgs, ...}: {
#mods = 
final: prev: {
  gnome = prev.gnome // {
    gnome-software = prev.gnome.gnome-software.overrideAttrs (old: {
      buildInputs = old.buildInputs ++ [ prev.glib-networking ];
      shellHook = ''
        export GIO_MODULE_DIR=${prev.glib-networking}/lib/gio/modules/
      '';
    });
  };
  linuxPackages_zen = prev.linuxPackages_zen.extend(lpfinal: lpprev: {
    xone = prev.linuxPackages_zen.xone.overrideAttrs (old : {
      version = "unstable";
      src = prev.fetchFromGitHub {
        owner = "medusalix";
        repo = "xone";
        rev = "d93b4d5f238c8bd0ad1a885695071b49ca6739fa";
        #hash = "";
        hash = "sha256-+eCqzf260h3aWYDR37XPW2l4022hZDygJ5KMtpAa7JQ";
      };
      patches = [];
    });
  });
  #python3 = prev.python3.override {
  #  packageOverrides = lpfinal: lpprev: {
  #    httpx-socks = lpprev.httpx-socks.override {
  #      buildPythonPackage = args: lpprev.buildPythonPackage (args // {
  #        version = "0.8.1";
  #        src = prev.fetchFromGitHub {
  #          owner = "romis2012"; 
  #          repo = "httpx-socks";
  #          rev = "refs/tags/v0.8.1";
  #          hash = "sha256-L2nyVADDjPrHwhZRm+RAvfBdpP9sIvc9cakDiLVA7xw=";
  #        };
  #      });
  #    };
  #  };
  #};
  nwg-look = prev.nwg-look.override {
    buildGoModule = args: prev.buildGoModule ( args // {
      version = "v0.2.6";
      src = prev.fetchFromGitHub {
        owner = "nwg-piotr";
        repo = "nwg-look";
        rev = "v0.2.6";
        hash = "sha256-kOoYhJKt7/BsQ0/RuVhj0bWnX9GU8ET3MSq6NMCOw5E=";
      };
      vendorHash = "sha256-V0KXK6jxBYI+tixBLq24pJJcnu4gDF6nfyns2IBTss4=";
    });
  };
  swayosd = prev.swayosd.overrideAttrs (old: rec{
    buildInputs = old.buildInputs ++ [ prev.sassc ];
    version = "unstable-2023-12-10";
    src = prev.fetchFromGitHub {
      owner = "ErikReider";
      repo = "SwayOSD";
      rev = "a0709bcd89d6ca19889486972bac35e69f1fa8e4";
      hash = "sha256-3NJHZv4Ed7haUUmE9JV9Yl4rRnJlPqQFv53Xuw0q+IY=";
    };
    cargoDeps = prev.rustPlatform.fetchCargoTarball {
      inherit src;
      name = "${prev.swayosd.pname}-${version}";
      hash = "sha256-3qKbQev+EwQgcEHbGMAQSf6buFrrj3Z1msmdQE2i6EA=";
    };
  });
  #rstudio = prev.rstudio.overrideAttrs (old: {
  #  version = "2023.12.0+369";
  #  src = prev.fetchFromGitHub {
  #    owner = "rstudio";
  #    repo = "rstudio";
  #    #rev = "v2023.09.1+494";
  #    rev = "4da58325ffcff29d157d9264087d4b1ab27f7204";
  #    #rev = "v${final.rstudio.version}";
  #    hash = "sha256-ecMzkpHazg8jEBz9wh8hqRX2UdziOC8b6F+3xxdugy0=";
  #  };
  #});
}
#}
