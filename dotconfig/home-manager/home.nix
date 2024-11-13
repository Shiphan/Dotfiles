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

  home.pointerCursor = {
    name = "Adwaita";
    size = 24;
    package = pkgs.adwaita-icon-theme;
    gtk.enable = true;
    x11.enable = true;
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-lua
      # fcitx5-tokyonight
      fcitx5-nord
      # (callPackage ./fcitx5-mcbopomofo.nix { })
      fcitx5-mcbopomofo
    ];
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "google-chrome"
    "discord"
    "davinci-resolve"
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    kitty
    firefox
    /*
    firefox-beta
    firefox-beta-unwrapped
    firefox-devedition
    firefox-devedition-unwrapped
    (runCommand "firefox-beta" { } ''
      mkdir -p $out/bin
      ln -s ${pkgs.firefox-beta}/bin/firefox-beta $out/bin/firefox-beta
      ln -s ${pkgs.firefox-beta}/share $out/share
    '')
    */
    (runCommand "firefox-devedition" { } ''
      mkdir -p $out/bin
      ln -s ${pkgs.firefox-devedition}/bin/firefox-devedition $out/bin/firefox-devedition
      ln -s ${pkgs.firefox-devedition}/share $out/share
    '')
    args.firefox.packages.${pkgs.system}.firefox-nightly-bin
    chromium
    google-chrome
    nautilus
    loupe
    totem
    kdePackages.dolphin
    kdePackages.qtwayland
    kdePackages.qtsvg
    blender
    gimp
    krita
    obs-studio
    vscodium
    libreoffice
    networkmanagerapplet

    qemu
    OVMF
    swtpm

    discord
    davinci-resolve

    arduino-ide
    arduino-cli
    yt-dlp
    nodejs

    btop
    radeontop
    # nvtop

    grim
    slurp
    cliphist
    libnotify
    dunst
    eww
    playerctl
    brightnessctl
    rofi-wayland
    pavucontrol
    networkmanagerapplet

    hyprlock
    hypridle
    hyprpaper
    (callPackage ./snackdaemon.nix { })
    (callPackage ./wdi.nix { })

    vimPlugins.lazy-nvim

    # lsp
    clang-tools
    rust-analyzer
    gopls
    jdt-language-server
    kotlin-language-server
    pyright
    postgres-lsp
    arduino-language-server
    bash-language-server
    nil
    nixd
    hyprls
    nodePackages.vscode-json-languageserver
    # html
    # cssls
    htmx-lsp
    templ
    svelte-language-server
    lua-language-server
    stylua
  ];

  xdg.enable = true;

  xdg.desktopEntries = {
    /*
    "firefox-nightly" = {
      name = "Firefox Nightly";
      exec = "${args.firefox.packages.${pkgs.system}.firefox-nightly-bin.unwrapped}/bin/firefox-nightly --name firefox-nightly %U";
      # icon = "firefox-nightly";
      icon = "${args.firefox.packages.${pkgs.system}.firefox-nightly-bin}/share/icons/hicolor/128x128/apps/firefox-nightly.png";
      # icon = "${args.firefox.packages.${pkgs.system}.firefox-nightly-bin.unwrapped}/share";
      categories = [ "Network" "WebBrowser" ];
      genericName = "Web Browser";
      type = "Application";
      mimeType = [ "text/html" "text/xml" "application/xhtml+xml" "application/vnd.mozilla.xul+xml" "x-scheme-handler/http" "x-scheme-handler/https" ];
      startupNotify = true;

      actions = {
        "new-private-window" = {
          name = "New Private Window";
          exec = "${args.firefox.packages.${pkgs.system}.firefox-nightly-bin.unwrapped}/bin/firefox-nightly --private-window %U";
        };
        "new-window" = {
          name= "New Window";
          exec = "${args.firefox.packages.${pkgs.system}.firefox-nightly-bin.unwrapped}/bin/firefox-nightly --new-window %U";
        };
        "profile-manager-window" = {
          name= "Profile Manager";
          exec= "${args.firefox.packages.${pkgs.system}.firefox-nightly-bin.unwrapped}/bin/firefox-nightly --ProfileManager";
        };
      };
    };
    */

    # FIXME: windows 11 vm not work
    "windows-11" = {
      name = "Windows 11";
      icon = "qemu";
      # icon = "${pkgs.qemu}/share/icons/hicolor/scalable/apps/qemu.svg";
      terminal = true;
      exec = "${pkgs.writeShellScript "qemu-windows-11" ''
        # cp -n ${pkgs.OVMF.fd}/FV/OVMF_CODE.fd ${config.home.homeDirectory}/.local/share/qemu-img/OVMF_VARS.fd
        # chmod +w ${config.home.homeDirectory}/.local/share/qemu-img/OVMF_VARS.fd

        swtpm socket --tpm2 --tpmstate dir=${config.home.homeDirectory}/.local/share/qemu-img/tpm --ctrl type=unixio,path=${config.home.homeDirectory}/.local/share/qemu-img/tpm/swtpm-sock &

        qemu-system-x86_64 \
          -monitor stdio \
          -enable-kvm \
          -cpu host \
          -vga qxl \
          -m 12G \
          -machine q35 \
          -device amd-iommu \
          -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
          -chardev socket,id=chrtpm,path=${config.home.homeDirectory}/.local/share/qemu-img/tpm/swtpm-sock \
          -tpmdev emulator,id=tpm0,chardev=chrtpm \
          -device tpm-tis,tpmdev=tpm0 \
          -boot d \
          -cdrom ${config.home.homeDirectory}/Downloads/Win10_22H2_Chinese_Traditional_x64v1.iso \
          ${config.home.homeDirectory}/.local/share/qemu-img/image_file_1

          # -boot menu=on \
          # -cdrom ${config.home.homeDirectory}/Downloads/Win11_24H2_Chinese_Traditional_x64.iso \
          # -cdrom ${config.home.homeDirectory}/Downloads/archlinux-2024.10.01-x86_64.iso \
          # -drive if=pflash,format=raw,readonly=on,file=/nix/store/18fwgvs3k4mkp8i8j53clr83787dfqwp-OVMF-202408-fd/FV/OVMF_CODE.fd \
          # -drive if=pflash,format=raw,file=${config.home.homeDirectory}/.local/share/qemu-img/OVMF_VARS.fd \

          # -cdrom ${config.home.homeDirectory}/Downloads/archlinux-2024.10.01-x86_64.iso \
          # -drive file=${config.home.homeDirectory}/.local/share/qemu-img/image_file_1,format=qcow2
      ''}";
    };
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      # "org/gnome/desktop/wm/preferences".button-layout= "menu:close";
    };
  };
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
    gtk2.extraConfig = ''
      gtk-application-prefer-dark-theme = true;
    '';
    gtk3.extraConfig = {
      "gtk-application-prefer-dark-theme" = true;
      "gtk-decoration-layout" = "menu:close";
    };
    # FIXME: close button theme
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "Adwaita";
      package = with pkgs; [
        adwaita-qt
        adwaita-qt6
      ];
    };
  };

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
    bash = {
      enable = true;
      enableCompletion = true;
      initExtra = ''
        PS1=' \[\e[0;38;2;180;200;220m\]\[\e[1;38;2;64;64;64;48;2;180;200;220m\]\u\[\e[0;38;2;64;64;64;48;2;180;200;220m\] @\h \[\e[0;38;2;20;44;68;48;2;180;200;220m\]\[\e[1;38;2;180;200;220;48;2;20;44;68m\]\W $(if [ -d .git ]; then echo " "; else echo "󰉋 "; fi)\[\e[0;38;2;20;44;68;48;2;180;200;220m\]\[\e[1;38;2;64;64;64;48;2;180;200;220m\] \$\[\e[0;38;2;180;200;220m\]\[\e[0m\] '

        wdi() {
            if [[ $# -le 1 ]]; then
                dir=$(wtdwi "$1")
                [[ $? -eq 0 ]] && cd "$dir"
            else
                echo "too many arguments"
            fi
        }

        echo
        figlet " NixOS $(date +"%I:%M %p")"
        echo
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
      initExtra = ''
        zstyle ':completion:*' menu select
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

        bindkey "^[OA" history-beginning-search-backward
        bindkey "^[[A" history-beginning-search-backward
        bindkey "^[OB" history-beginning-search-forward
        bindkey "^[[B" history-beginning-search-forward

        setopt PROMPT_SUBST
        PROMPT=' %F{#b4c8dc}%B%F{#404040}%K{#b4c8dc}%n%b @%M %F{#142c44}%B%F{#b4c8dc}%K{#142c44}%~%b%F{#142c44}%K{#b4c8dc}%B%F{#404040} $(git status &> /dev/null; if [ $? -eq 0 ]; then echo " "; else echo "󰉋 "; fi)$(git branch --show-current 2> /dev/null)%b%F{#b4c8dc}%k%f
         %(!.#.$) '

        wdi() {
            if [[ $# -le 1 ]]; then
                dir=$(wtdwi "$1")
                [[ $? -eq 0 ]] && cd "$dir"
            else
                echo "too many arguments"
            fi
        }

        echo
        figlet " NixOS $(date +"%I:%M %p")"
        echo
      '';
    };
  };
  home.shellAliases = {
    "ls" = "ls --color=auto";
    "grep" = "grep --color=auto";
    "ll" = "ls -lh";
    "lla" = "ls -lha";
    "lsa" = "ls -ha";
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

    /*
    "firefox-devedition-desktop-entry" = {
      source = "${pkgs.firefox-devedition}/share";
      target = ".local/share";
      recursive = true;
    };
    "firefox-beta-desktop-entry" = {
      source = "${pkgs.firefox-beta}";
      target = ".nix-profile/share";
      recursive = true;
    };
    */
  };
    /*
  } // (
  let
    recursive = a: lib.concatMapAttrs (_: value:
      if (builtins.readFileType value.source) == "directory" then
        recursive (builtins.mapAttrs (name: _: { source = "${value.source}/${name}"; target = "${value.target}/${name}"; }) (builtins.readDir value.source))
      else
        { ${value.target} = { source = value.source; }; }
      ) a;
  in
    recursive {
      "firefox-devedition-desktop-entry" = {
        source = "${pkgs.firefox-devedition}/share";
        target = ".local/share";
      };
    }
  );
  */

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
