{ config, pkgs, ... }: {
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

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    kitty
    firefox
    gnome.nautilus

    eww
    playerctl
    brightnessctl
    rofi-wayland
    pavucontrol
    networkmanagerapplet
    blueman
    power-profiles-daemon

    gh

    nodejs
    vscodium
    blender
    obs-studio
    discord

    hyprlock
    hypridle
    hyprpaper
    buildGoModule rec {
      pname = "snackdaemon";
      version = "0.3.0";

      src = fetchFromGitHub {
	owner = "Shiphan";
	repo = "snackdaemon";
	rev = "v${version}";
	hash = "sha256-TNJ+N19HM/RtLSsjIoq+YAyFlnHrNS3ec1PkgDBMPO8=";
      };

      vendorHash = null;

      ldflags = [ "-s" "-w" ];

      meta = with lib; {
	description = "Daemon for snackbar";
	homepage = "https://github.com/Shiphan/snackdaemon";
	license = licenses.mit;
	maintainers = with maintainers; [ ];
	mainProgram = "snackdaemon";
      };
    }
    rustPlatform.buildRustPackage rec {
      pname = "wdi";
      version = "unstable-2024-07-24";

      src = fetchFromGitHub {
	owner = "shiphan";
	repo = "wdi";
	rev = "87d1f5e40200bf63ce6c4722816db42d614e6f6a";
	hash = "sha256-lOK2r03phvJiiXw4UM50w7ps8aEr4qlirB60DZ7P75o=";
      };

      cargoHash = "sha256-Vk3ihpdtoh9rj7Bd5LYilSSJkd/fNSm3vfKVUUpgJ0Y=";

      meta = with lib; {
	description = "Walk through Directory with Interface";
	homepage = "https://github.com/shiphan/wdi.git";
	license = licenses.mit;
	maintainers = with maintainers; [ ];
	mainProgram = "wdi";
      };
    }
  ];

  # FIXME: theme prefer-dark
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "Adwaita";
      package = pkgs.adwaita-qt;
    };
  };
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita";
      package = pkgs.gnome.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
      # package = pkgs.gnome.gnome-themes-extra;
    };
  };

  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      # userName = "Shiphan";
      # userEmail = "140245703+Shiphan@user.noreply.github.com";
    };
    neovim = {
      enable = true;
    };
    bash = {
      enable = true;
    };
    zsh = {
      enable = true;
    };
    input = {
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
