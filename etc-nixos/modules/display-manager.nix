{ pkgs, ... }:

{
  services.displayManager = {
    sddm = {
      enable = true;
      wayland = {
        enable = true;
        compositor = "weston";
      };
      theme = "sddm-astronaut-theme";
      settings = {
        Theme.CursorTheme = "Breeze_Light";
      };
    };
  };
  environment.systemPackages = with pkgs; [
    # kdePackages.plasma-desktop
    # catppuccin-sddm
    (sddm-astronaut.override {
      embeddedTheme = "pixel_sakura";
    })
    kdePackages.qtmultimedia
    kdePackages.breeze
  ];
}
