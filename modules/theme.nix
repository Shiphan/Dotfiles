{ pkgs, ... }:

{
  # TODO: cursor in gnome gtk app is bigger
  home.pointerCursor = {
    name = "Breeze_Light";
    size = 24;
    package = (pkgs.stdenv.mkDerivation {
      name = "breeze-hyprcursor";
      src = pkgs.kdePackages.breeze;
      nativeBuildInputs = with pkgs; [
        hyprcursor
        xcur2png
      ];
      installPhase = ''
        hyprcursor-util --extract share/icons/Breeze_Light --output .
        sed -i 1s/Extracted\ Theme/Breeze_Light/g extracted_Breeze_Light/manifest.hl
        mkdir target
        hyprcursor-util --create extracted_Breeze_Light --output target
        mkdir -p $out/share/icons
        mv target/theme_Breeze_Light $out/share/icons/Breeze_Light
        ln -s ${pkgs.kdePackages.breeze}/share/icons/Breeze_Light/* $out/share/icons/Breeze_Light/
      '';
    }) ;
    gtk.enable = true;
    x11.enable = true;
    hyprcursor.enable = true;
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
