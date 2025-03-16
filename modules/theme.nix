{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rose-pine-hyprcursor
  ];
  home.sessionVariables = {
    "HYPRCURSOR_THEME" = "rose-pine-hyprcursor";
    "HYPRCURSOR_SIZE" = 24;
  };
  home.pointerCursor = {
    name = "BreezeX-RosePine-Linux";
    size = 24;
    package = pkgs.rose-pine-cursor;
    gtk.enable = true;
    x11.enable = true;
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      # "org/gnome/desktop/wm/preferences".button-layout= "menu:close";
    };
  };
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
    gtk2.extraConfig = ''
      gtk-application-prefer-dark-theme = true;
    '';
    gtk3.extraConfig = {
      "gtk-application-prefer-dark-theme" = true;
      "gtk-decoration-layout" = "menu:close";
    };
    # FIXME: close button theme
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };
  qt = {
    enable = true;
    # platformTheme.name = "qtct";
    style = {
      name = "breeze";
      package = with pkgs; [
        # adwaita-qt
        # adwaita-qt6
        kdePackages.breeze
        # libsForQt5.breeze-qt5
      ];
    };
  };
}
