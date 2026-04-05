{ pkgs, self-pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty
    wezterm
    alacritty
    # ghostty

    rofi
    hyprlauncher
    pulseaudio
    pwvucontrol
    hyprpwcenter
    networkmanagerapplet
    better-control

    vlc
    nautilus
    gnome-system-monitor
    loupe
    kdePackages.dolphin
    kdePackages.gwenview # image viewer
    kdePackages.kalk
    kdePackages.qtwayland
    kdePackages.qtsvg

    eww
    quickshell
    (hyprlock.overrideAttrs (previousAttrs: {
      patches = (previousAttrs.patches or [ ]) ++ [
        # Add support for mixed percentage/pixel in one axis of a layout value
        (fetchpatch2 {
          url = "https://github.com/Shiphan/hyprlock/commit/d9e53881e729a6be304ab5b30018bd5124306e70.patch";
          hash = "sha256-UKal1aEnorjzCTroox0DCb+ZvcWHsFVy/vkZ5WDMMqQ=";
        })
      ];
    }))
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
