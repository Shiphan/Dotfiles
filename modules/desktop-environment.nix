{ pkgs, nixpkgs-latest, ... }:

{
  home.packages = with pkgs; [
    kitty
    wezterm
    vlc
    nautilus
    rofi-wayland
    pulseaudio
    # pwvucontrol
    (nixpkgs-latest.legacyPackages.x86_64-linux.pwvucontrol)
    networkmanagerapplet

    eww
    hyprlock
    hyprpaper
    hyprsunset

    hypridle
    grim
    slurp
    cliphist
    libnotify
    dunst
    playerctl
    brightnessctl
    (callPackage ../pkgs/snackdaemon.nix { })
  ];
}
