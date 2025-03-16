{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  environment.systemPackages = with pkgs; [
    hyprpolkitagent
    xdg-desktop-portal-hyprland
    wl-clipboard

    libnotify
    kitty
  ];
}
