{
  config,
  pkgs,
  kde-svg-cursor2hyprcursor-pkgs,
  ...
}:

{
  home.pointerCursor = {
    name = "Breeze Light";
    # name = "Breeze Dark";
    size = 24;
    package = kde-svg-cursor2hyprcursor-pkgs.breeze-light-hyprcursor;
    gtk.enable = true;
    x11.enable = true;
    hyprcursor.enable = true;
  };
  home.packages = [
    kde-svg-cursor2hyprcursor-pkgs.breeze-dark-hyprcursor
    kde-svg-cursor2hyprcursor-pkgs.breeze-light-hyprcursor
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        # color-scheme = "prefer-dark";
        accent-color = "green";
      };
      # "org/gnome/desktop/wm/preferences".button-layout= "menu:close";
    };
  };
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
    colorScheme = "dark";
    gtk2.extraConfig = ''
      gtk-application-prefer-dark-theme = true;
    '';
    gtk3 = {
      extraConfig = {
        "gtk-decoration-layout" = "menu:close";
      };
    };
    gtk4 = {
      theme = config.gtk.theme;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };
  # TODO: still don't know how to use breeze dark
  qt = {
    enable = true;
    platformTheme.name = "kde";
    style = {
      name = "breeze";
      package = with pkgs; [
        kdePackages.breeze
        kdePackages.breeze-icons
        # libsForQt5.breeze-qt5
      ];
    };
  };
}
