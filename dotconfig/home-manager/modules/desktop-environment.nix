{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty
    vlc
    nautilus
    rofi-wayland
    pavucontrol
    networkmanagerapplet

    eww
    hyprlock
    hyprpaper

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
