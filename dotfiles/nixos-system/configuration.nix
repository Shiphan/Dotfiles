# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking = {
    hostName = "nixos-laptop"; # Define your hostname.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
  };

  time.timeZone = "ROC";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  services = {
    gvfs.enable = true;
    # desktopManager.plasma6.enable = true;
    blueman.enable = true;

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

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
    "steam-original"
    "steam-run"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # nix things
    home-manager
    nix-init

    # dev tools
    vim
    git

    # langs
    gcc
    rustc
    cargo
    go
    openjdk
    lua
    python3

    # cli tools
    tree
    jq
    socat
    ffmpeg
    wget
    glib
    gnumake
    unzip
    ripgrep

    # cli not tools
    sl
    cmatrix
    figlet
    fastfetch
  ];
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  programs = {
    zsh = {
      enable = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
    };

    steam = {
      enable = true;
      # remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # mtr.enable = true;
    ssh = {
      startAgent = true;
    };
    gnupg.agent = {
      enable = true;
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
  system.copySystemConfiguration = false;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how to actually do that.
  system.stateVersion = "24.05"; # Do NOT change this value.
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
}
