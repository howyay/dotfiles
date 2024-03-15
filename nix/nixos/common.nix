{ pkgs, ... }: {
  imports = [ 
    ./packages.nix
  #  ../xone.nix 
    ../searx/searx.nix
  ];

#  home-manager.nixosModules.home-manager {
#    inherit config pkgs lib utils;
#    home-manager.useGlobalPkgs = true;
#    home-manager.useUserPackages = true;
#    home-manager.users.haoye = import ./home.nix;
#  }
  system.stateVersion = "23.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  boot.initrd.systemd.enableTpm2 = true;
  boot.initrd.systemd.enable = true;
  boot.initrd.clevis.enable = true;
  boot.initrd.clevis.devices.root.secretFile = "/etc/rootkey.jwe";
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelParams = [ "console=tty1"  ];
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = "\\xff\\xff\\xff\\xff\\x00\\x00\\x00\\x00\\xff\\xff\\xff";
    magicOrExtension = "\\x7fELF....AI\\x02";
  };

  zramSwap.enable = true;

  time.timeZone = "America/New_York";

  #i18n.defaultLocale = "en_US.UTF-8";
  #i18n.extraLocaleSettings = {
  #  LC_ADDRESS = "en_US.UTF-8";
  #  LC_IDENTIFICATION = "en_US.UTF-8";
  #  LC_MEASUREMENT = "en_US.UTF-8";
  #  LC_MONETARY = "en_US.UTF-8";
  #  LC_NAME = "en_US.UTF-8";
  #  LC_NUMERIC = "en_US.UTF-8";
  #  LC_PAPER = "en_US.UTF-8";
  #  LC_TELEPHONE = "en_US.UTF-8";
  #  LC_TIME = "en_US.UTF-8";
  #};

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-rime fcitx5-gtk ];
    fcitx5.waylandFrontend = true; 
  };

  #environment.sessionVariables.NAUTILUS_EXTENSION_DIR = "${config.system.path}/lib/nautilus/extensions-4";
  #environment.pathsToLink = [
  #  "/share/nautilus-python/extensions"
  #];
  #services.xserver = {
  #  enable = true;
    #layout = "us";
    #xkbVariant = "";
    #displayManager.gdm.enable = true;
    #desktopManager.gnome.enable = true;
  #  desktopManager.gnome.extraGSettingsOverridePackages = [pkgs.nautilus-open-any-terminal];
  #  desktopManager.gnome.sessionPath = [pkgs.nautilus-open-any-terminal];
  #};

  users.mutableUsers = false;
  users.users.root.hashedPassword = "!";
  users.users.haoye = {
    isNormalUser = true;
    description = "haoye";
    extraGroups = [ "docker" "networkmanager" "wheel" "openrazer" "dialout"];
    #packages = with pkgs; [ ];
    shell = pkgs.fish;
    hashedPassword = "$y$j9T$dL3z9UE9YIvdWQyidgM1K0$NNNIRmUftDMmCSgYjXW.jgRHOC8v9KkZ7mOC7hqYYd4";
  };

  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "qt";
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = true;

  virtualisation.waydroid.enable = true;
  virtualisation.docker = {
    enable = true;
    logDriver = "json-file";
  };
  virtualisation.podman = {
    enable = true;
    #dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  virtualisation.libvirtd.enable = true;
  #security.tpm2.enable = true;
  security.polkit.enable = true;
  security.rtkit.enable = true;
  security.pam.services.waylock = { };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.fish.enable = true;
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraEnv = {
        #MANGOHUD = true;
        #OBS_VKCAPTURE = true;
        #RADV_TEX_ANISO = 16;
        RADV_PERFTEST = "gpl";
      };
      extraLibraries = p: with p; [
        gtk3
        cairo
        gdk-pixbuf
        libxkbcommon
        libselinux
        nss
        atk
        steamtinkerlaunch
        yad
        unixtools.xxd
        xorg.xwininfo
        unzip
        xdotool
        xorg.xprop
        vkbasalt
        #openssl 
        #openssl_1_1
        #ncurses6
        #nghttp2 
        #libidn2 
        #rtmpdump 
        #libpsl 
        #curl 
        #krb5 
        #keyutils
        #libuuid
      ];
    };
  };
  programs.nm-applet.enable = true;
  programs.seahorse.enable = true;

  hardware.opentabletdriver.enable = true;
  hardware.gpgSmartcards.enable = true;
  hardware.openrazer.enable = true;
  hardware.xone.enable = true;
  hardware.keyboard.qmk.enable = true;
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.resolved.enable = true;
  services.ratbagd.enable = true;
  #services.ollama.enable = true;
  services.gnome.at-spi2-core.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.openssh.enable = true;
  services.cockpit.enable = true;
  services.upower.enable = true; #laptop battery
  services.tailscale = {
    enable = true;
    extraUpFlags = [ "--operator=haoye"];
  };
  services.flatpak.enable = true;
  services.udisks2.enable = true; #gnome-disks
  services.gvfs.enable = true; #nautilus trash
  services.udev.packages = with pkgs; [ vial via ];
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command =
          "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'Hyprland'";
      };
    };
    vt = 2;
  };

  qt = {
    enable = true;
    style = "kvantum";
  }; 

  systemd = {
    user.services.myGraphical = {
      wants = [ "graphical-session.target" ];
      wantedBy = [ "xdg-desktop-portal.service" ];
      after = [ "xdg-desktop-portal.service"];
      serviceConfig = {
          ExecStart = "${pkgs.gnome.gnome-software}/bin/gnome-software --gapplication-service";
      };
    };
    user.services.polkit-kde-authentication-agent-1 = {
      description = "polkit-kde-authentication-agent-1";
      wantedBy = [ "xdg-desktop-portal-hyprland.service" ];
      wants = [ "xdg-desktop-portal-hyprland.service" ];
      after = [ "xdg-desktop-portal-hyprland.service" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  xdg.portal = { # hyprland file picker
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    xdgOpenUsePortal = true;
  };
}
