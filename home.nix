{
  config,
  lib,
  pkgs,
  # firefox-nightly,
  stable-nixpkgs,
  self-pkgs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "shiphan";
  home.homeDirectory = "/home/shiphan";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-lua
        # fcitx5-tokyonight
        fcitx5-nord
        self-pkgs.fcitx5-mcbopomofo
        fcitx5-mcbopomofo
      ];
    };
  };

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "google-chrome"
      "obsidian"
      "discord"
      "android-studio-stable"
      # "davinci-resolve"
    ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    firefox
    # args.firefox-nightly.packages.${pkgs.system}.firefox-nightly
    chromium
    google-chrome

    kdePackages.filelight # check disk usage
    gparted

    blender-hip
    gimp3
    krita
    inkscape
    obs-studio
    kdePackages.kdenlive
    # davinci-resolve
    godot
    kicad
    stable-nixpkgs.legacyPackages."x86_64-linux".freecad-qt6
    # freecad-qt6
    openscad

    flatpak
    gnome-software
    kdePackages.discover

    libreoffice
    obsidian
    # logseq
    joplin-desktop
    xournalpp
    discord

    vscodium
    jetbrains.idea-community
    android-studio
    arduino-ide
    zed-editor

    # rustup
    lld
    podman-desktop
    podman-compose
    btop
    nvtopPackages.amd
    cloc
    arduino-cli
    yt-dlp
    nodejs
    gradle
    nushell
    inetutils
    # self-pkgs.wdi
    tmux
    zellij
    typst

    gemini-cli

    self-pkgs.googlesans-code
  ];

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      kdePackages.xdg-desktop-portal-kde
    ];
    config.common.default = [
      "hyprland"
      "gtk"
      "kde"
    ];
  };

  fonts.fontconfig.enable = true;

  services = {
    blueman-applet.enable = true;
    mpris-proxy.enable = true;
  };

  programs = {
    neovim.enable = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
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
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/shiphan/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
