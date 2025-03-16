{ pkgs, ... }:

{
  services.displayManager = {
    # defaultSession = "hyprland";
    sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "sddm-astronaut-theme";
      extraPackages = with pkgs; [
        kdePackages.qtsvg
        kdePackages.qt5compat
        kdePackages.qtmultimedia
      ];
    };
  };
  environment.systemPackages = with pkgs; [
    sddm-astronaut
    kdePackages.qtmultimedia
  ];
}
