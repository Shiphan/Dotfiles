{ pkgs, self-pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty
    wezterm
    alacritty
    # ghostty

    rofi
    pulseaudio
    pwvucontrol
    networkmanagerapplet
    better-control

    vlc
    nautilus
    gnome-system-monitor
    loupe
    kdePackages.plasma-systemmonitor
    kdePackages.dolphin
    kdePackages.gwenview # image viewer
    kdePackages.kalk
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
    self-pkgs.snackdaemon
  ];
}
