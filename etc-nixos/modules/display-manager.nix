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
      extraPackages = with pkgs; [
        kdePackages.qtmultimedia
      ];
    };
  };
  environment.systemPackages = with pkgs; [
    (sddm-astronaut.override {
      embeddedTheme = "pixel_sakura";
    })
    # catppuccin-sddm
    kdePackages.breeze
  ];
  # Remember last session for each user
  services.accounts-daemon.enable = true;
}
