{ pkgs, ... }:

{
  services.displayManager = {
    # defaultSession = "hyprland";
    sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "breeze";
      extraPackages = with pkgs; [
        kdePackages.plasma-desktop
      ];
    };
  };
  environment.systemPackages = with pkgs; [
    kdePackages.plasma-desktop
  ];
}
