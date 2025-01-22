{ config, lib, pkgs, ... }@args:

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
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-lua
      # fcitx5-tokyonight
      fcitx5-nord
      (callPackage ./pkgs/fcitx5-mcbopomofo.nix { })
      #fcitx5-mcbopomofo
    ];
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "google-chrome"
    "obsidian"
    "discord"
    "davinci-resolve"
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    firefox
    chromium
    google-chrome
    loupe
    kdePackages.dolphin
    kdePackages.qtwayland
    kdePackages.qtsvg
    blender
    gimp
    krita
    obs-studio
    vscodium
    jetbrains.idea-community
    libreoffice

    obsidian
    discord
    # davinci-resolve

    arduino-ide
    arduino-cli
    yt-dlp
    nodejs
    gradle

    btop
    radeontop
    nvtopPackages.amd

    (callPackage ./pkgs/wdi.nix { })
    cloc
  ];

  xdg.enable = true;

  services = {
    blueman-applet.enable = true;
  };

  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      userEmail = "140245703+Shiphan@users.noreply.github.com";
      userName = "Shiphan";
    };
    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
    neovim = {
      enable = true;
    };
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
