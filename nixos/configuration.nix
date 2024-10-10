# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      default = "saved";
    };
  };

  networking = {
    hostName = "nixos-laptop"; # Define your hostname.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
  };

  time.timeZone = "ROC";

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      material-symbols
      (nerdfonts.override { fonts = [ "Noto" "JetBrainsMono" ]; })
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" "Noto Serif CJK" ];
        sansSerif = [ "Noto Sans" "Noto Sans CJK" ];
	monospace = [ "Noto Sans Mono" ];
      };
    };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      # enabled = "ibus";
      # ibus.engines = with pkgs.ibus-engines; [
      #   rime
      # ];
      # enabled = "fcitx5";
      # fcitx5.addons = with pkgs; [
      #   fcitx5-material-color
      #   fcitx5-chewing
      # ];
    };
  };
  # services.xserver.desktopManager.runXdgAutostartIfNone = true;

  console = {
    keyMap = "us";
    font = "ter-v16n";
    packages = with pkgs; [
      terminus_font
    ];
    # useXkbConfig = true; # use xkb.options in tty.
  };

  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    # desktopManager.plasma6.enable = true;

    # Enable CUPS to print documents.
    # printing.enable = true;

    # Enable sound.
    pipewire = {
      enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
    # Enable the OpenSSH daemon.
    openssh.enable = true;
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
        amdvlk
        mesa
        vdpauinfo
        libva-utils
      ];
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."shiphan" = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    # packages = with pkgs; [ ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    nix-init

    vim
    git

    gcc
    go
    lua

    jq
    socat
    wget

    xdg-desktop-portal-hyprland
    wl-clipboard
    pulseaudio

    sl
    cmatrix
    fastfetch

    btop
    radeontop
    nvtop
  ];
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

  };


  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how to actually do that.
  system.stateVersion = "24.05"; # Do NOT change this value.
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
}
