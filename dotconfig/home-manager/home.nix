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

    rust-analyzer
    gopls
    jdt-language-server
    kotlin-language-server
    pyright
    postgres-lsp
    bash-language-server
    nil
    nixd
    # hyprls
    # jsonls
    # html
    # cssls
    htmx-lsp
    templ
    svelte-language-server
    lua-language-server
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
      enableCompletion = true;
      shellAliases = {
        "ls" = "ls --color=auto";
        "grep" = "grep --color=auto";
        "ll" = "ls -lh";
        "lla" = "ls -lha";
      };
      initExtra = ''
        PS1=' \[\e[0;38;2;180;200;220m\]\[\e[1;38;2;64;64;64;48;2;180;200;220m\]\u\[\e[0;38;2;64;64;64;48;2;180;200;220m\] @\h \[\e[0;38;2;20;44;68;48;2;180;200;220m\]\[\e[1;38;2;180;200;220;48;2;20;44;68m\]\W $(if [ -d .git ]; then echo " "; else echo "󰉋 "; fi)\[\e[0;38;2;20;44;68;48;2;180;200;220m\]\[\e[1;38;2;64;64;64;48;2;180;200;220m\] \$\[\e[0;38;2;180;200;220m\]\[\e[0m\] '
      '';
    };
    readline = {
      enable = true;
      includeSystemConfig = true;
      variables = {
        "completion-ignore-case" = true;
      };
      bindings = {
        "\\e[A" = "history-search-backward";
        "\\e[B" = "history-search-forward";
      };
    };
    zsh = {
      enable = true;
      defaultKeymap = "viins";
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      plugins = [
        {
          name = "zsh-vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
      ];
      shellAliases = {
        "ls" = "ls --color=auto";
        "grep" = "grep --color=auto";
        "ll" = "ls -lh";
        "lla" = "ls -lha";
      };
      initExtra = ''
        setopt PROMPT_SUBST
        PROMPT=' %F{#b4c8dc}%B%F{#404040}%K{#b4c8dc}%n%b @%M %F{#142c44}%B%F{#b4c8dc}%K{#142c44}%1~%b $(if [ -d .git ]; then echo " "; else echo "󰉋 "; fi)%F{#142c44}%K{#b4c8dc} %B%F{#404040}%K{#b4c8dc}%(!.#.$)%b%F{#b4c8dc}%k%f '
      '';
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
