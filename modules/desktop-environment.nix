{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty
    wezterm
    alacritty
    ghostty

    rofi-wayland
    pulseaudio
    pwvucontrol
    networkmanagerapplet

    vlc
    nautilus
    gnome-system-monitor
    loupe
    kdePackages.plasma-systemmonitor
    kdePackages.dolphin
    kdePackages.gwenview # image viewer
    kdePackages.qtwayland
    kdePackages.qtsvg

    eww
    hyprlock
    hyprpaper
    hyprsunset
    hyprpicker
    hyprsysteminfo
    hyprland-qt-support
    dunst
    adwaita-icon-theme

    hypridle
    grim
    slurp
    cliphist
    playerctl
    brightnessctl
    (callPackage ../pkgs/snackdaemon.nix { })
  ];
}
