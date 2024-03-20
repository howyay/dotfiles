{ pkgs, config, ... }:
{
  home.username = "haoye";
  home.homeDirectory = "/home/haoye";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    usbutils
    slurp
    nixfmt
    grimblast
    nixos-generators
    libnotify
    wl-clipboard
    glib
    nwg-look
    grim
    satty
    gtk3
    gjs
    r2modman
    xdg-utils
    python3
    samrewritten
    swww
    polychromatic
    vial
    qmk
    gnumake
    gcc-arm-embedded
    orca
    #davinci-resolve
    brightnessctl
    podman-compose
    inotify-tools
    dfu-util
    tor-browser
    doxygen
    graphviz
    nvtop
    fsearch
    wf-recorder
    rnote
    bun
    lzip
    xdg-ninja
    zotero
    jetbrains.dataspell
    conda
    kdePackages.kleopatra
    yubikey-manager-qt
    android-tools
    winetricks
    radicle-cli
    vesktop
    yubioath-flutter
    lazygit
    resources
    temurin-bin
    #gnome.adwaita-icon-theme
    #capitaine-cursors
    #adw-gtk3
  ];

  qt.enable = true;
  qt.platformTheme = "qtct";
  qt.style.name = "kvantum";

  programs.nushell.enable = true;
  #programs.nushell.extraConfig = ''
#let fish_completer = {|spans|
#  fish --command $'complete "--do-complete=($spans | str join " ")"'
#  | $"value(char tab)description(char newline)" + $in
#  | from tsv --flexible --no-infer
#}
#$env.config.completions.external = {
#    enable: true
#    completer: $fish_completer
#}
#'';
  #programs.carapace.enable = true;
  programs.vscode.enable = true;
  programs.fish.enable = true;
  programs.zoxide.enable = true;
  programs.git = {
    enable = true;
    lfs.enable = true;
  };
  programs.ripgrep.enable = true;
  programs.fuzzel.enable = true;
  programs.eza.enable = true;
  programs.starship.enable = true;
  programs.atuin = {
    enable = true;
    settings = {
      auto_sync = true;
    };
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [ gcc cargo libcxx ];
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [
      conform-nvim
      mason-nvim
    ];
  };

  #services.swayosd.enable = true; 
  services.syncthing.enable = true;
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
  
  xdg.userDirs.enable = true;
  xdg.mimeApps.enable=true;
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
    "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [ "org.libreoffice.LibreOffice.desktop" ];
    "x-scheme-handler/https" = [ "io.gitlab.librewolf-community.desktop" ];
    "x-scheme-handler/http" = [ "io.gitlab.librewolf-community.desktop" ];
    "x-scheme-handler/about" = [ "io.gitlab.librewolf-community.desktop" ];
    "x-scheme-handler/unknown" = [ "io.gitlab.librewolf-community.desktop" ];
    "text/html" = [ "io.gitlab.librewolf-community.desktop" ];
    "x-scheme-handler/ror2mm" = [ "r2modman.desktop" ];
  };

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    wezterm = {
      enable = true;
      source = ./.wezterm.lua;
      target = "./.wezterm.lua";
    };
    npmrc = {
      target = "${config.xdg.configHome}/npmrc";
      text = ''
      prefix=${config.xdg.dataHome}/npm                                                                                       
      cache=${config.xdg.cacheHome}/npm                                                                                       
      tmp=''${XDG_RUNTIME_DIR}/npm                                                                                        
      init-module=${config.xdg.configHome}/npm/config/npm-init.js
      '';
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    SUDO_EDITOR = "nvim";

    HISTFILE = "${config.xdg.stateHome}/bash_history"; #~/.bash_history
    CARGO_HOME = "${config.xdg.dataHome}/cargo"; #~/.cargo/
    #GNUPGHOME = "${config.xdg.dataHome}/gnupg"; #~/.gnupg/
    LESSHISTFILE = "${config.xdg.stateHome}/lesshst"; #~/.lesshst
    NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npmrc";
    XCURSOR_PATH = "${pkgs.capitaine-cursors}/share/icons";
    XCURSOR_THEME = "capitaine-cursors";
    #_JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.xdg.configHome}/java"; #~/.java/ doesnt necessarily work
    #GTK2_RC_FILES = "${config.xdg.configHome}/gtk-2.0/gtkrc"; #~/.gtkrc-2.0 nwg-look useless
    #CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv"; #~/.nv/ useless
  };

  };

  programs.home-manager.enable = true;
}
