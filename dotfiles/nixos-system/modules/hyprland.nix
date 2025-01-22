{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.systemPackages = with pkgs; [
    hyprpolkitagent
    xdg-desktop-portal-hyprland
    wl-clipboard
    pulseaudio
    kitty
  ];
}
